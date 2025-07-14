// lib/features/news_feed/presentation/utils/file_utils.dart
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FileUtils {
  static Future<String> getDownloadPath() async {
    Directory? directory;

    if (Platform.isAndroid) {
      directory = await getExternalStorageDirectory();
    } else if (Platform.isIOS) {
      directory = await getApplicationDocumentsDirectory();
    }

    return directory?.path ?? '';
  }

  static String getFileExtension(String fileName) {
    return fileName.split('.').last.toLowerCase();
  }

  static String getFileNameFromUrl(String url) {
    return url.split('/').last;
  }

  static bool isImageFile(String fileName) {
    final extension = getFileExtension(fileName);
    return ['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp'].contains(extension);
  }

  static bool isPdfFile(String fileName) {
    return getFileExtension(fileName) == 'pdf';
  }
}