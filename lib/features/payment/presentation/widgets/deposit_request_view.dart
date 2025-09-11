import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/l10n/generated/app_localizations.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/theme/app_theme_helper.dart';
import '../../../../theme/presentation/bloc/theme_bloc.dart';
import '../../../../theme/presentation/bloc/theme_state.dart';
import '../../../wallet/presentation/pages/wallet_page.dart';
import '../bloc/deposit_request/deposit_request_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../bloc/deposit_request/deposit_request_event.dart';
import '../bloc/deposit_request/deposit_request_state.dart';

class DepositRequestView extends StatefulWidget {
  final int depositMethodId;

  const DepositRequestView({
    Key? key,
    required this.depositMethodId,
  }) : super(key: key);

  @override
  State<DepositRequestView> createState() => _DepositRequestViewState();
}

class _DepositRequestViewState extends State<DepositRequestView> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _transactionNumberController =
      TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _pickImage() async {
    final l10n = AppLocalizations.of(context);
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${l10n.errorPickingImage}: $e')),
      );
    }
  }

  Future<void> _takePhoto() async {
    final l10n = AppLocalizations.of(context);

    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${l10n.errorTakingPhoto}: $e')),
      );
    }
  }

  void _submitDepositRequest() {
    final l10n = AppLocalizations.of(context);
    if (_formKey.currentState!.validate() && _selectedImage != null) {
      final transactionNumber = _transactionNumberController.text.trim();
      final amount = double.tryParse(_amountController.text.trim()) ?? 0.0;

      context.read<DepositRequestBloc>().add(
            CreateDepositRequestEvent(
              screenshotFile: _selectedImage!,
              depositMethodId: widget.depositMethodId,
              transactionNumber: transactionNumber,
              amount: amount,
            ),
          );
    } else if (_selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.pleaseSelectTransactionScreenshot),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showImageSourceDialog() {
    final l10n = AppLocalizations.of(context);

    final themeState = context.read<ThemeBloc>().state;
    Color cardColor = Colors.white;
    Color textColor = AppColors.mainColor;

    if (themeState is ThemeLoaded) {
      cardColor = AppThemeHelper.getCardColor(themeState.theme);
      textColor = AppThemeHelper.getTextColor(themeState.theme);
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: cardColor,
        title: Text(
          l10n.selectImageSource,
          style: TextStyle(color: textColor),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.photo_library, color: textColor),
              title: Text(
                l10n.gallery,
                style: TextStyle(color: textColor),
              ),
              onTap: () {
                Navigator.pop(context);
                _pickImage();
              },
            ),
            ListTile(
              leading: Icon(Icons.camera_alt, color: textColor),
              title: Text(
                l10n.camera,
                style: TextStyle(color: textColor),
              ),
              onTap: () {
                Navigator.pop(context);
                _takePhoto();
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _transactionNumberController.dispose();
    _amountController.dispose();
    super.dispose();
  }

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
          secondaryTextColor =
              AppThemeHelper.getSecondaryTextColor(themeState.theme);
        }

        return Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            title: Text(
              l10n.createDepositRequest,
              style: TextStyle(color: textColor),
            ),
            backgroundColor: cardColor,
            foregroundColor: textColor,
            elevation: 0,
          ),
          body: BlocConsumer<DepositRequestBloc, DepositRequestState>(
            listener: (context, state) {
              if (state is DepositRequestSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Deposit request submitted successfully!'),
                    backgroundColor: Colors.green,
                  ),
                );
                Navigator.pop(context,true);
              } else if (state is DepositRequestError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            builder: (context, state) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Transaction Screenshot Section
                      Text(
                        l10n.transactionScreenshot,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: 10),

                      Container(
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: secondaryTextColor.withOpacity(0.3),
                              width: 2),
                          borderRadius: BorderRadius.circular(8),
                          color: cardColor,
                        ),
                        child: _selectedImage != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Image.file(
                                  _selectedImage!,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: 200,
                                ),
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.image,
                                    size: 60,
                                    color: secondaryTextColor,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    l10n.noScreenshotSelected,
                                    style: TextStyle(color: secondaryTextColor),
                                  ),
                                ],
                              ),
                      ),

                      const SizedBox(height: 15),

                      // Select Image Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: state is DepositRequestLoading
                              ? null
                              : _showImageSourceDialog,
                          icon: Icon(Icons.add_a_photo, color: Colors.white),
                          label: Text(
                            _selectedImage == null
                                ? l10n.addScreenshot
                                : l10n.changeScreenshot,
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            backgroundColor: textColor,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      // Transaction Number Field
                      Text(
                        l10n.transactionNumber,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _transactionNumberController,
                        enabled: state is! DepositRequestLoading,
                        decoration: InputDecoration(
                          hintText: l10n.enterTransactionNumber,
                          border: const OutlineInputBorder(),
                          prefixIcon:
                              Icon(Icons.confirmation_number, color: textColor),
                          filled: true,
                          fillColor: cardColor,
                        ),
                        style: TextStyle(color: textColor),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return l10n.transactionNumberRequired;
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 20),

                      // Amount Field
                      Text(
                        l10n.amount,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _amountController,
                        enabled: state is! DepositRequestLoading,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: l10n.enterAmount,
                          border: const OutlineInputBorder(),
                          prefixIcon:
                              Icon(Icons.attach_money, color: textColor),
                          filled: true,
                          fillColor: cardColor,
                        ),
                        style: TextStyle(color: textColor),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return l10n.amountRequired;
                          }
                          final amount = double.tryParse(value.trim());
                          if (amount == null || amount <= 0) {
                            return l10n.pleaseEnterValidAmount;
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 30),

                      // Submit Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: state is DepositRequestLoading
                              ? null
                              : _submitDepositRequest,
                          icon: state is DepositRequestLoading
                              ? SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                  ),
                                )
                              : Icon(Icons.send, color: Colors.white),
                          label: Text(
                            state is DepositRequestLoading
                                ? l10n.submitting
                                : l10n.submitRequest,
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            backgroundColor: textColor,
                            foregroundColor: Colors.white,
                            textStyle: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Progress Indicator
                      if (state is DepositRequestLoading)
                        Column(
                          children: [
                            LinearProgressIndicator(
                              backgroundColor:
                                  secondaryTextColor.withOpacity(0.2),
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(textColor),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              l10n.submittingDepositRequest,
                              style: TextStyle(color: secondaryTextColor),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
