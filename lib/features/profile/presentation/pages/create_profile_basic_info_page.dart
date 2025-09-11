import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/l10n/generated/app_localizations.dart';
import '../../../../core/constants/app_elevated_button.dart';
import '../../../../core/constants/app_scaffold.dart';
import '../../../../core/constants/colors.dart';
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

  //TODO
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
    final l10n = AppLocalizations.of(context);
    return AppScaffold(
      title: l10n.createProfile,
      body: SingleChildScrollView(
        child: BlocListener<CreateProfileBloc, CreateProfileState>(
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
                padding: const EdgeInsets.only(top: 16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        l10n.basicinfo,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          //letterSpacing: 1,
                          //  color: Color.fromARGB(255, 109, 27, 27),
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
                        child: TextFormField(
                          controller: _birthDateController,
                          decoration: InputDecoration(
                            focusedBorder: const UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColors.mainColor)),
                            labelText: l10n.birthDate,
                            labelStyle: const TextStyle(
                                color: Color.fromARGB(255, 201, 89, 89),
                                fontSize: 18),
                            suffixIcon: const Icon(
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
                              return l10n.pleaseSelectBirthDate;
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
                        child: DropdownButtonFormField<String>(
                          dropdownColor: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          elevation: 8,
                          value: _selectedGender,
                          icon: Container(
                            padding: const EdgeInsets.symmetric(vertical: 0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.mainColor
                                  .withOpacity(0.1), // Circular icon background
                            ),
                            child: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              // Rounded arrow icon
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
                            l10n.selectYourGender,
                            style: TextStyle(
                              color: Colors.grey[
                                  500], // Hint style when nothing is selected
                              fontSize: 16,
                            ),
                          ),
                          decoration: InputDecoration(
                              focusedBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColors.mainColor)),
                              labelText: l10n.gender,
                              labelStyle: const TextStyle(
                                  color: Color.fromARGB(255, 201, 89, 89),
                                  fontSize: 18)),
                          items: _genders.map((gender) {
                            return DropdownMenuItem(
                              alignment: Alignment.center,
                              value: gender,
                              child: Text(
                                gender,
                                // style: TextStyle(
                                //     color: AppColors.mainColor, fontSize: 18),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedGender = value;
                            });
                          },
                          validator: (value) {
                            if (value == null) {
                              return l10n.pleaseSelectGender;
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
                        child: TextFormField(
                          controller: _addressController,
                          decoration: InputDecoration(
                              focusedBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColors.mainColor)),
                              labelText: l10n.address,
                              labelStyle: const TextStyle(
                                  color: Color.fromARGB(255, 201, 89, 89),
                                  fontSize: 18)),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return l10n.pleaseEnterAddress;
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
                        child: DropdownButtonFormField<String>(
                          dropdownColor: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          elevation: 8,
                          icon: Container(
                            padding: const EdgeInsets.symmetric(vertical: 0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.mainColor
                                  .withOpacity(0.1), // Circular icon background
                            ),
                            child: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              // Rounded arrow icon
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
                            l10n.selectYourAcademicStatus,
                            style: TextStyle(
                              color: Colors.grey[
                                  500], // Hint style when nothing is selected
                              fontSize: 16,
                            ),
                          ),
                          value: _selectedAcademicStatus,
                          decoration: InputDecoration(
                              focusedBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColors.mainColor)),
                              labelText: l10n.academicStatus,
                              labelStyle: TextStyle(
                                  color: Color.fromARGB(255, 201, 89, 89),
                                  fontSize: 18)),
                          items: _academicStatuses.map((status) {
                            return DropdownMenuItem(
                              alignment: Alignment.center,
                              value: status,
                              child: Text(
                                status.replaceAll('_', ' '),
                                // style: TextStyle(
                                //     color: AppColors.mainColor, fontSize: 18),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedAcademicStatus = value;
                            });
                          },
                          validator: (value) {
                            if (value == null) {
                              return l10n.pleaseSelectAcademicStatus;
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 122),
                      AppElevatedButton(
                        onPressed: _continue,
                        child: Text(
                          (_selectedAcademicStatus == 'high_school' ||
                                  _selectedAcademicStatus == 'not_studying')
                              ? l10n.createProfile
                              : l10n.continuing,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      )
                      // ElevatedButton(
                      //   onPressed: _continue,
                      //   child:
                      // Text(
                      //     (_selectedAcademicStatus == 'high_school' ||
                      //             _selectedAcademicStatus == 'not_studying')
                      //         ? 'Create Profile'
                      //         : 'Continue',
                      //   ),
                      // ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
