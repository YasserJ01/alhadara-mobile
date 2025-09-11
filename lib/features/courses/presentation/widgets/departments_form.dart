// // // lib/features/courses/presentation/widgets/departments_form.dart
//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:project2/features/courses/presentation/pages/course_types_page.dart';
// import '../../../../core/constants/app_size.dart';
// import '../bloc/department_bloc/departments_bloc.dart';
//
// class DepartmentsForm extends StatelessWidget {
//   const DepartmentsForm({super.key});
//
//   IconData _getDepartmentIcon(String departmentName) {
//     switch (departmentName.toLowerCase()) {
//       case 'design':
//         return Icons.design_services;
//       case 'computers':
//         return Icons.computer;
//       case 'charter':
//         return Icons.assignment;
//       case 'cooks':
//         return Icons.restaurant;
//       case 'hotel booking':
//         return Icons.hotel;
//       default:
//         return Icons.school;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final padding = AppSizes.screenWidth(context) * 0.04; // 4% of screen width
//
//     return BlocBuilder<DepartmentsBloc, DepartmentsState>(
//       builder: (context, state) {
//         if (state is DepartmentsInitial || state is DepartmentsLoading) {
//           return const Center(child: CircularProgressIndicator());
//         } else if (state is DepartmentsError) {
//           return Center(child: Text(state.message));
//         } else if (state is DepartmentsEmpty) {
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Icon(
//                   Icons.search_off,
//                   size: 60,
//                   color: Color.fromRGBO(162, 12, 13, 1.0),
//                 ),
//                 const SizedBox(height: 16),
//                 Text(
//                   state.message,
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 18,
//                     color: Colors.grey[600],
//                   ),
//                 ),
//               ],
//             ),
//           );
//         } else if (state is DepartmentsLoaded) {
//           // print(state.departments);
//           return Padding(
//             padding: EdgeInsets.symmetric(horizontal: padding),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(height: AppSizes.screenHeight(context) * 0.02),
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: state.departments.length,
//                     itemBuilder: (context, index) {
//                       final department = state.departments[index];
//                       final iconSize = AppSizes.screenWidth(context) * 0.06;
//                       final containerSize =
//                           AppSizes.screenWidth(context) * 0.12;
//                       return Card(
//                         margin: EdgeInsets.symmetric(
//                           vertical: AppSizes.screenHeight(context) * 0.01,
//                         ),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         elevation: 1,
//                         child: ListTile(
//                           contentPadding: EdgeInsets.symmetric(
//                             horizontal: padding,
//                             vertical: AppSizes.screenHeight(context) * 0.01,
//                           ),
//                           leading: Container(
//                             width: containerSize,
//                             height: containerSize,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(100),
//                               color: const Color.fromARGB(255, 247, 222, 224),
//                             ),
//                             child: Icon(
//                               _getDepartmentIcon(department.name),
//                               size: iconSize,
//                               color: const Color.fromRGBO(162, 12, 13, 1.0),
//                             ),
//                           ),
//                           trailing: Container(
//                             width: containerSize,
//                             height: containerSize,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(100),
//                               color: Colors.grey.shade200,
//                             ),
//                             child: Icon(
//                               Icons.keyboard_arrow_right_rounded,
//                               size: iconSize,
//                               color: Colors.grey.shade800,
//                             ),
//                           ),
//                           title: Text(
//                             department.name,
//                             style: TextStyle(
//                               fontSize: AppSizes.screenWidth(context) * 0.045,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                           subtitle: Text(
//                             department.description,
//                             style: TextStyle(
//                               fontSize: AppSizes.screenWidth(context) * 0.035,
//                               color: Colors.grey.shade600,
//                             ),
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => CourseTypesPage(
//                                   departmentId: department
//                                       .id, // Pass the actual department ID here
//                                 ),
//                               ),
//                             );
//                             // Navigate to department detail or courses in this department
//                           },
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           );
//         }
//         return const SizedBox.shrink();
//       },
//     );
//   }
// }
// // lib/features/courses/presentation/widgets/departments_form.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/features/courses/presentation/pages/course_types_page.dart';
import 'package:project2/l10n/generated/app_localizations.dart';
import '../../../../core/constants/app_size.dart';
import '../../domain/entites/department.dart';
import '../bloc/department_bloc/departments_bloc.dart';

class DepartmentsForm extends StatelessWidget {
  const DepartmentsForm({super.key});

  IconData _getDepartmentIcon(String departmentName) {
    switch (departmentName.toLowerCase()) {
      case 'design':
        return Icons.design_services;
      case 'computers':
        return Icons.computer;
      case 'charter':
        return Icons.assignment;
      case 'cooks':
        return Icons.restaurant;
      case 'hotel booking':
        return Icons.hotel;
      default:
        return Icons.school;
    }
  }

  Widget _buildOfflineBanner(BuildContext context, bool isOffline, DateTime? lastUpdated) {
    final l10n = AppLocalizations.of(context);
    if (!isOffline) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.screenWidth(context) * 0.04,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.orange.shade100,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(8)),
        border: Border.all(color: Colors.orange.shade300, width: 1),
      ),
      child: Row(
        children: [
          Icon(
            Icons.wifi_off,
            color: Colors.orange.shade700,
            size: 18,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              lastUpdated != null
                  ? '${l10n.offlineCachedDataFrom} ${_formatLastUpdated(lastUpdated)}'
                  : l10n.offlineCachedData,
              style: TextStyle(
                color: Colors.orange.shade800,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatLastUpdated(DateTime lastUpdated) {
    final now = DateTime.now();
    final difference = now.difference(lastUpdated);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'just now';
    }
  }

  Widget _buildErrorWidget(BuildContext context, DepartmentsError state) {
    final l10n = AppLocalizations.of(context);
    IconData errorIcon;
    Color errorColor;
    String actionText;

    switch (state.errorType) {
      case DepartmentsErrorType.network:
        errorIcon = Icons.wifi_off;
        errorColor = Colors.orange;
        actionText = l10n.retryWhenOnline;
        break;
      case DepartmentsErrorType.server:
        errorIcon = Icons.electrical_services;
        errorColor = Colors.red;
        actionText = l10n.retry;
        break;
      case DepartmentsErrorType.cache:
        errorIcon = Icons.storage;
        errorColor = Colors.grey;
        actionText = l10n.connectToInternet;
        break;
      default:
        errorIcon = Icons.error_outline;
        errorColor = Colors.red;
        actionText = l10n.retry;
    }

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.screenWidth(context) * 0.08,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              errorIcon,
              size: 60,
              color: errorColor,
            ),
            const SizedBox(height: 16),
            Text(
              state.message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                height: 1.4,
              ),
            ),
            if (state.errorType != DepartmentsErrorType.cache) ...[
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () {
                  context.read<DepartmentsBloc>().add(LoadDepartments());
                },
                icon: const Icon(Icons.refresh, size: 18),
                label: Text(actionText),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(162, 12, 13, 1.0),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDepartmentsList(
      BuildContext context,
      List<Department> departments,
      bool isOffline,
      DateTime? lastUpdated,
      ) {
    final padding = AppSizes.screenWidth(context) * 0.04;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildOfflineBanner(context, isOffline, lastUpdated),
        SizedBox(height: AppSizes.screenHeight(context) * 0.02),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              context.read<DepartmentsBloc>().add(RefreshDepartments());
              // Wait a bit for the refresh to complete
              await Future.delayed(const Duration(milliseconds: 1000));
            },
            color: const Color.fromRGBO(162, 12, 13, 1.0),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: padding),
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: departments.length,
                itemBuilder: (context, index) {
                  final department = departments[index];
                  final iconSize = AppSizes.screenWidth(context) * 0.06;
                  final containerSize = AppSizes.screenWidth(context) * 0.12;

                  return Card(
                    margin: EdgeInsets.symmetric(
                      vertical: AppSizes.screenHeight(context) * 0.01,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: isOffline ? 0.5 : 1, // Reduced elevation when offline
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: padding,
                        vertical: AppSizes.screenHeight(context) * 0.01,
                      ),
                      leading: Container(
                        width: containerSize,
                        height: containerSize,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: isOffline
                              ? const Color.fromARGB(255, 247, 222, 224).withOpacity(0.7)
                              : const Color.fromARGB(255, 247, 222, 224),
                        ),
                        child: Icon(
                          _getDepartmentIcon(department.name),
                          size: iconSize,
                          color: isOffline
                              ? const Color.fromRGBO(162, 12, 13, 0.7)
                              : const Color.fromRGBO(162, 12, 13, 1.0),
                        ),
                      ),
                      trailing: Container(
                        width: containerSize,
                        height: containerSize,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: isOffline
                              ? Colors.grey.shade200.withOpacity(0.7)
                              : Colors.grey.shade200,
                        ),
                        child: Icon(
                          Icons.keyboard_arrow_right_rounded,
                          size: iconSize,
                          color: isOffline
                              ? Colors.grey.shade600
                              : Colors.grey.shade800,
                        ),
                      ),
                      title: Text(
                        department.name,
                        style: TextStyle(
                          fontSize: AppSizes.screenWidth(context) * 0.045,
                          fontWeight: FontWeight.w500,
                          color: isOffline ? Colors.black87 : Colors.black,
                        ),
                      ),
                      subtitle: Text(
                        department.description,
                        style: TextStyle(
                          fontSize: AppSizes.screenWidth(context) * 0.035,
                          color: isOffline ? Colors.grey.shade500 : Colors.grey.shade600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CourseTypesPage(
                              departmentId: department.id,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DepartmentsBloc, DepartmentsState>(
      builder: (context, state) {
        if (state is DepartmentsInitial || state is DepartmentsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is DepartmentsError) {
          return _buildErrorWidget(context, state);
        } else if (state is DepartmentsEmpty) {
          return Column(
            children: [
              _buildOfflineBanner(context, state.isOffline, null),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        state.isOffline ? Icons.wifi_off : Icons.search_off,
                        size: 60,
                        color: state.isOffline
                            ? Colors.orange
                            : const Color.fromRGBO(162, 12, 13, 1.0),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        state.message,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        } else if (state is DepartmentsLoaded) {
          return _buildDepartmentsList(
            context,
            state.departments,
            state.isOffline,
            state.lastUpdated,
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

// class DepartmentsForm extends StatelessWidget {
//   const DepartmentsForm({super.key});
//
//   IconData _getDepartmentIcon(String departmentName) {
//     switch (departmentName.toLowerCase()) {
//       case 'design':
//         return Icons.design_services;
//       case 'computers':
//         return Icons.computer;
//       case 'charter':
//         return Icons.assignment;
//       case 'cooks':
//         return Icons.restaurant;
//       case 'hotel booking':
//         return Icons.hotel;
//       default:
//         return Icons.school;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final padding = AppSizes.screenWidth(context) * 0.04; // 4% of screen width
//
//     return BlocBuilder<DepartmentsBloc, DepartmentsState>(
//       builder: (context, state) {
//         if (state is DepartmentsInitial || state is DepartmentsLoading) {
//           return const Center(child: CircularProgressIndicator());
//         } else if (state is DepartmentsError) {
//           return Center(child: Text(state.message));
//         } else if (state is DepartmentsEmpty) {
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Icon(
//                   Icons.search_off,
//                   size: 60,
//                   color: Color.fromRGBO(162, 12, 13, 1.0),
//                 ),
//                 const SizedBox(height: 16),
//                 Text(
//                   state.message,
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 18,
//                     color: Colors.grey[600],
//                   ),
//                 ),
//               ],
//             ),
//           );
//         } else if (state is DepartmentsLoaded) {
//           // print(state.departments);
//           return Padding(
//             padding: EdgeInsets.symmetric(horizontal: padding),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(height: AppSizes.screenHeight(context) * 0.02),
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: state.departments.length,
//                     itemBuilder: (context, index) {
//                       final department = state.departments[index];
//                       final iconSize = AppSizes.screenWidth(context) * 0.06;
//                       final containerSize =
//                           AppSizes.screenWidth(context) * 0.12;
//                       return Card(
//                         margin: EdgeInsets.symmetric(
//                           vertical: AppSizes.screenHeight(context) * 0.01,
//                         ),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         elevation: 1,
//                         child: ListTile(
//                           contentPadding: EdgeInsets.symmetric(
//                             horizontal: padding,
//                             vertical: AppSizes.screenHeight(context) * 0.01,
//                           ),
//                           leading: Container(
//                             width: containerSize,
//                             height: containerSize,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(100),
//                               color: const Color.fromARGB(255, 247, 222, 224),
//                             ),
//                             child: Icon(
//                               _getDepartmentIcon(department.name),
//                               size: iconSize,
//                               color: const Color.fromRGBO(162, 12, 13, 1.0),
//                             ),
//                           ),
//                           trailing: Container(
//                             width: containerSize,
//                             height: containerSize,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(100),
//                               color: Colors.grey.shade200,
//                             ),
//                             child: Icon(
//                               Icons.keyboard_arrow_right_rounded,
//                               size: iconSize,
//                               color: Colors.grey.shade800,
//                             ),
//                           ),
//                           title: Text(
//                             department.name,
//                             style: TextStyle(
//                               fontSize: AppSizes.screenWidth(context) * 0.045,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                           subtitle: Text(
//                             department.description,
//                             style: TextStyle(
//                               fontSize: AppSizes.screenWidth(context) * 0.035,
//                               color: Colors.grey.shade600,
//                             ),
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => CourseTypesPage(
//                                   departmentId: department
//                                       .id, // Pass the actual department ID here
//                                 ),
//                               ),
//                             );
//                             // Navigate to department detail or courses in this department
//                           },
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           );
//         }
//         return const SizedBox.shrink();
//       },
//     );
//   }
// }