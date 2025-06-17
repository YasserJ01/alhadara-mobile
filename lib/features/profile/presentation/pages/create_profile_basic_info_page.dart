import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../dependencies.dart';
import '../bloc/create_profile/create_profile_bloc.dart';
import '../bloc/interest_selection/interest_selection_bloc.dart';
import '../bloc/university_and_study_field_selection/university_studyfield_bloc.dart';
import 'create_profile_university_page.dart';
import 'interest_selection_page.dart';

//pages/create_profile_basic_info_page.dart
class CreateProfileBasicInfoPage extends StatefulWidget {
  const CreateProfileBasicInfoPage({Key? key}) : super(key: key);

  @override
  State<CreateProfileBasicInfoPage> createState() =>
      _CreateProfileBasicInfoPageState();
}

class _CreateProfileBasicInfoPageState
    extends State<CreateProfileBasicInfoPage> {
  final _formKey = GlobalKey<FormState>();
  final _birthDateController = TextEditingController();
  final _addressController = TextEditingController();

  String? _selectedGender;
  String? _selectedAcademicStatus;
  DateTime? _selectedDate;

  final List<String> _genders = ['male', 'female'];
  final List<String> _academicStatuses = [
    'high_school',
    'not_studying',
    'undergraduate',
    'graduate'
  ];

  @override
  void dispose() {
    _birthDateController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 6570)),
      // 18 years ago
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _birthDateController.text =
            "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      });
    }
  }

  void _continue() {
    if (_formKey.currentState!.validate()) {
      if (_selectedAcademicStatus == 'high_school' ||
          _selectedAcademicStatus == 'not_studying') {
        // Create profile immediately
        context.read<CreateProfileBloc>().add(CreateProfileSubmitted(
              birthDate: _birthDateController.text,
              gender: _selectedGender!,
              address: _addressController.text,
              academicStatus: _selectedAcademicStatus!,
            ));
      } else {
        // Go to university and study field selection page with separate BLoC
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => getIt<UniversityStudyfieldBloc>(),
                ),
                BlocProvider(
                  create: (context) => getIt<CreateProfileBloc>(),
                ),
              ],
              child: CreateProfileUniversityPage(
                birthDate: _birthDateController.text,
                gender: _selectedGender!,
                address: _addressController.text,
                academicStatus: _selectedAcademicStatus!,
              ),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Profile'),
      ),
      body: BlocListener<CreateProfileBloc, CreateProfileState>(
        listener: (context, state) {
          if (state is CreateProfileSuccess) {
            // ScaffoldMessenger.of(context).showSnackBar(
            //   const SnackBar(content: Text('Profile created successfully!')),
            // );
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => InterestSelectionPage(
            //       profileId: state.profileId,
            //     ),
            //   ),
            // );
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
            // print(state.profileId);
            // Navigator.popUntil(context, (route) => route.isFirst);
          } else if (state is CreateProfileError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: BlocBuilder<CreateProfileBloc, CreateProfileState>(
          builder: (context, state) {
            if (state is CreateProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Basic Information',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _birthDateController,
                      decoration: const InputDecoration(
                        labelText: 'Birth Date',
                        suffixIcon: Icon(Icons.calendar_today),
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
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: _selectedGender,
                      decoration: const InputDecoration(labelText: 'Gender'),
                      items: _genders.map((gender) {
                        return DropdownMenuItem(
                          value: gender,
                          child: Text(gender.toUpperCase()),
                        );
                      }).toList(),
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
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _addressController,
                      decoration: const InputDecoration(labelText: 'Address'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: _selectedAcademicStatus,
                      decoration:
                          const InputDecoration(labelText: 'Academic Status'),
                      items: _academicStatuses.map((status) {
                        return DropdownMenuItem(
                          value: status,
                          child:
                              Text(status.replaceAll('_', ' ').toUpperCase()),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedAcademicStatus = value;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Please select your academic status';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: _continue,
                      child: Text(
                        (_selectedAcademicStatus == 'high_school' ||
                                _selectedAcademicStatus == 'not_studying')
                            ? 'Create Profile'
                            : 'Continue',
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
