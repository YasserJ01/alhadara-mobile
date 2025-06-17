// features/profile/presentation/pages/create_profile_university_page.dart
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('University & Study Field'),
      ),
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
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),
                        DropdownButtonFormField<University>(
                          value: _selectedUniversity,
                          decoration:
                              const InputDecoration(labelText: 'University'),
                          items: _universities.map((university) {
                            return DropdownMenuItem(
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
                        const SizedBox(height: 16),
                        DropdownButtonFormField<Studyfield>(
                          value: _selectedStudyfield,
                          decoration:
                              const InputDecoration(labelText: 'Study Field'),
                          items: _studyfields.map((studyfield) {
                            return DropdownMenuItem(
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
                        const SizedBox(height: 32),
                        ElevatedButton(
                          onPressed: _createProfile,
                          child: const Text('Create Profile'),
                        ),
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
