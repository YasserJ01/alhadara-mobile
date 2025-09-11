// lib/features/news_feed/presentation/widgets/news_feed_item.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:project2/l10n/generated/app_localizations.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/theme/app_theme_helper.dart';
import '../../../../theme/presentation/bloc/theme_bloc.dart';
import '../../../../theme/presentation/bloc/theme_state.dart';
import '../../domain/entities/news_feed_entity.dart';
// lib/features/news_feed/presentation/widgets/news_feed_item.dart

class NewsFeedItem extends StatelessWidget {
  final NewsFeedEntity item;
  final VoidCallback onTap;
  final Function(String url, String fileName) onDownload;
  final Function(String url) onOpenTelegramLink;

  const NewsFeedItem({
    Key? key,
    required this.item,
    required this.onTap,
    required this.onDownload,
    required this.onOpenTelegramLink,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        Color cardColor = Colors.white;
        Color textColor = AppColors.mainColor;
        Color secondaryTextColor = Colors.grey[600]!;

        if (themeState is ThemeLoaded) {
          cardColor = AppThemeHelper.getCardColor(themeState.theme);
          textColor = AppThemeHelper.getTextColor(themeState.theme);
          secondaryTextColor = AppThemeHelper.getSecondaryTextColor(themeState.theme);
        }

        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          elevation: 4,
          color: cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: item.isInteractive ? onTap : null,
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: _getTypeColor(),
                    width: 6,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(textColor),
                    const SizedBox(height: 12),
                    _buildTitle(textColor),
                    const SizedBox(height: 8),
                    _buildContent(secondaryTextColor),
                    if (item.hasImage || item.hasFile) ...[
                      const SizedBox(height: 12),
                      _buildAttachment(context, textColor, secondaryTextColor),
                    ],
                    const SizedBox(height: 16),
                    _buildFooter(secondaryTextColor),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(Color textColor) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: _getTypeColor(),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                _getTypeIcon(),
                size: 16,
                color: Colors.white,
              ),
              const SizedBox(width: 6),
              Text(
                item.type.displayName.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        if (item.isInteractive)
          Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: textColor.withOpacity(0.6),
          ),
      ],
    );
  }

  Widget _buildTitle(Color textColor) {
    return Text(
      item.title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: textColor,
      ),
    );
  }

  Widget _buildContent(Color secondaryTextColor) {
    return Text(
      item.content,
      style: TextStyle(
        fontSize: 14,
        color: secondaryTextColor,
        height: 1.5,
      ),
    );
  }

  Widget _buildAttachment(BuildContext context, Color textColor, Color secondaryTextColor) {
    if (item.hasImage) {
      return _buildImageAttachment(context, textColor);
    } else if (item.hasFile) {
      return _buildFileAttachment(context, textColor, secondaryTextColor);
    }
    return const SizedBox();
  }

  Widget _buildImageAttachment(BuildContext context, Color textColor) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.network(
              item.image!,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey.shade200,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.image_not_supported,
                          size: 48,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Could not load image',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Positioned(
            bottom: 8,
            right: 8,
            child: FloatingActionButton.small(
              onPressed: () {
                final fileName = item.image!.split('/').last;
                onDownload(item.image!, fileName);
              },
              backgroundColor: Colors.white,
              child: Icon(
                Icons.download,
                color: textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFileAttachment(BuildContext context, Color textColor, Color secondaryTextColor) {
    final l10n = AppLocalizations.of(context);
    final fileName = item.fileUrl!.split('/').last;
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: secondaryTextColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: secondaryTextColor.withOpacity(0.3)),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _getTypeColor().withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.insert_drive_file,
                  color: _getTypeColor(),
                  size: 28,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      fileName,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: textColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      l10n.chooseDownloadMethod,
                      style: TextStyle(
                        fontSize: 12,
                        color: secondaryTextColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                icon: Icon(Icons.download, size: 18, color: textColor),
                label: Text(l10n.directDownload, style: TextStyle(color: textColor)),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: textColor),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                onPressed: () {
                  onDownload(item.fileUrl!, fileName);
                },
              ),
            ),
            if (item.hasTelegramFile) ...[
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton.icon(
                  icon: Icon(Icons.telegram, size: 18, color: textColor),
                  label: Text(l10n.viaTelegram, style: TextStyle(color: textColor)),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: textColor),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  onPressed: () {
                    onOpenTelegramLink(item.telegramDownloadLink!);
                  },
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildFooter(Color secondaryTextColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          DateFormat('MMM dd, yyyy • hh:mm a').format(item.createdAt),
          style: TextStyle(
            fontSize: 12,
            color: secondaryTextColor,
          ),
        ),
        if (item.author != null)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: secondaryTextColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.person_outline,
                  size: 14,
                  color: secondaryTextColor,
                ),
                const SizedBox(width: 6),
                Text(
                  item.author.toString(),
                  style: TextStyle(
                    fontSize: 12,
                    color: secondaryTextColor,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Color _getTypeColor() {
    switch (item.type) {
      case NewsFeedType.homework:
        return Colors.orange.shade600;
      case NewsFeedType.quiz:
        return Colors.purple.shade600;
      case NewsFeedType.message:
        return Colors.blue.shade600;
      case NewsFeedType.image:
        return Colors.green.shade600;
      case NewsFeedType.file:
        return Colors.red.shade600;
    }
  }

  IconData _getTypeIcon() {
    switch (item.type) {
      case NewsFeedType.homework:
        return Icons.assignment;
      case NewsFeedType.quiz:
        return Icons.quiz;
      case NewsFeedType.message:
        return Icons.message;
      case NewsFeedType.image:
        return Icons.image;
      case NewsFeedType.file:
        return Icons.attach_file;
    }
  }
}
//
// class NewsFeedItem extends StatelessWidget {
//   final NewsFeedEntity item;
//   final VoidCallback onTap;
//   final Function(String url, String fileName) onDownload;
//
//   const NewsFeedItem({
//     Key? key,
//     required this.item,
//     required this.onTap,
//     required this.onDownload,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: 12),
//       elevation: 2,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: InkWell(
//         borderRadius: BorderRadius.circular(12),
//         onTap: item.isInteractive ? onTap : null,
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _buildHeader(),
//               const SizedBox(height: 8),
//               _buildTitle(),
//               const SizedBox(height: 8),
//               _buildContent(),
//               if (item.hasImage || item.hasFile) ...[
//                 const SizedBox(height: 12),
//                 _buildAttachment(context),
//               ],
//               const SizedBox(height: 12),
//               _buildFooter(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildHeader() {
//     return Row(
//       children: [
//         Container(
//           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//           decoration: BoxDecoration(
//             color: _getTypeColor(),
//             borderRadius: BorderRadius.circular(20),
//           ),
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Icon(
//                 _getTypeIcon(),
//                 size: 16,
//                 color: Colors.white,
//               ),
//               const SizedBox(width: 6),
//               Text(
//                 item.type.displayName,
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 12,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         const Spacer(),
//         if (item.isInteractive)
//           const Icon(
//             Icons.arrow_forward_ios,
//             size: 16,
//             color: Colors.grey,
//           ),
//       ],
//     );
//   }
//
//   Widget _buildTitle() {
//     return Text(
//       item.title,
//       style: const TextStyle(
//         fontSize: 18,
//         fontWeight: FontWeight.bold,
//         color: Colors.black87,
//       ),
//     );
//   }
//
//   Widget _buildContent() {
//     return Text(
//       item.content,
//       style: const TextStyle(
//         fontSize: 14,
//         color: Colors.black54,
//         height: 1.5,
//       ),
//     );
//   }
//
//   Widget _buildAttachment(BuildContext context) {
//     if (item.hasImage) {
//       return _buildImageAttachment(context);
//     } else if (item.hasFile) {
//       return _buildFileAttachment(context);
//     }
//     return const SizedBox();
//   }
//
//   Widget _buildImageAttachment(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       height: 200,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(color: Colors.grey.shade300),
//       ),
//       child: Stack(
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.circular(8),
//             child: Image.network(
//               item.image!,
//               width: double.infinity,
//               height: 200,
//               fit: BoxFit.cover,
//               errorBuilder: (context, error, stackTrace) {
//                 return Container(
//                   color: Colors.grey.shade200,
//                   child: const Center(
//                     child: Icon(
//                       Icons.image_not_supported,
//                       size: 48,
//                       color: Colors.grey,
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//           Positioned(
//             top: 8,
//             right: 8,
//             child: IconButton(
//               onPressed: () {
//                 final fileName = item.image!.split('/').last;
//                 onDownload(item.image!, fileName);
//               },
//               icon: const Icon(
//                 Icons.download,
//                 color: Colors.white,
//               ),
//               style: IconButton.styleFrom(
//                 backgroundColor: Colors.black.withOpacity(0.6),
//                 padding: const EdgeInsets.all(8),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildFileAttachment(BuildContext context) {
//     final fileName = item.file!.split('/').last;
//     return Container(
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.grey.shade100,
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(color: Colors.grey.shade300),
//       ),
//       child: Row(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               color: Colors.blue.shade100,
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Icon(
//               Icons.insert_drive_file,
//               color: Colors.blue.shade600,
//               size: 24,
//             ),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   fileName,
//                   style: const TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.black87,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   'Tap to download',
//                   style: TextStyle(
//                     fontSize: 12,
//                     color: Colors.grey.shade600,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           IconButton(
//             onPressed: () {
//               onDownload(item.file!, fileName);
//             },
//             icon: const Icon(
//               Icons.download,
//               color: Colors.blue,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildFooter() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           DateFormat('MMM dd, yyyy • hh:mm a').format(item.createdAt),
//           style: TextStyle(
//             fontSize: 12,
//             color: Colors.grey.shade600,
//           ),
//         ),
//         if (item.author != null)
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//             decoration: BoxDecoration(
//               color: Colors.grey.shade200,
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Text(
//               'Author: ${item.author}',
//               style: const TextStyle(
//                 fontSize: 11,
//                 color: Colors.black54,
//               ),
//             ),
//           ),
//       ],
//     );
//   }
//
//   Color _getTypeColor() {
//     switch (item.type) {
//       case NewsFeedType.homework:
//         return Colors.orange;
//       case NewsFeedType.quiz:
//         return Colors.purple;
//       case NewsFeedType.message:
//         return Colors.blue;
//       case NewsFeedType.image:
//         return Colors.green;
//       case NewsFeedType.file:
//         return Colors.red;
//     }
//   }
//
//   IconData _getTypeIcon() {
//     switch (item.type) {
//       case NewsFeedType.homework:
//         return Icons.assignment;
//       case NewsFeedType.quiz:
//         return Icons.quiz;
//       case NewsFeedType.message:
//         return Icons.message;
//       case NewsFeedType.image:
//         return Icons.image;
//       case NewsFeedType.file:
//         return Icons.attach_file;
//     }
//   }
// }
