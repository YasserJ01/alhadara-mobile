// features/profile/presentation/pages/create_profile_university_page.dart
import 'package:alhadara/core/constants/app_elevated_button.dart';
import 'package:alhadara/core/constants/app_scaffold.dart';
import 'package:alhadara/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../dependencies.dart';
import '../../domain/entity/studyfield.dart';
import '../../domain/entity/university.dart';
import '../bloc/create_profile/create_profile_bloc.dart';
import '../bloc/interest_selection/interest_selection_bloc.dart';
import '../bloc/university_and_study_field_selection/university_studyfield_bloc.dart';
import '../bloc/university_and_study_field_selection/university_studyfield_event.dart';
import '../bloc/university_and_study_field_selection/university_studyfield_state.dart';
import 'interest_selection_page.dart';

//pages/create_profile_university_page.dart
class CreateProfileUniversityPage extends StatefulWidget {
  final String birthDate;
  final String gender;
  final String address;
  final String academicStatus;

  const CreateProfileUniversityPage({
    Key? key,
    required this.birthDate,
    required this.gender,
    required this.address,
    required this.academicStatus,
  }) : super(key: key);

  @override
  State<CreateProfileUniversityPage> createState() =>
      _CreateProfileUniversityPageState();
}

class _CreateProfileUniversityPageState
    extends State<CreateProfileUniversityPage> {
  final _formKey = GlobalKey<FormState>();
  University? _selectedUniversity;
  Studyfield? _selectedStudyfield;
  List<University> _universities = [];
  List<Studyfield> _studyfields = [];

  @override
  void initState() {
    super.initState();
    context
        .read<UniversityStudyfieldBloc>()
        .add(LoadUniversitiesAndStudyfields());
  }

  void _createProfile() {
    if (_formKey.currentState!.validate()) {
      context.read<CreateProfileBloc>().add(CreateProfileSubmitted(
            birthDate: widget.birthDate,
            gender: widget.gender,
            address: widget.address,
            academicStatus: widget.academicStatus,
            university: _selectedUniversity!.id,
            studyfield: _selectedStudyfield!.id,
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Create profile ',
      body: MultiBlocListener(
        listeners: [
          BlocListener<CreateProfileBloc, CreateProfileState>(
            listener: (context, state) {
              if (state is CreateProfileSuccess) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => getIt<InterestSelectionBloc>(),
                      // or your DI method
                      child: InterestSelectionPage(profileId: state.profileId),
                    ),
                  ),
                );
                // ScaffoldMessenger.of(context).showSnackBar(
                //   const SnackBar(content: Text('Profile created successfully!')),
                // );
                // Navigator.popUntil(context, (route) => route.isFirst);
              } else if (state is CreateProfileError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
          ),
        ],
        child: BlocBuilder<UniversityStudyfieldBloc, UniversityStudyfieldState>(
          builder: (context, state) {
            if (state is UniversityStudyfieldLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is UniversitiesAndStudyfieldsLoaded) {
              _universities = state.universities;
              _studyfields = state.studyfields;
            }

            if (state is UniversitiesAndStudyfieldsError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.message),
                    ElevatedButton(
                      onPressed: () {
                        context
                            .read<UniversityStudyfieldBloc>()
                            .add(LoadUniversitiesAndStudyfields());
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'University & Study Field',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8), // Increased padding
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.mainColor
                                  .withOpacity(0.3), // Softer border color
                              width: 1.5, // Slightly thicker border
                            ),
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.mainColor
                                    .withOpacity(0.1), // Themed shadow color
                                spreadRadius: 2,
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              )
                            ],
                          ),
                          child: DropdownButtonFormField<University>(
                            dropdownColor: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            elevation: 8,
                            icon: Container(
                              padding: const EdgeInsets.symmetric(vertical: 0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.mainColor.withOpacity(
                                    0.1), // Circular icon background
                              ),
                              child: Icon(
                                Icons
                                    .keyboard_arrow_down_rounded, // Rounded arrow icon
                                color: AppColors.mainColor,
                                size: 24, // Larger icon
                              ),
                            ),
                            style: TextStyle(
                              color: Colors.grey[
                                  800], // Darker text for better readability
                              fontSize: 16, // Slightly larger font
                              fontWeight: FontWeight.w500,
                            ),
                            hint: Text(
                              'Select your university',
                              style: TextStyle(
                                color: Colors.grey[
                                    500], // Hint style when nothing is selected
                                fontSize: 16,
                              ),
                            ),
                            value: _selectedUniversity,
                            decoration: const InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: AppColors.mainColor)),
                                labelText: 'University',
                                labelStyle: TextStyle(
                                    color: Color.fromARGB(255, 201, 89, 89),
                                    fontSize: 16)),
                            items: _universities.map((university) {
                              return DropdownMenuItem(
                                alignment: Alignment.center,
                                value: university,
                                child: Text(university.name),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedUniversity = value;
                              });
                            },
                            validator: (value) {
                              if (value == null) {
                                return 'Please select a university';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8), // Increased padding
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.mainColor
                                  .withOpacity(0.3), // Softer border color
                              width: 1.5, // Slightly thicker border
                            ),
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.mainColor
                                    .withOpacity(0.1), // Themed shadow color
                                spreadRadius: 2,
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              )
                            ],
                          ),
                          child: DropdownButtonFormField<Studyfield>(
                            dropdownColor: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            elevation: 8,
                            icon: Container(
                              padding: const EdgeInsets.symmetric(vertical: 0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.mainColor.withOpacity(
                                    0.1), // Circular icon background
                              ),
                              child: Icon(
                                Icons
                                    .keyboard_arrow_down_rounded, // Rounded arrow icon
                                color: AppColors.mainColor,
                                size: 24, // Larger icon
                              ),
                            ),
                            style: TextStyle(
                              color: Colors.grey[
                                  800], // Darker text for better readability
                              fontSize: 16, // Slightly larger font
                              fontWeight: FontWeight.w500,
                            ),
                            hint: Text(
                              'Select your study field',
                              style: TextStyle(
                                color: Colors.grey[
                                    500], // Hint style when nothing is selected
                                fontSize: 16,
                              ),
                            ),
                            value: _selectedStudyfield,
                            decoration: const InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: AppColors.mainColor)),
                                labelText: 'Study Field',
                                labelStyle: TextStyle(
                                    color: Color.fromARGB(255, 201, 89, 89),
                                    fontSize: 18)),
                            items: _studyfields.map((studyfield) {
                              return DropdownMenuItem(
                                alignment: Alignment.center,
                                value: studyfield,
                                child: Text(studyfield.name),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedStudyfield = value;
                              });
                            },
                            validator: (value) {
                              if (value == null) {
                                return 'Please select a study field';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 300),
                        AppElevatedButton(
                          onPressed: _createProfile,
                          child: Text(
                            'Create Profile',
                            style: TextStyle(fontSize: 18),
                          ),
                        )
                        // ElevatedButton(
                        //   onPressed: _createProfile,
                        //   child: const Text('Create Profile'),
                        // ),
                      ],
                    ),
                  ),
                ),
                // Show loading overlay for create profile
                BlocBuilder<CreateProfileBloc, CreateProfileState>(
                  builder: (context, createState) {
                    if (createState is CreateProfileLoading) {
                      return Container(
                        color: Colors.black.withOpacity(0.3),
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
