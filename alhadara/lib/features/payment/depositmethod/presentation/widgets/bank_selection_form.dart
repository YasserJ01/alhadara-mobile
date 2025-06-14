  import 'package:alhadara/core/constants/app_elevated_button.dart';
  import 'package:alhadara/core/constants/app_size.dart';
  import 'package:alhadara/core/constants/colors.dart';
  import 'package:alhadara/features/payment/depositmethod/presentation/bloc/deposit/deposit_bloc.dart';
  import 'package:alhadara/features/payment/depositmethod/presentation/pages/new/payment_details_page.dart';
  import 'package:flutter/material.dart';
  import 'package:flutter_bloc/flutter_bloc.dart';

  class BankSelectionForm extends StatelessWidget {
    const BankSelectionForm({super.key});

    @override
    Widget build(BuildContext context) {
      return BlocBuilder<DepositBloc, DepositState>(
        builder: (context, state) {
          if (state is! DepositLoaded || state.selectedMethod == null) {
            return const Center(child: Text('Please select a method first'));
          }

          final method = state.selectedMethod!;

          return Padding(
            padding: EdgeInsets.all(AppSizes.responsiveSize(context,
                mobile: 16, tablet: 24, desktop: 32)),
            child: Column(
              children: [
                SizedBox(
                  height: 25,
                ),
                Expanded(
                  child: method.name == 'bank_transfer'
                      ? ListView.builder(
                          itemCount: method.bankInfo?.length ?? 0,
                          itemBuilder: (context, index) {
                            final bank = method.bankInfo![index];
                            final isSelected = state.selectedBank?.id == bank.id;
                            return Stack(
                              children: [
                                Card(
                                  elevation: 3,
                                  margin: EdgeInsets.all(10),
                                  color: isSelected
                                      ? AppColors.mainColor
                                      : const Color.fromARGB(255, 228, 154, 154),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        AppSizes.screenWidth(context) * 0.02),
                                  ),
                                  child: ListTile(
                                    title: Text(
                                      bank.bankName,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: AppSizes.responsiveFontSize(
                                            context,
                                            mobile: 22,
                                            tablet: 24,
                                            desktop: 26),
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.whiteColor,
                                      ),
                                    ),
                                    onTap: () {
                                      context
                                          .read<DepositBloc>()
                                          .add(SelectBank(bank));
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Container(
                                    width: 80,
                                    height: 56,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(
                                            AppSizes.screenWidth(context) * 0.02),
                                        bottomLeft: Radius.circular(
                                            AppSizes.screenWidth(context) * 0.02),
                                      ),
                                      color: Color.fromARGB(255, 68, 48, 50),
                                    ),
                                    child: ClipRRect(
                                      child: Image.asset(
                                        'assets/chamjpg.jpg',
                                        fit: BoxFit.fill,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Container(
                                            width: 10,
                                            color: const Color.fromARGB(
                                                255, 247, 222, 224),
                                            child: Icon(
                                              Icons.school,
                                              color: AppColors.mainColor,
                                              size: 22,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        )
                      : ListView.builder(
                          itemCount: method.transferInfo?.length ?? 0,
                          itemBuilder: (context, index) {
                            final company = method.transferInfo![index];
                            final isSelected =
                                state.selectedCompany?.id == company.id;
                            return Stack(
                              children: [
                                Card(
                                  margin: EdgeInsets.all(10),
                                  color: isSelected
                                      ? AppColors.mainColor
                                      : const Color.fromARGB(255, 228, 154, 154),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        AppSizes.screenWidth(context) * 0.02),
                                  ),
                                  child: ListTile(
                                    title: Text(
                                      company.companyName,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: AppSizes.responsiveFontSize(
                                            context,
                                            mobile: 22,
                                            tablet: 24,
                                            desktop: 26),
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.whiteColor,
                                      ),
                                    ),
                                    onTap: () {
                                      context
                                          .read<DepositBloc>()
                                          .add(SelectTransferCompany(company));
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Container(
                                    width: 80,
                                    height: 56,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(
                                            AppSizes.screenWidth(context) * 0.02),
                                        bottomLeft: Radius.circular(
                                            AppSizes.screenWidth(context) * 0.02),
                                      ),
                                      color: Color.fromARGB(255, 68, 48, 50),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.asset(
                                        'assets/yass.jpg',
                                        width: 80,
                                        height: 56,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Container(
                                            width: 10,
                                            color: const Color.fromARGB(
                                                255, 247, 222, 224),
                                            child: Icon(
                                              Icons.school,
                                              color: AppColors.mainColor,
                                              size: 22,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                ),
                if ((method.name == 'bank_transfer' &&
                        state.selectedBank != null) ||
                    (method.name == 'money_transfer' &&
                        state.selectedCompany != null))
                  Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: AppElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => BlocProvider.value(
                                  value: context.read<DepositBloc>(),
                                  child: const PaymentDetailsPage(),
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
                          ))
                      //  ElevatedButton(
                      //   onPressed: () {

                      //   },
                      //   child: const Text('Next'),
                      // ),
                      ),
              ],
            ),
          );
        },
      );
    }
  }
