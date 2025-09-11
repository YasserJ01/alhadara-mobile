import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/l10n/generated/app_localizations.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/theme/app_theme_helper.dart';
import '../../../../theme/presentation/bloc/theme_bloc.dart';
import '../../../../theme/presentation/bloc/theme_state.dart';
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
    final l10n = AppLocalizations.of(context);

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        Color backgroundColor = Colors.white;
        Color textColor = AppColors.mainColor;
        Color secondaryTextColor = Colors.grey[600]!;
        Color cardColor = Colors.white;

        if (themeState is ThemeLoaded) {
          backgroundColor = AppThemeHelper.getBackgroundColor(themeState.theme);
          textColor = AppThemeHelper.getTextColor(themeState.theme);
          secondaryTextColor = AppThemeHelper.getSecondaryTextColor(themeState.theme);
          cardColor = AppThemeHelper.getCardColor(themeState.theme);
        }

        return BlocListener<EnrollmentBloc, EnrollmentState>(
          listener: (context, state) {
            if (state is PaymentSuccess) {
              Navigator.pop(context);
              context.read<EnrollmentBloc>().add(FetchEnrollments());
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
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        spreadRadius: 2,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.makePayment,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          '${l10n.remainingBalance}: \$${widget.remainingBalance}',
                          style: TextStyle(
                            fontSize: 16,
                            color: secondaryTextColor,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: textColor.withOpacity(0.3),
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(12),
                            color: cardColor,
                            boxShadow: [
                              BoxShadow(
                                color: textColor.withOpacity(0.1),
                                spreadRadius: 2,
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: TextFormField(
                            controller: _amountController,
                            keyboardType: TextInputType.number,
                            style: TextStyle(color: textColor),
                            decoration: InputDecoration(
                              labelText: l10n.paymentAmount,
                              labelStyle: TextStyle(color: textColor),
                              prefixIcon: Icon(Icons.attach_money, color: textColor),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: textColor),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: textColor.withOpacity(0.3)),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return l10n.pleaseEnterAmount;
                              }
                              final amount = double.tryParse(value);
                              if (amount == null || amount <= 0) {
                                return l10n.enterValidAmount;
                              }
                              final remainingBalance = double.tryParse(widget.remainingBalance) ?? 0;
                              if (amount > remainingBalance) {
                                return l10n.amountExceedsBalance;
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
                                  side: BorderSide(color: textColor),
                                  backgroundColor: cardColor,
                                ),
                                onPressed: _isSubmitting
                                    ? null
                                    : () => Navigator.pop(context),
                                child: Text(
                                  l10n.cancel,
                                  style: TextStyle(color: textColor),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: textColor,
                                  foregroundColor: cardColor,
                                ),
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
                                    ? SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(cardColor),
                                  ),
                                )
                                    : Text(l10n.submit),
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
      },
    );
  }
}