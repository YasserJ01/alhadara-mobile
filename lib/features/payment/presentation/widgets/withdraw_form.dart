// presentation/pages/withdraw/widgets/withdrawal_form.dart
import '../../../../core/constants/app_elevated_button.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/theme/app_theme_helper.dart';
import '../../../../theme/presentation/bloc/theme_bloc.dart';
import '../../../../theme/presentation/bloc/theme_state.dart';
import '../bloc/withdraw/withdrawal_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class WithdrawalForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();

  WithdrawalForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        Color backgroundColor = const Color(0xffF4F8FB);
        Color cardColor = Colors.white;
        Color textColor = AppColors.mainColor;
        Color secondaryTextColor = Colors.grey[600]!;
        Color borderColor = AppColors.mainColor.withOpacity(0.3);

        if (themeState is ThemeLoaded) {
          backgroundColor = AppThemeHelper.getBackgroundColor(themeState.theme);
          cardColor = AppThemeHelper.getCardColor(themeState.theme);
          textColor = AppThemeHelper.getTextColor(themeState.theme);
          secondaryTextColor = AppThemeHelper.getSecondaryTextColor(themeState.theme);
          borderColor = textColor.withOpacity(0.3);
        }

        return BlocListener<WithdrawalBloc, WithdrawalState>(
          listener: (context, state) {
            if (state.formStatus is SubmissionSuccess) {
              _showSuccessDialog(context, state.formStatus as SubmissionSuccess, textColor, cardColor, secondaryTextColor);
            } else if (state.formStatus is SubmissionFailed) {
              _showErrorDialog(context, state.formStatus as SubmissionFailed, textColor, cardColor, secondaryTextColor);
            }
          },
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  // Amount Field
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: borderColor,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      color: cardColor,
                      boxShadow: [
                        BoxShadow(
                          color: textColor.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 16,
                          offset: const Offset(0, 6),
                        )
                      ],
                    ),
                    child: TextFormField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: textColor,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding: const EdgeInsets.only(bottom: 10),
                        labelText: 'Enter Amount',
                        labelStyle: TextStyle(
                          color: textColor.withOpacity(0.6),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        prefixIcon: Icon(
                          Icons.attach_money_rounded,
                          color: textColor.withOpacity(0.7),
                          size: 24,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter amount';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter a valid number';
                        }
                        if (double.parse(value) <= 0) {
                          return 'Amount must be greater than zero';
                        }
                        return null;
                      },
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Withdraw Button
                  BlocBuilder<WithdrawalBloc, WithdrawalState>(
                    builder: (context, state) {
                      return Container(
                        width: double.infinity,
                        height: 58,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          gradient: LinearGradient(
                            colors: [
                              textColor,
                              textColor.withOpacity(0.8),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: textColor.withOpacity(0.4),
                              spreadRadius: 1,
                              blurRadius: 12,
                              offset: const Offset(0, 6),
                            )
                          ],
                        ),
                        child: AppElevatedButton(
                          onPressed: state.formStatus is FormSubmitting
                              ? null
                              : () {
                            if (_formKey.currentState!.validate()) {
                              context.read<WithdrawalBloc>().add(
                                WithdrawalAmountChanged(
                                    _amountController.text),
                              );
                              context.read<WithdrawalBloc>().add(
                                const WithdrawalSubmitted(),
                              );
                            }
                          },
                          child: state.formStatus is FormSubmitting
                              ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                            ),
                          )
                              : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.account_balance_wallet_rounded, size: 22),
                              const SizedBox(width: 12),
                              Text(
                                'Submit Withdraw',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.8,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 24),

                  // Information Section
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          textColor.withOpacity(0.08),
                          textColor.withOpacity(0.12),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: textColor.withOpacity(0.15),
                        width: 1.5,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.info_outline_rounded,
                              color: textColor,
                              size: 22,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'IMPORTANT INFORMATION',
                              style: TextStyle(
                                color: textColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildInfoItem(
                          Icons.access_time_rounded,
                          'Processing Time',
                          '24-48 hours',
                          textColor,
                          secondaryTextColor,
                        ),
                        _buildInfoItem(
                          Icons.verified_user_rounded,
                          'Verification',
                          'ID required for pickup',
                          textColor,
                          secondaryTextColor,
                        ),
                        _buildInfoItem(
                          Icons.attach_money_rounded,
                          'Minimum Amount',
                          '\$10.00',
                          textColor,
                          secondaryTextColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoItem(IconData icon, String title, String subtitle, Color textColor, Color secondaryTextColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: textColor.withOpacity(0.7),
            size: 18,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: secondaryTextColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDateTime(String dateTimeString) {
    try {
      final dateTime = DateTime.parse(dateTimeString);
      return DateFormat('MMM dd, yyyy - hh:mm a').format(dateTime);
    } catch (e) {
      return dateTimeString;
    }
  }

  void _showSuccessDialog(BuildContext context, SubmissionSuccess success, Color textColor, Color cardColor, Color secondaryTextColor) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        backgroundColor: cardColor,
        child: Container(
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 32,
                spreadRadius: 2,
                offset: const Offset(0, 12),
              )
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Success Icon
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_circle_rounded,
                  color: Colors.green,
                  size: 50,
                ),
              ),

              const SizedBox(height: 24),

              // Title
              Text(
                'Successfully Submitted!',
                style: TextStyle(
                  color: textColor,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.5,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 8),

              // Subtitle
              Text(
                'Your withdrawal request has been processed',
                style: TextStyle(
                  color: secondaryTextColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 28),

              // Details Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: textColor.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: textColor.withOpacity(0.1),
                  ),
                ),
                child: Column(
                  children: [
                    _buildDetailItem(
                      'Amount',
                      '\$${success.withdrawal.amount}',
                      Icons.attach_money_rounded,
                      textColor,
                      secondaryTextColor,
                    ),
                    const SizedBox(height: 16),
                    _buildDetailItem(
                      'Status',
                      success.withdrawal.status.toUpperCase(),
                      Icons.abc,
                      textColor,
                      secondaryTextColor,
                      status: success.withdrawal.status,
                    ),
                    const SizedBox(height: 16),
                    _buildDetailItem(
                      'Request Date',
                      _formatDateTime(success.withdrawal.requestedAt),
                      Icons.calendar_today_rounded,
                      textColor,
                      secondaryTextColor,
                    ),
                    const SizedBox(height: 16),
                    _buildDetailItem(
                      'Pickup Date',
                      _formatDateTime(success.withdrawal.pickupDatetime),
                      Icons.schedule_rounded,
                      textColor,
                      secondaryTextColor,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // Action Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: AppElevatedButton(
                  onPressed: () {
                    context.read<WithdrawalBloc>().resetState();
                    _amountController.clear();
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.done_all_rounded, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'COMPLETE',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailItem(String title, String value, IconData icon, Color textColor, Color secondaryTextColor, {String? status}) {
    return Row(
      children: [
        Icon(
          icon,
          color: textColor.withOpacity(0.7),
          size: 20,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: secondaryTextColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  color: status == 'pending' ? Colors.orange : textColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showErrorDialog(BuildContext context, SubmissionFailed failure, Color textColor, Color cardColor, Color secondaryTextColor) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        backgroundColor: cardColor,
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.error_outline_rounded,
                  color: Colors.red,
                  size: 40,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Request Failed',
                style: TextStyle(
                  color: textColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                failure.failure.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: secondaryTextColor,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: AppElevatedButton(
                  onPressed: () {
                    context.read<WithdrawalBloc>().resetState();
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'TRY AGAIN',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
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