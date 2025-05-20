import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool obscureText;
  final String labelText;
  final TextInputType textInputType;
  // final

  const AuthTextField({
    super.key,
    required this.textEditingController,
    required this.obscureText,
    required this.labelText,
    required this.textInputType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 244, 248, 251),
      child: TextFormField(
        obscureText: obscureText,
        controller: textEditingController,
        decoration: InputDecoration(
          labelText: labelText,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(255, 224, 228, 230),
              width: 0,
            ),
          ),
        ),
        keyboardType: textInputType,
      ),
    );
  }
}
