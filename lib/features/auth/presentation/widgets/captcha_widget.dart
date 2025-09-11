// TODO Implement this library.// // // auth/presentation/widgets/captcha_widget.dart
// // import 'dart:convert';
// // import 'dart:typed_data';

// // import 'package:alhadara/features/auth/presentation/bloc/captch/captcha_bloc.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';

// // class CaptchaWidget extends StatelessWidget {
// //   final TextEditingController captchaController;
// //   final String? captchaKey;
// //   final void Function(String key, String answer)? onVerified;

// //   const CaptchaWidget({
// //     Key? key,
// //     required this.captchaController,
// //     this.captchaKey,
// //       this.onVerified,
// //   }) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return BlocBuilder<CaptchaBloc, CaptchaState>(
// //       builder: (context, state) {
// //         if (state is CaptchaLoading) {
// //           return const Center(child: CircularProgressIndicator());
// //         } else if (state is CaptchaError) {
// //           return Column(
// //             children: [
// //               Text('Error: ${state.error}'),
// //               ElevatedButton(
// //                 onPressed: () {
// //                   context.read<CaptchaBloc>().add(RefreshCaptcha());
// //                 },
// //                 child: const Text('Retry'),
// //               ),
// //             ],
// //           );
// //         } else if (state is CaptchaLoaded) {
// //   return Column(
// //     crossAxisAlignment: CrossAxisAlignment.start,
// //     children: [
// //       Image.memory(
// //         _convertBase64ToImage(state.captcha.image),
// //         height: 80,
// //       ),
// //       const SizedBox(height: 10),
// //       Row(
// //         children: [
// //           Expanded(
// //             child: TextFormField(
// //               controller: captchaController,
// //               decoration: const InputDecoration(
// //                 labelText: 'Enter CAPTCHA',
// //                 border: OutlineInputBorder(),
// //               ),
// //               validator: (value) {
// //                 if (value == null || value.isEmpty) {
// //                   return 'Please enter the CAPTCHA';
// //                 }
// //                 return null;
// //               },
// //             ),
// //           ),
// //           IconButton(
// //             icon: const Icon(Icons.refresh),
// //             onPressed: () {
// //               context.read<CaptchaBloc>().add(RefreshCaptcha());
// //             },
// //           ),
// //         ],
// //       ),
// //       const SizedBox(height: 12),
// //       Align(
// //         alignment: Alignment.centerRight,
// //         child: ElevatedButton(
// //           onPressed: () {
// //             if (onVerified != null && captchaKey != null) {
// //               onVerified!(captchaKey!, captchaController.text.trim());
// //             }
// //           },
// //           child: const Text("Check"),
// //         ),
// //       ),
// //     ],
// //   );
// // } else {
// //           return ElevatedButton(
// //             onPressed: () {
// //               context.read<CaptchaBloc>().add(LoadCaptcha());
// //             },
// //             child: const Text('Load CAPTCHA'),
// //           );
// //         }
// //       },
// //     );
// //   }

// //   Uint8List _convertBase64ToImage(String base64String) {
// //     // Remove the data:image/png;base64, prefix if present
// //     if (base64String.contains(',')) {
// //       base64String = base64String.split(',').last;
// //     }
// //     return base64.decode(base64String);
// //   }
// // }
// import 'dart:convert';
// import 'dart:typed_data';

// import 'package:alhadara/features/auth/presentation/bloc/captch/captcha_bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class CaptchaWidget extends StatelessWidget {
//   final TextEditingController captchaController;
//   final String? captchaKey;
//   final void Function(String key, String answer)? onVerified;

//   const CaptchaWidget({
//     Key? key,
//     required this.captchaController,
//     this.captchaKey,
//     this.onVerified,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<CaptchaBloc, CaptchaState>(
//       builder: (context, state) {
//         if (state is CaptchaLoading) {
//           return const Center(child: CircularProgressIndicator());
//         } else if (state is CaptchaError) {
//           return Column(
//             children: [
//               Text('Error: ${state.error}'),
//               const SizedBox(height: 10),
//               ElevatedButton(
//                 onPressed: () {
//                   context.read<CaptchaBloc>().add(RefreshCaptcha());
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.red,
//                   foregroundColor: Colors.white,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 child: const Text('Retry'),
//               ),
//             ],
//           );
//         } else if (state is CaptchaLoaded) {
//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // CAPTCHA Header
//               const Text(
//                 'Please enter the code shown below:',
//                 style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
//               ),
//               const SizedBox(height: 12),

//               // CAPTCHA Image Container with styling
//               Container(
//                 padding: const EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   color: Colors.grey[100],
//                   borderRadius: BorderRadius.circular(8),
//                   border: Border.all(color: Colors.grey[300]!),
//                 ),
//                 child: Column(
//                   children: [
//                     // CAPTCHA Image with noise effect simulation
//                     Stack(
//                       children: [
//                         // Background noise effect
//                         Container(
//                           height: 60,
//                           decoration: BoxDecoration(
//                             gradient: LinearGradient(
//                               begin: Alignment.topLeft,
//                               end: Alignment.bottomRight,
//                               colors: [
//                                 Colors.grey[200]!,
//                                 Colors.grey[100]!,
//                               ],
//                             ),
//                           ),
//                         ),
//                         // Actual CAPTCHA image
//                         Center(
//                           child: Image.memory(
//                             _convertBase64ToImage(state.captcha.image),
//                             height: 60,
//                             filterQuality: FilterQuality.none, // Keeps CAPTCHA crisp
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 8),

//                     // Refresh button with improved styling
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         TextButton.icon(
//                           icon: const Icon(Icons.refresh, size: 16),
//                           label: const Text(
//                             'Refresh Code',
//                             style: TextStyle(fontSize: 12),
//                           ),
//                           onPressed: () {
//                             context.read<CaptchaBloc>().add(RefreshCaptcha());
//                           },
//                           style: TextButton.styleFrom(
//                             foregroundColor:AppColors.mainColor,
//                             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 16),

//               // Input field with improved styling
//               TextFormField(
//                 controller: captchaController,
//                 decoration: InputDecoration(
//                   labelText: 'Enter CAPTCHA code',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                 ),
//                 style: const TextStyle(
//                   fontSize: 16,
//                   letterSpacing: 1.5, // Makes entered text more readable
//                 ),
//                 textCapitalization: TextCapitalization.characters,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter the CAPTCHA code';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 16),

//               // Verify button with improved styling
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     if (onVerified != null && captchaKey != null) {
//                       onVerified!(captchaKey!, captchaController.text.trim());
//                     }
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor:AppColors.mainColor,
//                     foregroundColor: Colors.white,
//                     padding: const EdgeInsets.symmetric(vertical: 14),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   child: const Text(
//                     "Verify CAPTCHA",
//                     style: TextStyle(fontWeight: FontWeight.w600),
//                   ),
//                 ),
//               ),
//             ],
//           );
//         } else {
//           return ElevatedButton(
//             onPressed: () {
//               context.read<CaptchaBloc>().add(LoadCaptcha());
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor:AppColors.mainColor,
//               foregroundColor: Colors.white,
//             ),
//             child: const Text('Load CAPTCHA'),
//           );
//         }
//       },
//     );
//   }

//   Uint8List _convertBase64ToImage(String base64String) {
//     // Remove the data:image/png;base64, prefix if present
//     if (base64String.contains(',')) {
//       base64String = base64String.split(',').last;
//     }
//     return base64.decode(base64String);
//   }
// }
import 'dart:convert';
import 'dart:typed_data';

import '../../../../core/constants/colors.dart';
import '../bloc/captch/captcha_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CaptchaWidget extends StatefulWidget {
  final TextEditingController captchaController;
  final String? captchaKey;
  final void Function(String key, String answer)? onVerified;

  const CaptchaWidget({
    Key? key,
    required this.captchaController,
    this.captchaKey,
    this.onVerified,
  }) : super(key: key);

  @override
  _CaptchaWidgetState createState() => _CaptchaWidgetState();
}

class _CaptchaWidgetState extends State<CaptchaWidget> {
  final _formKey = GlobalKey<FormState>();
  String _currentKey = '';
  bool _isVerifying = false;
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return BlocListener<CaptchaBloc, CaptchaState>(
      listener: (context, state) {
        if (state is CaptchaError) {
          setState(() {
            _isVerifying = false;
            _errorMessage = state.error;
          });
        } else if (state is CaptchaVerified) {
          setState(() {
            _isVerifying = false;
          });

          if (state.isValid && widget.onVerified != null) {
            widget.onVerified!(_currentKey, widget.captchaController.text);
          } else {
            setState(() {
              _errorMessage = 'CAPTCHA code is incorrect. Please try again.';
            });
            context.read<CaptchaBloc>().add(RefreshCaptcha());
            widget.captchaController.clear();
          }
        }
      },
      child: BlocBuilder<CaptchaBloc, CaptchaState>(
        builder: (context, state) {
          if (state is CaptchaLoading && !_isVerifying) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CaptchaError && !_isVerifying) {
            return Column(
              children: [
                Text('Error: ${state.error}'),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    context.read<CaptchaBloc>().add(RefreshCaptcha());
                     widget.captchaController.clear(); 
                    setState(() {
                      _errorMessage = null;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Retry'),
                ),
              ],
            );
          } else if (state is CaptchaLoaded) {
            _currentKey = state.captcha.key;

            return Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Please enter the code shown below:',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Column(
                      children: [
                        Center(
                          child: Image.memory(
                            _convertBase64ToImage(state.captcha.image),
                            height: 60,
                            filterQuality: FilterQuality.none,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton.icon(
                              icon: const Icon(Icons.refresh, size: 16),
                              label: const Text(
                                'Refresh Code',
                                style: TextStyle(fontSize: 12),
                              ),
                              onPressed: () {
                                context
                                    .read<CaptchaBloc>()
                                    .add(RefreshCaptcha());
                                widget.captchaController.clear();
                                setState(() {
                                  _errorMessage = null;
                                });
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: AppColors.mainColor,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                  
                    controller: widget.captchaController,
                    decoration: InputDecoration(
                      labelText: 'Enter CAPTCHA code',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      errorText: _errorMessage,
                    ),
                    style: const TextStyle(
                      fontSize: 16,
                      letterSpacing: 1.5,
                    ),
                    textCapitalization: TextCapitalization.characters,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the CAPTCHA code';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isVerifying
                          ? null
                          : () {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  _isVerifying = true;
                                  _errorMessage = null;
                                });
                                context.read<CaptchaBloc>().add(
                                      VerifyCaptcha(
                                        key: _currentKey,
                                        answer: widget.captchaController.text
                                            .trim(),
                                      ),
                                    );
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.mainColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: _isVerifying
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text(
                              "Verify CAPTCHA",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return ElevatedButton(
              onPressed: () {
                context.read<CaptchaBloc>().add(LoadCaptcha());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.mainColor,
                foregroundColor: Colors.white,
              ),
              child: const Text('Load CAPTCHA'),
            );
          }
        },
      ),
    );
  }

  Uint8List _convertBase64ToImage(String base64String) {
    if (base64String.contains(',')) {
      base64String = base64String.split(',').last;
    }
    return base64.decode(base64String);
  }
}
