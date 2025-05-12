import 'package:flutter/material.dart';

import '../../../auth/presentation/widgets/login_form.dart';
import 'login_modal.dart';

class StartButtons extends StatelessWidget {
  const StartButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        SizedBox(
          height: MediaQuery.of(context).size.height / 14,
          // height: 52,
          width: double.infinity,
          // width: 335,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: const BorderSide(
                color: Colors.white,
                width: 2,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  1,
                ),
              ),
            ),
            // onPressed: () => Navigator.pushNamed(context, '/login'),
            // onPressed: () => showModalBottomSheet(
            //   context: context,
            //   isScrollControlled: true,
            //   backgroundColor: Colors.transparent,
            //   builder: (context) => const LoginModal(),
            // ),
            onPressed: () => showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) => const LoginModal(),
            ),
            child: const Text(
              'SIGN IN',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height/30),
        SizedBox(
          height: MediaQuery.of(context).size.height / 14,
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  1,
                ),
              ),
              backgroundColor: Colors.white
            ),
            onPressed: () => Navigator.pushNamed(context, '/guest'),
            child: const Text(
              'AS A GUEST',
              style: TextStyle(
                color: Color.fromRGBO(162, 12, 13, 1.0),
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
