import 'package:equatable/equatable.dart';
import 'dart:io';

abstract class DepositRequestEvent extends Equatable {
  const DepositRequestEvent();

  @override
  List<Object> get props => [];
}

class CreateDepositRequestEvent extends DepositRequestEvent {
  final File screenshotFile;
  final int depositMethodId;
  final String transactionNumber;
  final double amount;

  const CreateDepositRequestEvent({
    required this.screenshotFile,
    required this.depositMethodId,
    required this.transactionNumber,
    required this.amount,
  });

  @override
  List<Object> get props => [screenshotFile, depositMethodId, transactionNumber, amount];
}
