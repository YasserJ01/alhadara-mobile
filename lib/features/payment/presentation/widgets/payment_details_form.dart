import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/l10n/generated/app_localizations.dart';

import '../../../../core/constants/app_elevated_button.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/theme/app_theme_helper.dart';
import '../../../../theme/presentation/bloc/theme_bloc.dart';
import '../../../../theme/presentation/bloc/theme_state.dart';
import '../bloc/deposit_methods/deposit_methods_bloc.dart';
import '../pages/deposit_request_page.dart';

class PaymentDetailsForm extends StatefulWidget {
  const PaymentDetailsForm({super.key});

  @override
  State<PaymentDetailsForm> createState() => _PaymentDetailsFormState();
}

class _PaymentDetailsFormState extends State<PaymentDetailsForm> {
  bool _isReadyToPay = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        Color backgroundColor = const Color(0xffF4F8FB);
        Color cardColor = Colors.white;
        Color textColor = AppColors.mainColor;
        Color secondaryTextColor = Colors.grey[600]!;

        if (themeState is ThemeLoaded) {
          backgroundColor = AppThemeHelper.getBackgroundColor(themeState.theme);
          cardColor = AppThemeHelper.getCardColor(themeState.theme);
          textColor = AppThemeHelper.getTextColor(themeState.theme);
          secondaryTextColor = AppThemeHelper.getSecondaryTextColor(themeState.theme);
        }

        return BlocBuilder<DepositBloc, DepositState>(
          builder: (context, state) {
            if (state is! DepositLoaded ||
                state.selectedMethod == null ||
                (state.selectedMethod!.name == 'bank_transfer' &&
                    state.selectedBank == null) ||
                (state.selectedMethod!.name == 'money_transfer' &&
                    state.selectedCompany == null)) {
              return Center(child: Text(l10n.pleaseMakeValidSelection));
            }

            final method = state.selectedMethod!;
            final isBankTransfer = method.name == 'bank_transfer';

            return Padding(
              padding: EdgeInsets.all(AppSizes.responsiveSize(context,
                  mobile: 16, tablet: 24, desktop: 32)),
              child: Column(
                children: [
                  // Payment Details Card
                  Card(
                    color: cardColor,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(AppSizes.responsiveSize(context,
                          mobile: 16, tablet: 20, desktop: 24)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isBankTransfer
                                ? l10n.bankTransferDetails
                                : l10n.moneyTransferDetails,
                            style: TextStyle(
                              fontSize: AppSizes.responsiveFontSize(context,
                                  mobile: 20, tablet: 22, desktop: 24),
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                          const SizedBox(height: 16),
                          if (isBankTransfer) ...[
                            _buildDetailRow(
                              context,
                              icon: Icons.account_balance,
                              label: l10n.bankName,
                              value: state.selectedBank!.bankName,
                              iconColor: textColor,
                              textColor: textColor,
                              secondaryTextColor: secondaryTextColor,
                            ),
                            _buildDetailRow(
                              context,
                              icon: Icons.person,
                              label: l10n.accountName,
                              value: state.selectedBank!.accountName,
                              iconColor: textColor,
                              textColor: textColor,
                              secondaryTextColor: secondaryTextColor,
                            ),
                            _buildDetailRow(
                              context,
                              icon: Icons.numbers,
                              label: l10n.accountNumber,
                              value: state.selectedBank!.accountNumber,
                              iconColor: textColor,
                              textColor: textColor,
                              secondaryTextColor: secondaryTextColor,
                            ),
                            _buildDetailRow(
                              context,
                              icon: Icons.credit_card,
                              label: 'IBAN',
                              value: state.selectedBank!.iban,
                              iconColor: textColor,
                              textColor: textColor,
                              secondaryTextColor: secondaryTextColor,
                            ),
                          ] else ...[
                            _buildDetailRow(
                              context,
                              icon: Icons.business,
                              label: l10n.company,
                              value: state.selectedCompany!.companyName,
                              iconColor: textColor,
                              textColor: textColor,
                              secondaryTextColor: secondaryTextColor,
                            ),
                            _buildDetailRow(
                              context,
                              icon: Icons.person_outline,
                              label: l10n.receiver,
                              value: state.selectedCompany!.receiverName,
                              iconColor: textColor,
                              textColor: textColor,
                              secondaryTextColor: secondaryTextColor,
                            ),
                            _buildDetailRow(
                              context,
                              icon: Icons.phone,
                              label: l10n.phone,
                              value: state.selectedCompany!.receiverPhone,
                              iconColor: textColor,
                              textColor: textColor,
                              secondaryTextColor: secondaryTextColor,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 130),

                  // Checkbox and instruction
                  Container(
                    child: Row(
                      children: [
                        Checkbox(
                          value: _isReadyToPay,
                          onChanged: (value) {
                            setState(() {
                              _isReadyToPay = value ?? false;
                            });
                          },
                          activeColor: textColor,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            l10n.ifReadyToPayClickHere,
                            style: TextStyle(
                              fontSize: 16,
                              color: secondaryTextColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Confirm Button
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: AppElevatedButton(
                      onPressed: _isReadyToPay
                          ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DepositRequestPage(
                              depositMethodId: method.id,
                            ),
                          ),
                        );
                      }
                          : null,
                      child: Text(
                        l10n.confirmPayment,
                        style: TextStyle(
                          fontSize: AppSizes.responsiveFontSize(context,
                              mobile: 18, tablet: 20, desktop: 22),
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildDetailRow(
      BuildContext context, {
        required IconData icon,
        required String label,
        required String value,
        required Color iconColor,
        required Color textColor,
        required Color secondaryTextColor,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: AppSizes.responsiveFontSize(context,
                        mobile: 14, tablet: 16, desktop: 18),
                    color: secondaryTextColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: AppSizes.responsiveFontSize(context,
                        mobile: 16, tablet: 18, desktop: 20),
                    fontWeight: FontWeight.w500,
                    color: textColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
