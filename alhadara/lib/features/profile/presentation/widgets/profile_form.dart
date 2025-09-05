import 'package:alhadara/dependencies.dart';
import 'package:alhadara/features/profile/domain/entity/create_profile_request.dart';
import 'package:alhadara/features/profile/domain/entity/profile.dart';
import 'package:alhadara/features/profile/domain/entity/studyfield.dart';
import 'package:alhadara/features/profile/domain/entity/university.dart';
import 'package:alhadara/features/profile/domain/repositories/profile_repository.dart';
import 'package:alhadara/features/profile/presentation/bloc/update_profile/update_profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:alhadara/core/constants/colors.dart';
import 'package:alhadara/core/constants/app_elevated_button.dart';
import '../bloc/create_profile/create_profile_bloc.dart';

class ProfileForm extends StatefulWidget {
  final Profile? profile;
  final bool isEditing;

  const ProfileForm({Key? key, this.profile, this.isEditing = false})
      : super(key: key);

  @override
  _ProfileFormState createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final _birthDateController = TextEditingController();
  final _addressController = TextEditingController();

  String? _selectedGender;
  String? _selectedAcademicStatus;
  int? _selectedUniversity;
  int? _selectedStudyfield;

  List<University> _universities = [];
  List<Studyfield> _studyfields = [];

  bool _isLoadingUniversities = false;
  bool _isLoadingStudyfields = false;

  @override
  void initState() {
    super.initState();
    if (widget.isEditing && widget.profile != null) {
      _birthDateController.text =
          _formatDateForInput(widget.profile!.birthDate);
      _addressController.text = widget.profile!.address;
      _selectedGender = widget.profile!.gender;
      _selectedAcademicStatus = widget.profile!.academicStatus;
      _selectedUniversity = widget.profile!.university;
      _selectedStudyfield = widget.profile!.studyfield;
    }

    // تحميل الجامعات والتخصصات
    _loadUniversities();
    _loadStudyfields();
  }

  String _formatDateForInput(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return DateFormat('yyyy-MM-dd').format(date);
    } catch (e) {
      return dateString;
    }
  }

  Future<void> _loadUniversities() async {
    setState(() {
      _isLoadingUniversities = true;
    });

    try {
      final repository = getIt<ProfileRepository>();
      final universities = await repository.getUniversities();
      setState(() {
        _universities = universities;
        _isLoadingUniversities = false;
      });
    } catch (e) {
      setState(() {
        _isLoadingUniversities = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to load universities')),
      );
    }
  }

  Future<void> _loadStudyfields() async {
    setState(() {
      _isLoadingStudyfields = true;
    });

    try {
      final repository = getIt<ProfileRepository>();
      final studyfields = await repository.getStudyfields();
      setState(() {
        _studyfields = studyfields;
        _isLoadingStudyfields = false;
      });
    } catch (e) {
      setState(() {
        _isLoadingStudyfields = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to load study fields')),
      );
    }
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:
          DateTime.now().subtract(const Duration(days: 6570)), // 18 years ago
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.mainColor,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.mainColor,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _birthDateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final request = CreateProfileRequest(
        birthDate: _birthDateController.text,
        gender: _selectedGender!,
        address: _addressController.text,
        academicStatus: _selectedAcademicStatus!,
        university: _selectedUniversity,
        studyfield: _selectedStudyfield,
      );

      if (widget.isEditing) {
        context.read<UpdateProfileBloc>().add(
              UpdateProfileSubmitted(
                profileId: widget.profile!.id,
                request: request,
              ),
            );
      } else {
        context.read<CreateProfileBloc>().add(
              CreateProfileSubmitted(
                birthDate: _birthDateController.text,
                gender: _selectedGender!,
                address: _addressController.text,
                academicStatus: _selectedAcademicStatus!,
                university: _selectedUniversity,
                studyfield: _selectedStudyfield,
              ),
            );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
             
              // تاريخ الميلاد
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.mainColor.withOpacity(0.3),
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.mainColor.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: TextFormField(
                  controller: _birthDateController,
                  decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.mainColor),
                    ),
                    labelText: 'Birth Date',
                    labelStyle: TextStyle(
                      color: Color.fromARGB(255, 201, 89, 89),
                      fontSize: 18,
                    ),
                    suffixIcon: Icon(
                      Icons.calendar_today,
                      color: AppColors.mainColor,
                    ),
                  ),
                  style: TextStyle(
                    color: _birthDateController.text.isEmpty
                        ? Colors.grey
                        : Colors.black,
                  ),
                  readOnly: true,
                  onTap: _selectDate,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select your birth date';
                    }
                    return null;
                  },
                ),
              ),

              const SizedBox(height: 16),

              // الجنس
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.mainColor.withOpacity(0.3),
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.mainColor.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: DropdownButtonFormField<String>(
                  dropdownColor: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  elevation: 8,
                  value: _selectedGender,
                  icon: Container(
                    padding: const EdgeInsets.symmetric(vertical: 0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.mainColor.withOpacity(0.1),
                    ),
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: AppColors.mainColor,
                      size: 24,
                    ),
                  ),
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  hint: Text(
                    'Select your gender',
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 16,
                    ),
                  ),
                  decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.mainColor),
                    ),
                    labelText: 'Gender',
                    labelStyle: TextStyle(
                      color: Color.fromARGB(255, 201, 89, 89),
                      fontSize: 18,
                    ),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'male', child: Text('Male')),
                    DropdownMenuItem(value: 'female', child: Text('Female')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select your gender';
                    }
                    return null;
                  },
                ),
              ),

              const SizedBox(height: 16),

              // العنوان
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.mainColor.withOpacity(0.3),
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.mainColor.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: TextFormField(
                  controller: _addressController,
                  decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.mainColor),
                    ),
                    labelText: 'Address',
                    labelStyle: TextStyle(
                      color: Color.fromARGB(255, 201, 89, 89),
                      fontSize: 18,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your address';
                    }
                    return null;
                  },
                ),
              ),

              const SizedBox(height: 16),

              // الحالة الأكاديمية
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.mainColor.withOpacity(0.3),
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.mainColor.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: DropdownButtonFormField<String>(
                  dropdownColor: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  elevation: 8,
                  icon: Container(
                    padding: const EdgeInsets.symmetric(vertical: 0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.mainColor.withOpacity(0.1),
                    ),
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: AppColors.mainColor,
                      size: 24,
                    ),
                  ),
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  hint: Text(
                    'Select your academic status',
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 16,
                    ),
                  ),
                  value: _selectedAcademicStatus,
                  decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.mainColor),
                    ),
                    labelText: 'Academic Status',
                    labelStyle: TextStyle(
                      color: Color.fromARGB(255, 201, 89, 89),
                      fontSize: 18,
                    ),
                  ),
                  items: const [
                    DropdownMenuItem(
                        value: 'high_school', child: Text('High School')),
                    DropdownMenuItem(
                        value: 'not_studying', child: Text('Not Studying')),
                    DropdownMenuItem(
                        value: 'undergraduate', child: Text('Undergraduate')),
                    DropdownMenuItem(
                        value: 'graduate', child: Text('Graduate')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedAcademicStatus = value;
                      // إذا اختار "ليس طالبًا" أو "ثانوية عامة"، قم بإعادة تعيين الجامعة والتخصص
                      if (value == 'not_studying' || value == 'high_school') {
                        _selectedUniversity = null;
                        _selectedStudyfield = null;
                      }
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select your academic status';
                    }
                    return null;
                  },
                ),
              ),

              const SizedBox(height: 16),

              // الجامعة (تظهر فقط إذا لم يكن "ليس طالبًا" أو "ثانوية عامة")
              if (_selectedAcademicStatus != 'not_studying' &&
                  _selectedAcademicStatus != 'high_school')
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.mainColor.withOpacity(0.3),
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.mainColor.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      )
                    ],
                  ),
                  child: _isLoadingUniversities
                      ? const Center(child: CircularProgressIndicator())
                      : DropdownButtonFormField<int>(
                          dropdownColor: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          elevation: 8,
                          icon: Container(
                            padding: const EdgeInsets.symmetric(vertical: 0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.mainColor.withOpacity(0.1),
                            ),
                            child: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: AppColors.mainColor,
                              size: 24,
                            ),
                          ),
                          style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          hint: Text(
                            'Select your university',
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 16,
                            ),
                          ),
                          value: _selectedUniversity,
                          decoration: const InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColors.mainColor),
                            ),
                            labelText: 'University',
                            labelStyle: TextStyle(
                              color: Color.fromARGB(255, 201, 89, 89),
                              fontSize: 18,
                            ),
                          ),
                          items: _universities.map((university) {
                            return DropdownMenuItem<int>(
                              value: university.id,
                              child: Text(university.name),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedUniversity = value;
                            });
                          },
                          validator: (value) {
                            if ((_selectedAcademicStatus != 'not_studying' &&
                                    _selectedAcademicStatus != 'high_school') &&
                                (value == null || value == 0)) {
                              return 'Please select university';
                            }
                            return null;
                          },
                        ),
                ),

              if (_selectedAcademicStatus != 'not_studying' &&
                  _selectedAcademicStatus != 'high_school')
                const SizedBox(height: 16),

              // التخصص (تظهر فقط إذا لم يكن "ليس طالبًا" أو "ثانوية عامة")
              if (_selectedAcademicStatus != 'not_studying' &&
                  _selectedAcademicStatus != 'high_school')
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.mainColor.withOpacity(0.3),
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.mainColor.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      )
                    ],
                  ),
                  child: _isLoadingStudyfields
                      ? const Center(child: CircularProgressIndicator())
                      : DropdownButtonFormField<int>(
                          dropdownColor: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          elevation: 8,
                          icon: Container(
                            padding: const EdgeInsets.symmetric(vertical: 0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.mainColor.withOpacity(0.1),
                            ),
                            child: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: AppColors.mainColor,
                              size: 24,
                            ),
                          ),
                          style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          hint: Text(
                            'Select your study field',
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 16,
                            ),
                          ),
                          value: _selectedStudyfield,
                          decoration: const InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColors.mainColor),
                            ),
                            labelText: 'Study Field',
                            labelStyle: TextStyle(
                              color: Color.fromARGB(255, 201, 89, 89),
                              fontSize: 18,
                            ),
                          ),
                          items: _studyfields.map((studyfield) {
                            return DropdownMenuItem<int>(
                              value: studyfield.id,
                              child: Text(studyfield.name),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedStudyfield = value;
                            });
                          },
                          validator: (value) {
                            if ((_selectedAcademicStatus != 'not_studying' &&
                                    _selectedAcademicStatus != 'high_school') &&
                                (value == null || value == 0)) {
                              return 'Please select study field';
                            }
                            return null;
                          },
                        ),
                ),

              const SizedBox(height: 32),

              // زر الحفظ
              BlocConsumer<UpdateProfileBloc, UpdateProfileState>(
                listener: (context, state) {
                  if (state is UpdateProfileSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Profile updated successfully')),
                    );
                    Navigator.pop(context, true);
                  } else if (state is UpdateProfileError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                  }
                },
                builder: (context, state) {
                  if (widget.isEditing) {
                    return AppElevatedButton(
                      onPressed:
                          state is UpdateProfileLoading ? null : _submitForm,
                      child: state is UpdateProfileLoading
                          ? const CircularProgressIndicator()
                          : const Text(
                              'Update Profile',
                              style: TextStyle(fontSize: 18),
                            ),
                    );
                  } else {
                    return BlocConsumer<CreateProfileBloc, CreateProfileState>(
                      listener: (context, state) {
                        if (state is CreateProfileSuccess) {
                          Navigator.pop(context, true);
                        } else if (state is CreateProfileError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.message)),
                          );
                        }
                      },
                      builder: (context, state) {
                        return AppElevatedButton(
                          onPressed: state is CreateProfileLoading
                              ? null
                              : _submitForm,
                          child: state is CreateProfileLoading
                              ? const CircularProgressIndicator()
                              : const Text(
                                  'Create Profile',
                                  style: TextStyle(fontSize: 18),
                                ),
                        );
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _birthDateController.dispose();
    _addressController.dispose();
    super.dispose();
  }
}
