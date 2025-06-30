import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/colors.dart';
import '../bloc/enrollments/enrollment_bloc.dart';

class PaymentDialog extends StatefulWidget {
  final int enrollmentId;
  final String remainingBalance;

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
                      'Remaining Balance: \$${widget.remainingBalance}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.mainColor.withOpacity(0.3),
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.mainColor
                                .withOpacity(0.1), // Themed shadow color
                            spreadRadius: 2,
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          )
                        ],
                      ),
                      child: TextFormField(
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Payment Amount',
                          labelStyle: TextStyle(color: AppColors.mainColor),
                          prefixIcon: Icon(Icons.attach_money),
                          prefixIconColor: Color.fromARGB(255, 200, 155, 155),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.mainColor),
                            // borderRadius: BorderRadius.circular(8),
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
                           final remainingBalance = double.tryParse(widget.remainingBalance) ?? 0;
                          if (amount > remainingBalance) {
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
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side:
                                  const BorderSide(color: AppColors.mainColor),
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
