import 'package:alhadara/core/constants/colors.dart';
import 'package:alhadara/features/payment/depositmethod/presentation/pages/new/bank_selection_page.dart';
import 'package:alhadara/features/payment/depositmethod/presentation/pages/new/method_selection_page.dart';
import 'package:alhadara/features/wallet/presentation/bloc/transaction_bloc/transaction_bloc.dart';
import 'package:alhadara/features/wallet/presentation/bloc/wallet_bloc.dart';
import 'package:alhadara/features/wallet/presentation/pages/withdraw_page.dart';
import 'package:alhadara/features/wallet/presentation/widgets/transaction_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WalletForm extends StatelessWidget {
  const WalletForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletBloc, WalletState>(
      builder: (context, walletState) {
        if (walletState is WalletLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (walletState is WalletError) {
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
                            color: Colors.white.withOpacity(0.9),
                            child: Container(
                              width: double.infinity,
                              height: 300,
                              decoration: const BoxDecoration(
                                color: AppColors.mainColor,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(50),
                                  bottomRight: Radius.circular(50),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 50),
                                child: Column(
                                  children: [
                                    const Text(
                                      'Your Balance',
                                      style: TextStyle(
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
                                        color:
                                            Color.fromARGB(221, 255, 255, 255),
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
                              color: Colors.white.withOpacity(0.85),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              children: [
                                Divider(
                                  indent: 30,
                                  endIndent: 30,
                                  height: 20,
                                  color: Color.fromARGB(255, 133, 130, 130),
                                ),
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Transactions',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                ...transactionState.transactions
                                    .map((transaction) => TransactionItem(
                                          title: transaction.transactionType,
                                          amount: transaction.amount,
                                          date:
                                              transaction.createdAt.toString(),
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
                                label: 'DEPOSIT',
                                color: Color.fromARGB(255, 102, 181, 246),
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
                                label: 'WITHDRAW',
                                color: Color.fromARGB(255, 93, 204, 68),
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
  }

  Widget _buildSquareActionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Column(
      children: [
        Container(
          width: 90,
          height: 90,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 126, 124, 124).withOpacity(0.3),
                blurRadius: 10,
                spreadRadius: 4,
                offset: Offset(2, 6),
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
  }
}
