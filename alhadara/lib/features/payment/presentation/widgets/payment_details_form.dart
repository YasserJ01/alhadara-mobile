import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_elevated_button.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/constants/colors.dart';
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
    return BlocBuilder<DepositBloc, DepositState>(
      builder: (context, state) {
        if (state is! DepositLoaded ||
            state.selectedMethod == null ||
            (state.selectedMethod!.name == 'bank_transfer' &&
                state.selectedBank == null) ||
            (state.selectedMethod!.name == 'money_transfer' &&
                state.selectedCompany == null)) {
          return const Center(child: Text('Please make a valid selection'));
        }

        final method = state.selectedMethod!;
        print(method.id);
        final isBankTransfer = method.name == 'bank_transfer';

        return Padding(
          padding: EdgeInsets.all(AppSizes.responsiveSize(context,
              mobile: 16, tablet: 24, desktop: 32)),
          child: Column(
            children: [
              // Payment Details Card
              Card(
                color: const Color.fromARGB(255, 233, 227, 227),
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
                            ? 'Bank Transfer Details'
                            : 'Money Transfer Details',
                        style: TextStyle(
                          fontSize: AppSizes.responsiveFontSize(context,
                              mobile: 20, tablet: 22, desktop: 24),
                          fontWeight: FontWeight.bold,
                          color: AppColors.mainColor,
                        ),
                      ),
                      const SizedBox(height: 16),
                      if (isBankTransfer) ...[
                        _buildDetailRow(
                          context,
                          icon: Icons.account_balance,
                          label: 'Bank Name',
                          value: state.selectedBank!.bankName,
                        ),
                        _buildDetailRow(
                          context,
                          icon: Icons.person,
                          label: 'Account Name',
                          value: state.selectedBank!.accountName,
                        ),
                        _buildDetailRow(
                          context,
                          icon: Icons.numbers,
                          label: 'Account Number',
                          value: state.selectedBank!.accountNumber,
                        ),
                        _buildDetailRow(
                          context,
                          icon: Icons.credit_card,
                          label: 'IBAN',
                          value: state.selectedBank!.iban,
                        ),
                      ] else ...[
                        _buildDetailRow(
                          context,
                          icon: Icons.business,
                          label: 'Company',
                          value: state.selectedCompany!.companyName,
                        ),
                        _buildDetailRow(
                          context,
                          icon: Icons.person_outline,
                          label: 'Receiver',
                          value: state.selectedCompany!.receiverName,
                        ),
                        _buildDetailRow(
                          context,
                          icon: Icons.phone,
                          label: 'Phone',
                          value: state.selectedCompany!.receiverPhone,
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
                      activeColor: AppColors.mainColor,
                    ),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text(
                        'If you are ready to pay click here',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
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
                          depositMethodId: method.id, // Pass from previous page
                        ),
                      ),
                    );
                        }
                      : null, // Disabled when checkbox is unchecked
                  child: Text(
                    'Confirm Payment',
                    style: TextStyle(
                      fontSize: AppSizes.responsiveFontSize(context,
                          mobile: 18, tablet: 20, desktop: 22),
                      fontWeight: FontWeight.w500,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: AppColors.mainColor, size: 24),
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
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: AppSizes.responsiveFontSize(context,
                        mobile: 16, tablet: 18, desktop: 20),
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
}
