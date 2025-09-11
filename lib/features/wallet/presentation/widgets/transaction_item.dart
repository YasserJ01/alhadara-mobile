import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/l10n/generated/app_localizations.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/theme/app_theme_helper.dart';
import '../../../../theme/presentation/bloc/theme_bloc.dart';
import '../../../../theme/presentation/bloc/theme_state.dart';
import '../../domain/entities/transaction_entity.dart';

class TransactionItem extends StatelessWidget {
  final String title;
  final String amount;
  final String date;
  final TransactionEntity? transactionDetails;

  const TransactionItem({
    required this.title,
    required this.amount,
    required this.date,
    this.transactionDetails,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        Color textColor = AppColors.mainColor;
        Color secondaryTextColor = Colors.grey[800]!;
        Color dividerColor = Colors.grey;

        if (themeState is ThemeLoaded) {
          textColor = AppThemeHelper.getTextColor(themeState.theme);
          secondaryTextColor =
              AppThemeHelper.getSecondaryTextColor(themeState.theme);
          dividerColor = secondaryTextColor.withOpacity(0.5);
        }

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    amount,
                    style: TextStyle(
                      fontSize: 14,
                      color: amount.startsWith('-') ? Colors.red : Colors.green,
                    ),
                  ),
                  Text(
                    date.substring(0, 16),
                    style: TextStyle(
                      fontSize: 14,
                      color: secondaryTextColor,
                    ),
                  ),
                ],
              ),
              if (transactionDetails != null)
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () =>
                        _showTransactionDetails(context, transactionDetails!),
                    child: Text(
                      l10n.viewDetails,
                      style: TextStyle(color: textColor),
                    ),
                  ),
                ),
              Divider(
                height: 20,
                color: dividerColor,
              ),
            ],
          ),
        );
      },
    );
  }

  void _showTransactionDetails(
      BuildContext context, TransactionEntity details) {
    final l10n = AppLocalizations.of(context);

    // Get theme colors from the current context
    final themeState = context.read<ThemeBloc>().state;

    Color textColor = AppColors.mainColor;
    Color secondaryTextColor = Colors.grey[800]!;
    Color cardColor = Colors.white;

    if (themeState is ThemeLoaded) {
      textColor = AppThemeHelper.getTextColor(themeState.theme);
      secondaryTextColor =
          AppThemeHelper.getSecondaryTextColor(themeState.theme);
      cardColor = AppThemeHelper.getCardColor(themeState.theme);
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: cardColor,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                bottomRight: Radius.circular(30))),
        title: Text(
          l10n.transactionDetails,
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailRow(l10n.transactionType, details.transactionType,
                  secondaryTextColor),
              _buildDetailRow(l10n.amount, details.amount, secondaryTextColor),
              _buildDetailRow(
                  l10n.date,
                  details.createdAt.toString().substring(0, 16),
                  secondaryTextColor),
              _buildDetailRow(l10n.status, details.status, secondaryTextColor),
              _buildDetailRow(
                  l10n.description, details.description, secondaryTextColor),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              l10n.close,
              style: TextStyle(color: textColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, Color textColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: textColor.withOpacity(0.8)),
            ),
          ),
        ],
      ),
    );
  }
}
