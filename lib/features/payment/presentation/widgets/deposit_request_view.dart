import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        SnackBar(content: Text('Error picking image: $e')),
      );
    }
  }

  Future<void> _takePhoto() async {
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
        SnackBar(content: Text('Error taking photo: $e')),
      );
    }
  }

  void _submitDepositRequest() {
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
        const SnackBar(
          content: Text('Please select a transaction screenshot'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Image Source'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () {
                Navigator.pop(context);
                _pickImage();
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Deposit Request'),
        backgroundColor: Colors.transparent,
        foregroundColor: Color.fromRGBO(162, 12, 13, 1.0),
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
            Navigator.pop(context, true);
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
                  const Text(
                    'Transaction Screenshot',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),

                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!, width: 2),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey[100],
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
                        : const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.image,
                                size: 60,
                                color: Colors.grey,
                              ),
                              SizedBox(height: 10),
                              Text(
                                'No screenshot selected',
                                style: TextStyle(color: Colors.grey),
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
                      icon: const Icon(Icons.add_a_photo),
                      label: Text(_selectedImage == null
                          ? 'Add Screenshot'
                          : 'Change Screenshot'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        backgroundColor: Color.fromRGBO(162, 12, 13, 1.0),
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Transaction Number Field
                  const Text(
                    'Transaction Number',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _transactionNumberController,
                    enabled: state is! DepositRequestLoading,
                    decoration: const InputDecoration(
                      hintText: 'Enter transaction number',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.confirmation_number),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Transaction number is required';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  // Amount Field
                  const Text(
                    'Amount',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _amountController,
                    enabled: state is! DepositRequestLoading,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Enter amount',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.attach_money),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Amount is required';
                      }
                      final amount = double.tryParse(value.trim());
                      if (amount == null || amount <= 0) {
                        return 'Please enter a valid amount';
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
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : const Icon(Icons.send),
                      label: Text(state is DepositRequestLoading
                          ? 'Submitting...'
                          : 'Submit Request'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        backgroundColor: Color.fromRGBO(162, 12, 13, 1.0),
                        foregroundColor: Colors.white,
                        textStyle: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Progress Indicator
                  if (state is DepositRequestLoading)
                    const Column(
                      children: [
                        LinearProgressIndicator(),
                        SizedBox(height: 10),
                        Text('Submitting your deposit request...'),
                      ],
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
