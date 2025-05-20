// // auth/presentation/widgets/register_modal.dart
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../../dependencies.dart';
// import '../../../auth/presentation/bloc/register/register_bloc.dart';
// import '../../../auth/presentation/widgets/register_form.dart';

// class RegisterModal extends StatelessWidget {
//   final VoidCallback? onLoginPressed;

//   const RegisterModal({super.key, this.onLoginPressed});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => getIt<RegisterBloc>(),
//       child: Container(
//         decoration: const BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(45),
//             topRight: Radius.circular(45),
//           ),
//         ),
//         child: Padding(
//           padding: EdgeInsets.only(
//             bottom: MediaQuery.of(context).viewInsets.bottom,
//             left: MediaQuery.of(context).size.width / 23,
//             right: MediaQuery.of(context).size.width / 23,
//           ),
//           child: const SingleChildScrollView(
//             child: RegisterForm(),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:alhadara/core/constants/app_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../dependencies.dart';
import '../../../auth/presentation/bloc/register/register_bloc.dart';
import '../../../auth/presentation/widgets/register_form.dart';
// Import AppSizes

class RegisterModal extends StatelessWidget {
  final VoidCallback? onLoginPressed;

  const RegisterModal({super.key, this.onLoginPressed});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<RegisterBloc>(),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: AppSizes.screenHeight(context) * 0.96,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(45),
            topRight: Radius.circular(45),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            bottom: AppSizes.paddingBottom(context),
            left: AppSizes.responsiveSize(context,
                mobile: 16, tablet: 24, desktop: 32),
            right: AppSizes.responsiveSize(context,
                mobile: 16, tablet: 24, desktop: 32),
            top: AppSizes.responsiveSize(context,
                mobile: 2, tablet: 32, desktop: 40),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: AppSizes.screenHeight(context) * 0.6,
                    ),
                    child: const RegisterForm(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
