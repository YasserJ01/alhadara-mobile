// import 'package:flutter/material.dart';
//
// class CustomRegisterTextField extends StatelessWidget {
//   final TextEditingController controller;
//   final String label;
//   final bool obscureText;
//   final TextInputType? keyboardType;
//   final String? Function(String?)? validator;
//   final Widget? suffixIcon;
//   final void Function()? onSuffixPressed;
//
//   const CustomRegisterTextField({
//     super.key,
//     required this.controller,
//     required this.label,
//     this.obscureText = false,
//     this.keyboardType,
//     this.validator,
//     this.suffixIcon,
//     this.onSuffixPressed,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 16),
//       child: TextFormField(
//         controller: controller,
//         obscureText: obscureText,
//         keyboardType: keyboardType,
//         decoration: InputDecoration(
//           labelText: label,
//           border: const OutlineInputBorder(),
//           filled: true,
//           fillColor: Colors.grey[50],
//           suffixIcon: suffixIcon != null
//               ? IconButton(
//             icon: suffixIcon!,
//             onPressed: onSuffixPressed,
//           )
//               : null,
//           errorStyle: const TextStyle(color: Colors.red),
//         ),
//         validator: validator,
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class CustomRegisterTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final void Function()? onSuffixPressed;
  final bool validateOnChange;

  const CustomRegisterTextField({
    super.key,
    required this.controller,
    required this.label,
    this.obscureText = false,
    this.keyboardType,
    this.validator,
    this.suffixIcon,
    this.onSuffixPressed,
    this.validateOnChange = false,
  });

  @override
  State<CustomRegisterTextField> createState() => _CustomRegisterTextFieldState();
}

class _CustomRegisterTextFieldState extends State<CustomRegisterTextField> {
  String? errorText;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_validate);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_validate);
    super.dispose();
  }

  void _validate() {
    if (widget.validateOnChange && widget.validator != null) {
      setState(() {
        errorText = widget.validator!(widget.controller.text);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.obscureText,
        keyboardType: widget.keyboardType,
        onChanged: (value) {
          if (widget.validateOnChange) _validate();
        },
        decoration: InputDecoration(
          labelText: widget.label,
          border: const OutlineInputBorder(),
          filled: true,
          fillColor: Colors.grey[50],
          suffixIcon: widget.suffixIcon != null
              ? IconButton(
            icon: widget.suffixIcon!,
            onPressed: widget.onSuffixPressed,
          )
              : null,
          errorText: errorText,
          errorStyle: const TextStyle(color: Colors.red),
        ),
        validator: widget.validator,
      ),
    );
  }
}