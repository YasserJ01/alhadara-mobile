import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/l10n/generated/app_localizations.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/theme/app_theme_helper.dart';
import '../../../../theme/presentation/bloc/theme_bloc.dart';
import '../../../../theme/presentation/bloc/theme_state.dart';
import '../../../payment/presentation/pages/method_selection_page.dart';
import '../bloc/transaction_bloc/transaction_bloc.dart';
import '../bloc/wallet_bloc.dart';
// import '../pages/withdraw_page.dart';
import 'package:project2/features/payment/presentation/pages/withdraw_page.dart';

import 'transaction_item.dart';

class WalletForm extends StatelessWidget {
  const WalletForm({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        // Get theme colors
        Color backgroundColor = const Color(0xffF4F8FB);
        Color cardColor = Colors.white;
        Color textColor = AppColors.mainColor;
        Color secondaryTextColor = Colors.grey[800]!;

        if (themeState is ThemeLoaded) {
          backgroundColor = AppThemeHelper.getBackgroundColor(themeState.theme);
          cardColor = AppThemeHelper.getCardColor(themeState.theme);
          textColor = AppThemeHelper.getTextColor(themeState.theme);
          secondaryTextColor =
              AppThemeHelper.getSecondaryTextColor(themeState.theme);
        }

        return BlocBuilder<WalletBloc, WalletState>(
          builder: (context, walletState) {
            if (walletState is WalletLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (walletState is WalletError) {
              // print(walletState.props);
              return Center(child: Text(walletState.message));
            } else if (walletState is WalletLoaded) {
              return BlocBuilder<TransactionBloc, TransactionState>(
                builder: (context, transactionState) {
                  if (transactionState is TransactionLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (transactionState is TransactionError) {
                    return Center(child: Text(transactionState.message));
                  } else if (transactionState is TransactionLoaded) {
                    return SingleChildScrollView(
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Card(
                                margin: EdgeInsets.zero,
                                elevation: 4,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(50),
                                    bottomRight: Radius.circular(50),
                                  ),
                                ),
                                color: cardColor.withOpacity(0.9),
                                child: Container(
                                  width: double.infinity,
                                  height: 300,
                                  decoration: BoxDecoration(
                                    color: AppColors.mainColor,
                                    // Keep main color for branding
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(50),
                                      bottomRight: Radius.circular(50),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 50),
                                    child: Column(
                                      children: [
                                        Text(
                                          l10n.yourBalance,
                                          style: const TextStyle(
                                            fontSize: 30,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          '\$${walletState.balance}',
                                          style: const TextStyle(
                                            fontSize: 50,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                221, 255, 255, 255),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 70),
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: cardColor,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.1),
                                      blurRadius: 10,
                                      spreadRadius: 2,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Divider(
                                      indent: 30,
                                      endIndent: 30,
                                      height: 20,
                                      color:
                                          secondaryTextColor.withOpacity(0.5),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        l10n.transactions,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: textColor,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    ...transactionState.transactions
                                        .map((transaction) => TransactionItem(
                                              title:
                                                  transaction.transactionType,
                                              amount: transaction.amount,
                                              date: transaction.createdAt
                                                  .toString(),
                                              transactionDetails: transaction,
                                            )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                            top: 250,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _buildSquareActionButton(
                                    context,
                                    icon: Icons.add,
                                    label: l10n.deposit,
                                    color: const Color.fromARGB(
                                        255, 102, 181, 246),
                                    onPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              const MethodSelectionPage()),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  _buildSquareActionButton(
                                    context,
                                    icon: Icons.remove,
                                    label: l10n.withdraw,
                                    color:
                                        const Color.fromARGB(255, 93, 204, 68),
                                    onPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => const WithdrawPage(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return Container();
                },
              );
            }
            return Container();
          },
        );
      },
    );
  }

  Widget _buildSquareActionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        Color cardColor = Colors.white;
        if (themeState is ThemeLoaded) {
          cardColor = AppThemeHelper.getCardColor(themeState.theme);
        }

        return Column(
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 10,
                    spreadRadius: 4,
                    offset: const Offset(2, 6),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: onPressed,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(8),
                        child: Icon(icon, color: Colors.white, size: 24),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        label,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
