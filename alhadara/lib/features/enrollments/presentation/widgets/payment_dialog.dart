import 'dart:ui';

import 'package:alhadara/core/constants/colors.dart';
import 'package:alhadara/features/enrollments/presentation/bloc/enrollment_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// class PaymentDialog extends StatefulWidget {
//   final double remainingBalance;
//   final Function(double) onPaymentSubmitted;

//   const PaymentDialog({
//     super.key,
//     required this.remainingBalance,
//     required this.onPaymentSubmitted,
//   });

//   @override
//   State<PaymentDialog> createState() => _PaymentDialogState();
// }

// class _PaymentDialogState extends State<PaymentDialog> {
//   final _formKey = GlobalKey<FormState>();
//   final _amountController = TextEditingController();
//   double _enteredAmount = 0;

//   @override
//   void dispose() {
//     _amountController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//       ),
//       elevation: 0,
//       backgroundColor: Colors.transparent,
//       child: Container(
//         padding: const EdgeInsets.all(24),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(16),
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Make Payment',
//               style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                     fontWeight: FontWeight.bold,
//                     color: AppColors.mainColor,
//                   ),
//             ),
//             const SizedBox(height: 16),
//             Text(
//               'Remaining Balance: \$${widget.remainingBalance.toStringAsFixed(2)}',
//               style: const TextStyle(fontSize: 16),
//             ),
//             const SizedBox(height: 8),
//             Form(
//               key: _formKey,
//               child: TextFormField(
//                 controller: _amountController,
//                 keyboardType: TextInputType.number,
//                 decoration: InputDecoration(
//                   labelText: 'Payment Amount',
//                   prefixText: '\$ ',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter amount';
//                   }
//                   final amount = double.tryParse(value);
//                   if (amount == null || amount <= 0) {
//                     return 'Enter valid amount';
//                   }
//                   if (amount > widget.remainingBalance) {
//                     return 'Amount exceeds balance';
//                   }
//                   return null;
//                 },
//                 onChanged: (value) {
//                   setState(() {
//                     _enteredAmount = double.tryParse(value) ?? 0;
//                   });
//                 },
//               ),
//             ),
//             const SizedBox(height: 24),
//             Row(
//               children: [
//                 Expanded(
//                   child: OutlinedButton(
//                     onPressed: () => Navigator.pop(context),
//                     style: OutlinedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(vertical: 14),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     child: const Text(
//                       'CANCEL',
//                       style: TextStyle(color: AppColors.mainColor),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 16),
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       if (_formKey.currentState!.validate()) {
//                         widget.onPaymentSubmitted(_enteredAmount);
//                       }
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: AppColors.mainColor,
//                       foregroundColor: Colors.white,
//                       padding: const EdgeInsets.symmetric(vertical: 14),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     child: const Text('SUBMIT'),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//import 'package:flutter_blurhash/flutter_blurhash.dart';

// class PaymentDialog extends StatefulWidget {
//   final double remainingBalance;
//   final Function(double) onPaymentSubmitted;

//   const PaymentDialog({
//     super.key,
//     required this.remainingBalance,
//     required this.onPaymentSubmitted,
//   });

//   @override
//   State<PaymentDialog> createState() => _PaymentDialogState();
// }

// class _PaymentDialogState extends State<PaymentDialog> {
//   final _formKey = GlobalKey<FormState>();
//   final _amountController = TextEditingController();
//   double _enteredAmount = 0;

//   @override
//   void dispose() {
//     _amountController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       backgroundColor: Colors.transparent,
//       insetPadding: const EdgeInsets.all(20),
//       child: Stack(
//         children: [
//           // Blurred background effect
//           Positioned.fill(
//             child: BackdropFilter(
//               filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
//               child: Container(
//                   // color: Colors.black.withOpacity(0.3),
//                   ),
//             ),
//           ),

//           // Dialog content
//           Container(
//             padding: const EdgeInsets.all(24),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(16),
//               // image: const DecorationImage(
//               //   image: BlurHashImage(
//               //       'L5H2EC=PM+yV0g-mq.wG9c010J}I'), // Blur hash pattern
//               //   fit: BoxFit.cover,
//               // ),
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Make Payment',
//                   style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                         fontWeight: FontWeight.bold,
//                         color: AppColors.mainColor,
//                       ),
//                 ),
//                 const SizedBox(height: 16),
//                 Text(
//                   'Remaining Balance: \$${widget.remainingBalance.toStringAsFixed(2)}',
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 Form(
//                   key: _formKey,
//                   child: TextFormField(
//                     controller: _amountController,
//                     keyboardType: TextInputType.number,
//                     decoration: InputDecoration(
//                       labelText: 'Payment Amount',
//                       prefixText: '\$ ',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       filled: true,
//                       fillColor: Colors.white.withOpacity(0.7),
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter amount';
//                       }
//                       final amount = double.tryParse(value);
//                       if (amount == null || amount <= 0) {
//                         return 'Enter valid amount';
//                       }
//                       if (amount > widget.remainingBalance) {
//                         return 'Amount exceeds balance';
//                       }
//                       return null;
//                     },
//                     onChanged: (value) {
//                       setState(() {
//                         _enteredAmount = double.tryParse(value) ?? 0;
//                       });
//                     },
//                   ),
//                 ),
//                 const SizedBox(height: 24),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: OutlinedButton(
//                         onPressed: () => Navigator.pop(context),
//                         style: OutlinedButton.styleFrom(
//                           padding: const EdgeInsets.symmetric(vertical: 14),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           side: BorderSide(color: AppColors.mainColor),
//                         ),
//                         child: Text(
//                           'CANCEL',
//                           style: TextStyle(color: AppColors.mainColor),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 16),
//                     Expanded(
//                       child: ElevatedButton(
//                         onPressed: () {
//                           if (_formKey.currentState!.validate()) {
//                             widget.onPaymentSubmitted(_enteredAmount);
//                           }
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: AppColors.mainColor,
//                           foregroundColor: Colors.white,
//                           padding: const EdgeInsets.symmetric(vertical: 14),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                         ),
//                         child: const Text('SUBMIT'),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
class PaymentDialog extends StatefulWidget {
  final int enrollmentId;
  final double remainingBalance;

  const PaymentDialog({
    super.key,
    required this.enrollmentId,
    required this.remainingBalance,
  });

  @override
  State<PaymentDialog> createState() => _PaymentDialogState();
}

class _PaymentDialogState extends State<PaymentDialog> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  double _enteredAmount = 0;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EnrollmentBloc, EnrollmentState>(
      listener: (context, state) {
        if (state is PaymentSuccess) {
          Navigator.pop(context);
          context
              .read<EnrollmentBloc>()
              .add(FetchEnrollments()); // إعادة جلب البيانات
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        } else if (state is EnrollmentError) {
          setState(() => _isSubmitting = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(20),
        child: Stack(
          children: [
            Positioned.fill(
                child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(color: Colors.black.withOpacity(0.3)),
            )),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Make Payment',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.mainColor,
                          ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Remaining Balance: \$${widget.remainingBalance.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Payment Amount',
                        prefixText: '\$ ',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter amount';
                        }
                        final amount = double.tryParse(value);
                        if (amount == null || amount <= 0) {
                          return 'Enter valid amount';
                        }
                        if (amount > widget.remainingBalance) {
                          return 'Amount exceeds balance';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _enteredAmount = double.tryParse(value) ?? 0;
                        });
                      },
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: AppColors.mainColor),
                            ),
                            onPressed: _isSubmitting
                                ? null
                                : () => Navigator.pop(context),
                            child: const Text(
                              'CANCEL',
                              style: TextStyle(color: AppColors.mainColor),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.mainColor),
                            onPressed: _isSubmitting
                                ? null
                                : () {
                                    if (_formKey.currentState!.validate()) {
                                      setState(() => _isSubmitting = true);
                                      context.read<EnrollmentBloc>().add(
                                            SubmitPayment(
                                              enrollmentId: widget.enrollmentId,
                                              amount: _enteredAmount,
                                            ),
                                          );
                                    }
                                  },
                            child: _isSubmitting
                                ? const CircularProgressIndicator()
                                : const Text('SUBMIT'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
