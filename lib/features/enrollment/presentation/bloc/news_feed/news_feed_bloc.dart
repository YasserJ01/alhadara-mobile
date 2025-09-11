// lib/features/news_feed/presentation/bloc/news_feed_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http; // Replace Dio with http
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:project2/features/enrollment/domain/entities/news_feed_entity.dart';
import 'dart:io';
import 'dart:typed_data';
import '../../../../../errors/expections.dart';
import '../../../domain/usecases/get_news_feed_usecase.dart';
import 'news_feed_event.dart';
import 'news_feed_state.dart';

class NewsFeedBloc extends Bloc<NewsFeedEvent, NewsFeedState> {
  final GetNewsFeedUseCase getNewsFeedUseCase;
  final http.Client client;

  NewsFeedBloc({
    required this.getNewsFeedUseCase,
    required this.client,
  }) : super(NewsFeedInitial()) {
    on<LoadNewsFeed>(_onLoadNewsFeed);
    on<RefreshNewsFeed>(_onRefreshNewsFeed);
    on<DownloadFile>(_onDownloadFile);
    on<NewsFeedItemAdded>(_onItemAdded);
  }

  // Add this new handler method
  void _onItemAdded(NewsFeedItemAdded event, Emitter<NewsFeedState> emit) {
    if (state is NewsFeedLoaded) {
      final currentItems = (state as NewsFeedLoaded).newsFeed;
      // Prevent duplicates
      if (!currentItems.any((item) => item.id == event.item.id)) {
        emit(NewsFeedLoaded([event.item, ...currentItems]));
      }
    }
  }

  Future<void> _onLoadNewsFeed(
      LoadNewsFeed event,
      Emitter<NewsFeedState> emit,
      ) async {
    emit(NewsFeedLoading());
    try {
      final newsFeed = await getNewsFeedUseCase(event.scheduleSlotId);
      emit(NewsFeedLoaded(newsFeed));
    } catch (e) {
      emit(NewsFeedError(_getErrorMessage(e)));
    }
  }

  Future<void> _onRefreshNewsFeed(
      RefreshNewsFeed event,
      Emitter<NewsFeedState> emit,
      ) async {
    try {
      final newsFeed = await getNewsFeedUseCase(event.scheduleSlotId);
      emit(NewsFeedLoaded(newsFeed));
    } catch (e) {
      emit(NewsFeedError(_getErrorMessage(e)));
    }
  }

  Future<void> _onDownloadFile(
      DownloadFile event,
      Emitter<NewsFeedState> emit,
      ) async {
    // Handle download from any state that contains newsFeed data
    List<NewsFeedEntity> currentNewsFeed = [];

    if (state is NewsFeedLoaded) {
      currentNewsFeed = (state as NewsFeedLoaded).newsFeed;
    } else if (state is NewsFeedDownloadSuccess) {
      currentNewsFeed = (state as NewsFeedDownloadSuccess).newsFeed;
    } else if (state is NewsFeedDownloadError) {
      currentNewsFeed = (state as NewsFeedDownloadError).newsFeed;
    } else {
      emit(NewsFeedError('Cannot download file at this time'));
      return;
    }

    if (currentNewsFeed.isNotEmpty) {
      emit(NewsFeedDownloading(currentNewsFeed, event.fileName));

      try {
        // Get appropriate download directory
        final downloadResult = await _getDownloadDirectory();
        if (downloadResult.directory == null) {
          emit(NewsFeedDownloadError(
            currentNewsFeed,
            downloadResult.error ?? 'Could not access download directory',
          ));
          return;
        }

        final downloadDir = downloadResult.directory!;

        // Ensure directory exists
        if (!await downloadDir.exists()) {
          await downloadDir.create(recursive: true);
        }

        // Create unique filename if file already exists
        final uniqueFileName = await _getUniqueFileName(downloadDir, event.fileName);
        final filePath = '${downloadDir.path}/$uniqueFileName';
        final file = File(filePath);

        // Download file
        final response = await client.get(Uri.parse(event.url));
        if (response.statusCode == 200) {
          await file.writeAsBytes(response.bodyBytes);

          // Verify file was created
          if (await file.exists()) {
            final fileSize = await file.length();
            final locationMessage = downloadResult.isPublicDownloads
                ? 'Downloads folder'
                : 'app storage';

            emit(NewsFeedDownloadSuccess(
              currentNewsFeed,
              'File downloaded successfully to $locationMessage (${_formatFileSize(fileSize)})',
            ));
          } else {
            emit(NewsFeedDownloadError(
              currentNewsFeed,
              'File download failed - could not save file',
            ));
          }
        } else {
          emit(NewsFeedDownloadError(
            currentNewsFeed,
            'Download failed: HTTP ${response.statusCode}',
          ));
        }
      } catch (e) {
        emit(NewsFeedDownloadError(
          currentNewsFeed,
          'Download failed: ${e.toString()}',
        ));
      }
    } else {
      emit(NewsFeedError('No news feed data available'));
    }
  }

  Future<DownloadDirectoryResult> _getDownloadDirectory() async {
    try {
      if (Platform.isAndroid) {
        final deviceInfo = DeviceInfoPlugin();
        final androidInfo = await deviceInfo.androidInfo;

        // For Android 10+ (API 29+), try to use public Downloads directory
        if (androidInfo.version.sdkInt >= 29) {
          // Check if we can access public Downloads directory
          final publicDownloads = Directory('/storage/emulated/0/Download');
          if (await publicDownloads.exists()) {
            try {
              // Test write access
              final testFile = File('${publicDownloads.path}/.test_write');
              await testFile.writeAsString('test');
              await testFile.delete();
              return DownloadDirectoryResult(
                directory: publicDownloads,
                isPublicDownloads: true,
              );
            } catch (e) {
              // Fall back to app-specific directory
            }
          }
        } else {
          // Android 9 and below - request storage permission
          final status = await Permission.storage.request();
          if (status.isGranted) {
            final publicDownloads = Directory('/storage/emulated/0/Download');
            if (await publicDownloads.exists()) {
              return DownloadDirectoryResult(
                directory: publicDownloads,
                isPublicDownloads: true,
              );
            }
          }
        }

        // Fallback to app-specific external storage
        final externalDir = await getExternalStorageDirectory();
        if (externalDir != null) {
          final appDownloads = Directory('${externalDir.path}/Downloads');
          return DownloadDirectoryResult(
            directory: appDownloads,
            isPublicDownloads: false,
          );
        }
      } else if (Platform.isIOS) {
        // iOS - use app documents directory
        final documentsDir = await getApplicationDocumentsDirectory();
        final appDownloads = Directory('${documentsDir.path}/Downloads');
        return DownloadDirectoryResult(
          directory: appDownloads,
          isPublicDownloads: false,
        );
      }
    } catch (e) {
      return DownloadDirectoryResult(
        directory: null,
        error: 'Error accessing download directory: $e',
      );
    }

    return DownloadDirectoryResult(
      directory: null,
      error: 'Could not determine download directory',
    );
  }

  Future<String> _getUniqueFileName(Directory directory, String fileName) async {
    final file = File('${directory.path}/$fileName');
    if (!await file.exists()) {
      return fileName;
    }

    // Extract name and extension
    final lastDotIndex = fileName.lastIndexOf('.');
    String name, extension;
    if (lastDotIndex != -1) {
      name = fileName.substring(0, lastDotIndex);
      extension = fileName.substring(lastDotIndex);
    } else {
      name = fileName;
      extension = '';
    }

    // Find unique filename
    int counter = 1;
    while (true) {
      final uniqueName = '$name ($counter)$extension';
      final uniqueFile = File('${directory.path}/$uniqueName');
      if (!await uniqueFile.exists()) {
        return uniqueName;
      }
      counter++;
    }
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }

  String _getErrorMessage(dynamic error) {
    if (error is ApiException) {
      return error.message;
    } else if (error is UnauthorizedException) {
      return 'Unauthorized access. Please login again.';
    } else if (error is NotFoundException) {
      return 'News feed not found.';
    } else if (error is ValidationException) {
      return 'Invalid request parameters.';
    } else if (error is ServerException) {
      return error.message;
    } else {
      return 'An unexpected error occurred. Please try again.';
    }
  }
}

class DownloadDirectoryResult {
  final Directory? directory;
  final bool isPublicDownloads;
  final String? error;

  DownloadDirectoryResult({
    required this.directory,
    this.isPublicDownloads = false,
    this.error,
  });
}