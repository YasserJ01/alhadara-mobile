import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/dependencies.dart';
import '../bloc/create_profile/create_profile_bloc.dart';
import '../bloc/view_profile/profile_bloc.dart';
import '../widgets/profile_content.dart';
import 'create_profile_basic_info_page.dart';

//profile_page.dart
class ProfilePage extends StatelessWidget {
  // final String token;

  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProfileBloc>()
        ..add(
          const LoadProfile(),
        ),
      child: Scaffold(
        backgroundColor: Colors.white,
        // backgroundColor: Color.fromRGBO(244, 248, 251, 1.0),
        appBar: AppBar(
          backgroundColor: Colors.white,
          // backgroundColor: Color.fromRGBO(244, 248, 251, 1.0),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            'Profile',
            style: TextStyle(
              color: Color.fromRGBO(162, 12, 13, 1.0),
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications_outlined,
                  color: Color.fromRGBO(162, 12, 13, 1.0)),
              onPressed: () {},
            ),
          ],
        ),
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProfileLoaded) {
              return ProfileContent(profile: state.profile);
            } else if (state is ProfileNotFound) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.person_add_alt_1,
                        size: 64,
                        color: Color.fromRGBO(162, 12, 13, 1.0),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'No Profile Found',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(162, 12, 13, 1.0),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'You don\'t have a profile yet. Would you like to create one?',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 15,
                          ),
                          // shadowColor: Colors.black
                          side: const BorderSide(
                            style: BorderStyle.solid,
                            color: Color.fromRGBO(162, 12, 13, 1.0),
                          ),
                        ),
                        onPressed: () {
                          // Navigate to create profile page
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                create: (context) => getIt<CreateProfileBloc>(),
                                child: const CreateProfileBasicInfoPage(),
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          'Create Profile',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromRGBO(162, 12, 13, 1.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is ProfileError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline,
                        size: 64, color: Colors.red),
                    const SizedBox(height: 16),
                    Text(
                      'Error loading profile',
                      style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      state.message,
                      style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<ProfileBloc>().add(LoadProfile());
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
