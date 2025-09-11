// presentation/pages/pin_verification_page.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/verification/verification_bloc.dart';
import '../bloc/verification/verification_event.dart';
import '../bloc/verification/verification_state.dart';

class PinVerificationPage extends StatelessWidget {
  const PinVerificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Verification Code'),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              context.read<VerificationBloc>().add(VerificationReset());
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            child: const Text('Start Over'),
          ),
        ],
      ),
      body: BlocConsumer<VerificationBloc, VerificationState>(
        listener: (context, state) {
          if (state is VerificationSuccess) {
            _showSuccessDialog(context);
          } else if (state is VerificationError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return const _PinVerificationForm();
        },
      ),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          icon: const Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 64,
          ),
          title: const Text('Verification Successful'),
          content: const Text('Your phone number has been verified successfully!'),
          actions: [
            ElevatedButton(
              //TODO
              onPressed: () {
                Navigator.of(dialogContext).pop();
                Navigator.of(context).popUntil((route) => route.isFirst);
                context.read<VerificationBloc>().add(VerificationReset());
              },
              child: const Text('Continue'),
            ),
          ],
        );
      },
    );
  }
}

class _PinVerificationForm extends StatefulWidget {
  const _PinVerificationForm();

  @override
  State<_PinVerificationForm> createState() => _PinVerificationFormState();
}

class _PinVerificationFormState extends State<_PinVerificationForm> {
  final _formKey = GlobalKey<FormState>();
  final _pinController = TextEditingController();

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.security,
              size: 80,
              color: Colors.green,
            ),
            const SizedBox(height: 32),
            const Text(
              'Enter verification code',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Check your Telegram bot for the 6-digit code',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            TextFormField(
              controller: _pinController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 8,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(6),
              ],
              decoration: const InputDecoration(
                labelText: 'Verification Code',
                hintText: '123456',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(vertical: 20),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter the verification code';
                }
                if (value.length != 6) {
                  return 'Code must be 6 digits';
                }
                return null;
              },
              onChanged: (value) {
                if (value.length == 6) {
                  _submitVerification();
                }
              },
            ),
            const SizedBox(height: 24),
            BlocBuilder<VerificationBloc, VerificationState>(
              builder: (context, state) {
                final isSubmitting = state is VerificationSubmitting;

                return ElevatedButton(
                  onPressed: isSubmitting ? null : _submitVerification,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: isSubmitting
                      ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                      : const Text(
                    'Verify Code',
                    style: TextStyle(fontSize: 16),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _submitVerification() {
    if (_formKey.currentState!.validate()) {
      context.read<VerificationBloc>().add(
        SubmitVerificationRequested(pin: _pinController.text.trim()),
      );
    }
  }
}