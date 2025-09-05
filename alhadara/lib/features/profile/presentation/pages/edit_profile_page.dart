// presentation/pages/edit_profile_page.dart
import 'package:alhadara/core/constants/app_scaffold.dart';
import 'package:alhadara/dependencies.dart';
import 'package:alhadara/features/profile/presentation/bloc/update_profile/update_profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entity/profile.dart';
import '../widgets/profile_form.dart';

class EditProfilePage extends StatelessWidget {
  final Profile profile;

  const EditProfilePage({Key? key, required this.profile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => getIt<UpdateProfileBloc>(),
        child: AppScaffold(
          title: 'Edit Profile',
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ProfileForm(
                profile: profile,
                isEditing: true,
              ),
            ),
          ),
        )
        // Scaffold(
        //   appBar: AppBar(
        //     title: const Text('Edit Profile'),
        //     actions: [
        //       IconButton(
        //         icon: const Icon(Icons.save),
        //         onPressed: () {
        //           // سيتم التعامل مع الحفظ في ProfileForm
        //         },
        //       ),
        //     ],
        //   ),
        //   body: SingleChildScrollView(
        //     child: Padding(
        //       padding: const EdgeInsets.all(16.0),
        //       child: ProfileForm(
        //         profile: profile,
        //         isEditing: true,
        //       ),
        //     ),
        //   ),
        // ),
        );
  }
}
