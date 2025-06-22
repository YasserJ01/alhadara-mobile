import 'package:alhadara/core/constants/app_elevated_button.dart';
import 'package:alhadara/core/constants/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../dependencies.dart';
import '../bloc/interest_selection/interest_selection_bloc.dart';
import '../widgets/interests_chip.dart';
import 'interest_rating_page.dart';

class InterestSelectionPage extends StatelessWidget {
  final int profileId;

  const InterestSelectionPage({super.key, required this.profileId});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Your interests',
      body: BlocProvider(
        create: (context) =>
            getIt<InterestSelectionBloc>()..add(LoadInterests()),
        child: BlocConsumer<InterestSelectionBloc, InterestSelectionState>(
          listener: (context, state) {
            if (state.error != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error!)),
              );
            }
          },
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Select up to 3 of your interests',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      //letterSpacing: 1,
                      //  color: Color.fromARGB(255, 109, 27, 27),
                    ),
                  ),
                  const SizedBox(height: 28),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: state.allInterests.map((interest) {
                      return InterestsChip(
                        label: interest.name,
                        isSelected: state.selectedInterests.contains(interest),
                        onTap: () {
                          context.read<InterestSelectionBloc>().add(
                                ToggleInterestSelection(interest),
                              );
                        },
                      );
                    }).toList(),
                  ),
                  const Spacer(),
                  AppElevatedButton(
                    onPressed: state.selectedInterests.isNotEmpty
                        ? () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => InterestRatingPage(
                                  profileId: profileId,
                                  interests: state.selectedInterests,
                                ),
                              ),
                            );
                          }
                        : null,
                    child: Text(
                      'Continue',
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
