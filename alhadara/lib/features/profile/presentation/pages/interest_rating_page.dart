import 'package:alhadara/core/constants/app_elevated_button.dart';
import 'package:alhadara/core/constants/app_scaffold.dart';
import 'package:alhadara/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alhadara/features/profile/presentation/pages/profile_image_upload_page.dart';
import 'package:alhadara/features/profile/presentation/pages/profile_images_display_page.dart';
import 'package:alhadara/features/profile/presentation/pages/profile_page.dart';

import '../../../../dependencies.dart';
import '../../domain/entity/interests.dart';
import '../../domain/usecases/save_user_interests_usecase.dart';
import '../bloc/interest_rating/interest_rating_bloc.dart';
import '../bloc/profile_image/profile_image_bloc.dart';
import '../bloc/view_profile/profile_bloc.dart';

class InterestRatingPage extends StatelessWidget {
  final int profileId;
  final List<InterestEntity> interests;

  const InterestRatingPage({
    super.key,
    required this.profileId,
    required this.interests,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => InterestRatingBloc(
              saveUserInterestsUseCase: getIt<SaveUserInterestsUseCase>(),
              // Must match
              interests: interests,
            ),
        child: AppScaffold(
          title: 'Your interests',
          body: BlocConsumer<InterestRatingBloc, InterestRatingState>(
            listener: (context, state) {
              if (state.error != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error!)),
                );
              }

              if (state.isSuccess) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) =>
                          getIt<ProfileImageBloc>(), // or your DI method
                      child: const ProfileImageUploadPage(),
                    ),
                  ),
                );

                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => BlocProvider(
                //       create: (context) => getIt<ProfileBloc>(),
                //       // or your DI method
                //       child: const ProfilePage(),
                //     ),
                //   ),
                // );
                // Navigator.of(context).popUntil((route) => route.isFirst);
              }
            },
            builder: (context, state) {
              if (state.isSubmitting) {
                return const Center(child: CircularProgressIndicator());
              }

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Rate your level of interest for each',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        // letterSpacing: 1,
                        //  color: Color.fromARGB(255, 109, 27, 27),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: ListView.builder(
                        itemCount: interests.length,
                        itemBuilder: (context, index) {
                          final interest = interests[index];
                          final rating =
                              state.interestRatings[interest.id] ?? 3;

                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    interest.name,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.mainColor),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: List.generate(5, (i) {
                                      return IconButton(
                                        icon: Icon(
                                          i < rating
                                              ? Icons.star
                                              : Icons.star_border,
                                          color: Colors.amber,
                                        ),
                                        onPressed: () {
                                          context
                                              .read<InterestRatingBloc>()
                                              .add(
                                                RateInterestEvent(
                                                    interest, i + 1),
                                              );
                                        },
                                      );
                                    }),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    AppElevatedButton(
                      onPressed: () {
                        context.read<InterestRatingBloc>().add(
                              SubmitInterestsEvent(
                                  profileId), // Using correct event type
                            );
                      },
                      child: Text(
                        'Submit',
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                    // SizedBox(
                    //   width: double.infinity,
                    //   child: ElevatedButton(
                    //     onPressed: () {
                    //       context.read<InterestRatingBloc>().add(
                    //             SubmitInterestsEvent(
                    //                 profileId), // Using correct event type
                    //           );
                    //     },
                    //     child: const Text('Submit'),
                    //   ),
                    // ),
                  ],
                ),
              );
            },
          ),
        ));
  }
}
