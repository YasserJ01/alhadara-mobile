// import 'package:flutter/material.dart';
// import 'login_modal.dart';

// class StartButtons extends StatelessWidget {
//   const StartButtons({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [

//         SizedBox(
//           height: MediaQuery.of(context).size.height / 14,
//           // height: 52,
//           width: double.infinity,
//           // width: 335,
//           child: OutlinedButton(
//             style: OutlinedButton.styleFrom(
//               side: const BorderSide(
//                 color: Colors.white,
//                 width: 2,
//               ),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(
//                   1,
//                 ),
//               ),
//             ),
//             // onPressed: () => Navigator.pushNamed(context, '/login'),
//             // onPressed: () => showModalBottomSheet(
//             //   context: context,
//             //   isScrollControlled: true,
//             //   backgroundColor: Colors.transparent,
//             //   builder: (context) => const LoginModal(),
//             // ),
//             onPressed: () => showModalBottomSheet(
//               context: context,
//               isScrollControlled: true,
//               backgroundColor: Colors.transparent,
//               builder: (context) => const LoginModal(),
//             ),
//             child: const Text(
//               'SIGN IN',
//               style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 20,
//                   fontWeight: FontWeight.w400),
//             ),
//           ),
//         ),
//         SizedBox(height: MediaQuery.of(context).size.height/30),
//         SizedBox(
//           height: MediaQuery.of(context).size.height / 14,
//           width: double.infinity,
//           child: ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(
//                   1,
//                 ),
//               ),
//               backgroundColor: Colors.white
//             ),
//             onPressed: () => Navigator.pushNamed(context, '/departments'),
//             child: const Text(
//               'AS A GUEST',
//               style: TextStyle(
//                 color: Color.fromRGBO(162, 12, 13, 1.0),
//                 fontSize: 20,
//                 fontWeight: FontWeight.w400,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
import 'package:alhadara/core/constants/app_elevated_button.dart';
import 'package:alhadara/core/constants/app_size.dart';
import 'package:alhadara/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'login_modal.dart';

class StartButtons extends StatelessWidget {
  const StartButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppElevatedButton(
          child: Text(
            'SIGN IN',
            style: TextStyle(
              color: AppColors.whiteColor,
              fontSize: AppSizes.responsiveFontSize(context,
                  mobile: 18, tablet: 20, desktop: 22),
              fontWeight: FontWeight.w400,
            ),
          ),
          side: const BorderSide(
            color: AppColors.whiteColor,
            width: 2,
          ),
          onPressed: () => showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => const LoginModal(),
          ),
        ),
        // SizedBox(
        //   height: AppSizes.responsiveSize(context,
        //       mobile: 56, tablet: 64, desktop: 72),
        //   width: double.infinity,
        //   child: ElevatedButton(
        //     style: ElevatedButton.styleFrom(
        //       backgroundColor: const Color.fromRGBO(162, 12, 13, 1.0),
        //       side: const BorderSide(
        //         color: Colors.white,
        //         width: 2,
        //       ),
        //       shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(1),
        //       ),
        //       padding: EdgeInsets.symmetric(
        //         vertical: AppSizes.responsiveSize(context,
        //             mobile: 12, tablet: 14, desktop: 16),
        //       ),
        //     ),
        //     onPressed:
        //() => showModalBottomSheet(
        //       context: context,
        //       isScrollControlled: true,
        //       backgroundColor: Colors.transparent,
        //       builder: (context) => const LoginModal(),
        //     ),
        //     child:
        // Text(
        //       'SIGN IN',
        //       style: TextStyle(
        //         color: Colors.white,
        //         fontSize: AppSizes.responsiveFontSize(context,
        //             mobile: 18, tablet: 20, desktop: 22),
        //         fontWeight: FontWeight.w400,
        //       ),
        //     ),
        //   ),
        // ),
        SizedBox(
            height: AppSizes.responsiveSize(context,
                mobile: 16, tablet: 20, desktop: 24)),
        AppElevatedButton(
          backgroundColor: AppColors.whiteColor,
          child: Text(
            'AS A GUEST',
            style: TextStyle(
              color: AppColors.mainColor,
              fontSize: AppSizes.responsiveFontSize(context,
                  mobile: 18, tablet: 20, desktop: 22),
              fontWeight: FontWeight.w400,
            ),
          ),
          onPressed: () => Navigator.pushNamed(context, '/departments'),
        )
        // SizedBox(
        //   height: AppSizes.responsiveSize(context,
        //       mobile: 56, tablet: 64, desktop: 72),
        //   width: double.infinity,
        //   child: ElevatedButton(
        //     style: ElevatedButton.styleFrom(
        //       shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(1),
        //       ),
        //       backgroundColor: Colors.white,
        //       padding: EdgeInsets.symmetric(
        //         vertical: AppSizes.responsiveSize(context,
        //             mobile: 12, tablet: 14, desktop: 16),
        //       ),
        //     ),
        //     onPressed: () => Navigator.pushNamed(context, '/departments'),
        //     child:
        // Text(
        //       'AS A GUEST',
        //       style: TextStyle(
        //         color: const Color.fromRGBO(162, 12, 13, 1.0),
        //         fontSize: AppSizes.responsiveFontSize(context,
        //             mobile: 18, tablet: 20, desktop: 22),
        //         fontWeight: FontWeight.w400,
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
