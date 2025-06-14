import 'package:alhadara/core/constants/app_elevated_button.dart';
import 'package:alhadara/core/constants/app_size.dart';
import 'package:alhadara/core/constants/colors.dart';
import 'package:alhadara/features/payment/depositmethod/presentation/bloc/deposit/deposit_bloc.dart';
import 'package:alhadara/features/payment/depositmethod/presentation/pages/new/bank_selection_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MethodSelectionForm extends StatelessWidget {
  const MethodSelectionForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DepositBloc, DepositState>(
      builder: (context, state) {
        if (state is DepositLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is DepositError) {
          return Center(child: Text(state.message));
        } else if (state is DepositLoaded) {
          return Padding(
            padding: EdgeInsets.all(AppSizes.responsiveSize(context,
                mobile: 16, tablet: 24, desktop: 32)),
            child: Column(
              children: [
                SizedBox(
                  height: 25,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.methods.length,
                    itemBuilder: (context, index) {
                      final method = state.methods[index];
                      final isSelected = state.selectedMethod?.id == method.id;
                      final isBankTransfer = method.name == 'bank_transfer';
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        color: isSelected
                            ? AppColors.mainColor
                            : const Color.fromARGB(255, 228, 154, 154),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              AppSizes.screenWidth(context) * 0.02),
                        ),
                        child: ListTile(
                          leading: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color.fromARGB(255, 247, 222, 224),
                            ),
                            child: Icon(
                              isBankTransfer
                                  ? Icons.account_balance
                                  : Icons.monetization_on,
                              color: AppColors.mainColor,
                              size: 28,
                            ),
                          ),
                          title: Text(
                            method.name,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: AppSizes.responsiveFontSize(context,
                                  mobile: 22, tablet: 24, desktop: 26),
                              fontWeight: FontWeight.w400,
                              color: AppColors.whiteColor,
                            ),
                          ),
                          onTap: () {
                            context
                                .read<DepositBloc>()
                                .add(SelectMethodType(method));
                          },
                        ),
                      );
                    },
                  ),
                ),
                if (state.selectedMethod != null)
                  Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: AppElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => BlocProvider.value(
                                  value: context.read<DepositBloc>(),
                                  child: const BankSelectionPage(),
                                ),
                              ),
                            );
                          },
                          child: Text(
                            'Next',
                            style: TextStyle(
                              fontSize: AppSizes.responsiveFontSize(context,
                                  mobile: 18, tablet: 20, desktop: 22),
                              fontWeight: FontWeight.w400,
                              color: AppColors.whiteColor,
                            ),
                          ))),
              ],
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
