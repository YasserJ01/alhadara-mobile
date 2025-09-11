// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:alhadara/core/constants/app_elevated_button.dart';
// import 'package:alhadara/core/constants/colors.dart';
// import 'package:alhadara/dependencies.dart';
// import 'package:alhadara/features/enrollment/presentation/bloc/enrollments/enrollment_bloc.dart';
// import 'package:alhadara/features/enrollment/domain/entities/enrollment_entity.dart';
// import '../bloc/complaint_bloc.dart';

// class ComplaintForm extends StatefulWidget {
//   final int? enrollmentId;

//   const ComplaintForm({this.enrollmentId, Key? key}) : super(key: key);

//   @override
//   State<ComplaintForm> createState() => _ComplaintFormState();
// }

// class _ComplaintFormState extends State<ComplaintForm> {
//   final _formKey = GlobalKey<FormState>();
//   final _titleController = TextEditingController();
//   final _descriptionController = TextEditingController();
//   String _selectedType = 'general';
//   int? _selectedCourseId;
//   bool _isSubmitting = false;

//   @override
//   void dispose() {
//     _titleController.dispose();
//     _descriptionController.dispose();
//     super.dispose();
//   }

//   Future<void> _submitComplaint(BuildContext context) async {
//     print(_selectedCourseId);
//     if (!_formKey.currentState!.validate()) return;

//     if ((_selectedType == 'course' || _selectedType == 'teacher') &&
//         _selectedCourseId == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please select a course')),
//       );
//       return;
//     }

//     setState(() => _isSubmitting = true);

//     final complaintData = {
//       'type': _selectedType,
//       'title': _titleController.text,
//       'description': _descriptionController.text,
//       // إرسال enrollment_id سواء كانت الشكوى عامة أو متعلقة بكورس/مدرس
//       'enrollment': _selectedCourseId,
//       // إضافة related_course فقط إذا كانت الشكوى متعلقة بكورس أو مدرس
//       if (_selectedType == 'course' || _selectedType == 'teacher')
//         'related_course': _selectedCourseId,
//     };

//     context
//         .read<ComplaintBloc>()
//         .add(SubmitComplaint(complaintData: complaintData));
//   }

//   Widget _buildCourseDropdown(BuildContext context) {
//     return BlocProvider(
//       create: (context) => getIt<EnrollmentBloc>()..add(FetchEnrollments()),
//       child: BlocBuilder<EnrollmentBloc, EnrollmentState>(
//         builder: (context, state) {
//           if (state is EnrollmentLoaded) {
//             final enrollments = state.enrollments.toList();

//             if (enrollments.isEmpty) {
//               return const Text('No active courses available');
//             }

//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(height: 16),
//                 Text(
//                   'Select Course*',
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: Colors.grey[800],
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                   decoration: BoxDecoration(
//                     border: Border.all(
//                       color: AppColors.mainColor.withOpacity(0.3),
//                       width: 1.5,
//                     ),
//                     borderRadius: BorderRadius.circular(12),
//                     color: Colors.white,
//                   ),
//                   child: DropdownButtonFormField<int>(
//                     value: _selectedCourseId,
//                     decoration: const InputDecoration(
//                       border: InputBorder.none,
//                       hintText: 'Select a course',
//                     ),
//                     items: enrollments.map((enrollment) {
//                       return DropdownMenuItem<int>(
//                         value: enrollment.id,
//                         child: Text(
//                           '${enrollment.courseTitle}',
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       );
//                     }).toList(),
//                     onChanged: (value) {
//                       setState(() {
//                         _selectedCourseId = value;
//                       });
//                     },
//                     validator: (value) {
//                       if ((_selectedType == 'course' ||
//                               _selectedType == 'teacher') &&
//                           value == null) {
//                         return 'Please select a course';
//                       }
//                       return null;
//                     },
//                   ),
//                 ),
//               ],
//             );
//           } else if (state is EnrollmentError) {
//             return Text('Error loading courses: ${state.message}');
//           }
//           return const CircularProgressIndicator();
//         },
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<ComplaintBloc, ComplaintState>(
//       listener: (context, state) {
//         if (state is ComplaintError) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text(state.message)),
//           );
//           setState(() => _isSubmitting = false);
//         }
//       },
//       child: Form(
//         key: _formKey,
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(1),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               const Text(
//                 'Submit Your Complaint',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.w700,
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Container(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                     color: AppColors.mainColor.withOpacity(0.3),
//                     width: 1.5,
//                   ),
//                   borderRadius: BorderRadius.circular(12),
//                   color: Colors.white,
//                   boxShadow: [
//                     BoxShadow(
//                       color: AppColors.mainColor.withOpacity(0.1),
//                       spreadRadius: 2,
//                       blurRadius: 12,
//                       offset: const Offset(0, 4),
//                     )
//                   ],
//                 ),
//                 child: DropdownButtonFormField<String>(
//                   value: _selectedType,
//                   onChanged: (value) {
//                     setState(() {
//                       _selectedType = value!;
//                       if (value != 'course' && value != 'teacher') {
//                         _selectedCourseId = null;
//                       }
//                     });
//                   },
//                   items: [
//                     DropdownMenuItem(
//                       value: 'general',
//                       child: Text(_capitalize('general')),
//                     ),
//                     DropdownMenuItem(
//                       value: 'teacher',
//                       child: Text(_capitalize('teacher')),
//                     ),
//                     DropdownMenuItem(
//                       value: 'course',
//                       child: Text(_capitalize('course')),
//                     ),
//                     DropdownMenuItem(
//                       value: 'technical',
//                       child: Text(_capitalize('technical')),
//                     ),
//                   ],
//                   decoration: const InputDecoration(
//                     border: InputBorder.none,
//                     labelText: 'Complaint Type*',
//                   ),
//                   validator: (value) {
//                     if (value == null) {
//                       return 'Please select a complaint type';
//                     }
//                     return null;
//                   },
//                 ),
//               ),
//               const SizedBox(height: 16),
//               TextFormField(
//                 controller: _titleController,
//                 decoration: _buildInputDecoration('Title*'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a title';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 16),
//               TextFormField(
//                 controller: _descriptionController,
//                 maxLines: 5,
//                 decoration: _buildInputDecoration('Description*'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a description';
//                   }
//                   return null;
//                 },
//               ),
//               if (_selectedType == 'course' || _selectedType == 'teacher')
//                 _buildCourseDropdown(context),
//               const SizedBox(height: 30),
//               _isSubmitting
//                   ? const Center(child: CircularProgressIndicator())
//                   : AppElevatedButton(
//                       onPressed: () => _submitComplaint(context),
//                       child: const Text(
//                         'Submit Complaint',
//                         style: TextStyle(fontSize: 18),
//                       ),
//                     ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   InputDecoration _buildInputDecoration(String label) {
//     return InputDecoration(
//       filled: true,
//       fillColor: Colors.white,
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: BorderSide(
//           color: AppColors.mainColor.withOpacity(0.3),
//           width: 1.5,
//         ),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: const BorderSide(
//           color: AppColors.mainColor,
//           width: 1.5,
//         ),
//       ),
//       labelText: label,
//       labelStyle: const TextStyle(
//         color: Color.fromARGB(255, 201, 89, 89),
//         fontSize: 16,
//       ),
//       alignLabelWithHint: true,
//     );
//   }

//   String _capitalize(String input) {
//     return "${input[0].toUpperCase()}${input.substring(1)}";
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_elevated_button.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/theme/app_theme_helper.dart';
import '../../../../dependencies.dart';
import '../../../../theme/data/models/theme_model.dart';
import '../../../../theme/presentation/bloc/theme_bloc.dart';
import '../../../../theme/presentation/bloc/theme_state.dart';
import '../../../enrollment/presentation/bloc/enrollments/enrollment_bloc.dart';
import 'package:project2/features/enrollment/domain/entities/enrollment_entity.dart';
import '../../../../core/constants/colors.dart';
import '../bloc/complaint_bloc.dart';

class ComplaintForm extends StatefulWidget {
  const ComplaintForm({Key? key}) : super(key: key);

  @override
  State<ComplaintForm> createState() => _ComplaintFormState();
}

class _ComplaintFormState extends State<ComplaintForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _selectedType = 'general';
  int? _selectedCourseId;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _submitComplaint(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;

    if ((_selectedType == 'course' || _selectedType == 'teacher') &&
        _selectedCourseId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a course')),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    final complaintData = {
      'type': _selectedType,
      'title': _titleController.text,
      'description': _descriptionController.text,
      if (_selectedType == 'course' || _selectedType == 'teacher')
        'enrollment': _selectedCourseId,
    };

    context
        .read<ComplaintBloc>()
        .add(SubmitComplaint(complaintData: complaintData));

    setState(() => _isSubmitting = false);
    _formKey.currentState?.reset();
  }

  Widget _buildCourseDropdown(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<EnrollmentBloc>()..add(FetchEnrollments()),
      child: BlocBuilder<EnrollmentBloc, EnrollmentState>(
        builder: (context, state) {
          if (state is EnrollmentLoaded) {
            final enrollments = state.enrollments.toList();
            if (enrollments.isEmpty) {
              return Text(
                'No active courses available',
                style: TextStyle(
                  color: AppThemeHelper.getSecondaryTextColor(ThemeModel.light()),
                ),
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                BlocBuilder<ThemeBloc, ThemeState>(
                  builder: (context, themeState) {
                    Color textColor = AppColors.mainColor;
                    if (themeState is ThemeLoaded) {
                      textColor = AppThemeHelper.getTextColor(themeState.theme);
                    }
                    return Text(
                      'Select Course',
                      style: TextStyle(
                        fontSize: 16,
                        color: textColor,
                        fontWeight: FontWeight.w500,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 8),
                BlocBuilder<ThemeBloc, ThemeState>(
                  builder: (context, themeState) {
                    Color borderColor = AppColors.mainColor.withOpacity(0.3);
                    Color backgroundColor = Colors.white;
                    Color textColor = Colors.black;

                    if (themeState is ThemeLoaded) {
                      borderColor = AppThemeHelper.getTextColor(themeState.theme).withOpacity(0.3);
                      backgroundColor = AppThemeHelper.getCardColor(themeState.theme);
                      textColor = AppThemeHelper.getTextColor(themeState.theme);
                    }

                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: borderColor,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        color: backgroundColor,
                      ),
                      child: DropdownButtonFormField<int>(
                        value: _selectedCourseId,
                        style: TextStyle(color: textColor),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Select a course',
                          hintStyle: TextStyle(
                            color: textColor.withOpacity(0.6),
                          ),
                        ),
                        items: enrollments.map((enrollment) {
                          return DropdownMenuItem<int>(
                            value: enrollment.id,
                            child: Text(
                              '${enrollment.courseTitle}',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: textColor),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedCourseId = value;
                          });
                        },
                        validator: (value) {
                          if ((_selectedType == 'course' ||
                              _selectedType == 'teacher') &&
                              value == null) {
                            return 'Please select a course';
                          }
                          return null;
                        },
                      ),
                    );
                  },
                ),
              ],
            );
          } else if (state is EnrollmentError) {
            return Text(
              'Error loading courses: ${state.message}',
              style: TextStyle(
                color: Colors.red,
              ),
            );
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        Color backgroundColor = const Color(0xffF4F8FB);
        Color cardColor = Colors.white;
        Color textColor = AppColors.mainColor;
        Color secondaryTextColor = Colors.grey[600]!;
        Color borderColor = AppColors.mainColor.withOpacity(0.3);

        if (themeState is ThemeLoaded) {
          backgroundColor = AppThemeHelper.getBackgroundColor(themeState.theme);
          cardColor = AppThemeHelper.getCardColor(themeState.theme);
          textColor = AppThemeHelper.getTextColor(themeState.theme);
          secondaryTextColor = AppThemeHelper.getSecondaryTextColor(themeState.theme);
          borderColor = textColor.withOpacity(0.3);
        }

        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Complaint Type Dropdown
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: borderColor,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  color: cardColor,
                  boxShadow: [
                    BoxShadow(
                      color: textColor.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: DropdownButtonFormField<String>(
                  value: _selectedType,
                  style: TextStyle(color: textColor),
                  onChanged: (value) {
                    setState(() {
                      _selectedType = value!;
                      if (value != 'course' && value != 'teacher') {
                        _selectedCourseId = null;
                      }
                    });
                  },
                  items: [
                    DropdownMenuItem(
                      value: 'general',
                      child: Text(_capitalize('general')),
                    ),
                    DropdownMenuItem(
                      value: 'teacher',
                      child: Text(_capitalize('teacher')),
                    ),
                    DropdownMenuItem(
                      value: 'course',
                      child: Text(_capitalize('course')),
                    ),
                    DropdownMenuItem(
                      value: 'technical',
                      child: Text(_capitalize('technical')),
                    ),
                  ],
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Complaint Type',
                    labelStyle: TextStyle(
                      color: textColor,
                      fontSize: 16,
                    ),
                  ),
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a complaint type';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 16),

              // Title Field
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: borderColor,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  color: cardColor,
                  boxShadow: [
                    BoxShadow(
                      color: textColor.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: TextFormField(
                  controller: _titleController,
                  style: TextStyle(color: textColor),
                  decoration: _buildInputDecoration('Title', textColor, secondaryTextColor),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 16),

              // Description Field
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: borderColor,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  color: cardColor,
                  boxShadow: [
                    BoxShadow(
                      color: textColor.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: TextFormField(
                  controller: _descriptionController,
                  style: TextStyle(color: textColor),
                  maxLines: 5,
                  decoration: _buildInputDecoration('Description', textColor, secondaryTextColor),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
              ),

              // Course Dropdown (conditionally shown)
              if (_selectedType == 'course' || _selectedType == 'teacher')
                _buildCourseDropdown(context),

              const SizedBox(height: 30),

              // Submit Button
              _isSubmitting
                  ? const Center(child: CircularProgressIndicator())
                  : AppElevatedButton(
                onPressed: () => _submitComplaint(context),
                child: Text(
                  'Submit Complaint',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  InputDecoration _buildInputDecoration(String label, Color textColor, Color secondaryTextColor) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.transparent,
      focusedBorder: UnderlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: textColor,
          width: 1.5,
        ),
      ),
      enabledBorder: UnderlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: secondaryTextColor.withOpacity(0.3),
          width: 1.5,
        ),
      ),
      labelText: label,
      labelStyle: TextStyle(
        color: textColor,
        fontSize: 16,
      ),
      alignLabelWithHint: true,
    );
  }

  String _capitalize(String input) {
    return "${input[0].toUpperCase()}${input.substring(1)}";
  }
}
