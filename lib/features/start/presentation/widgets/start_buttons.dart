import 'package:flutter/material.dart';

import '../../../../l10n/generated/app_localizations.dart';
import '../../../auth/presentation/widgets/login_form.dart';
import 'login_modal.dart';

class StartButtons extends StatelessWidget {
  const StartButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      children: [
        // Sign In Button
        SizedBox(
          height: MediaQuery.of(context).size.height / 14,
          width: double.infinity,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: const BorderSide(
                color: Colors.white,
                width: 2,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(1),
              ),
            ),
            onPressed: () => showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) => const LoginModal(),
            ),
            child: Text(
              l10n.signIn,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),

        SizedBox(height: MediaQuery.of(context).size.height / 30),

        // Guest Button
        SizedBox(
          height: MediaQuery.of(context).size.height / 14,
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(1),
              ),
              backgroundColor: Colors.white,
            ),
            onPressed: () => Navigator.pushNamed(context, '/departments'),
            child: Text(
              l10n.asAGuest,
              style: const TextStyle(
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