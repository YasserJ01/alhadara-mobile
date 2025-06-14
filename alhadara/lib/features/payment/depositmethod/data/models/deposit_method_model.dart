
import 'package:alhadara/features/payment/depositmethod/domain/entities/deposit_method_entity.dart';

class DepositMethodModel {
  final int id;
  final String name;
  final bool isActive;
  final List<BankInfoModel>? bankInfo;
  final List<TransferInfoModel>? transferInfo;

  DepositMethodModel({
    required this.id,
    required this.name,
    required this.isActive,
    this.bankInfo,
    this.transferInfo,
  });

  factory DepositMethodModel.fromJson(Map<String, dynamic> json) {
    return DepositMethodModel(
      id: json['id'],
      name: json['name'],
      isActive: json['is_active'],
      bankInfo: json['bank_info'] != null
          ? List<BankInfoModel>.from(
              json['bank_info'].map((x) => BankInfoModel.fromJson(x)))
          : null,
      transferInfo: json['transfer_info'] != null
          ? List<TransferInfoModel>.from(
              json['transfer_info'].map((x) => TransferInfoModel.fromJson(x)))
          : null,
    );
  }

  DepositMethodEntity toEntity() {
    return DepositMethodEntity(
      id: id,
      name: name,
      isActive: isActive,
      bankInfo: bankInfo?.map((e) => e.toEntity()).toList(),
      transferInfo: transferInfo?.map((e) => e.toEntity()).toList(),
    );
  }
}

class BankInfoModel {
  final int id;
  final int depositMethod;
  final String accountName;
  final String accountNumber;
  final String bankName;
  final String iban;

  BankInfoModel({
    required this.id,
    required this.depositMethod,
    required this.accountName,
    required this.accountNumber,
    required this.bankName,
    required this.iban,
  });

  factory BankInfoModel.fromJson(Map<String, dynamic> json) {
    return BankInfoModel(
      id: json['id'],
      depositMethod: json['deposit_method'],
      accountName: json['account_name'],
      accountNumber: json['account_number'],
      bankName: json['bank_name'],
      iban: json['iban'],
    );
  }

  BankInfoEntity toEntity() {
    return BankInfoEntity(
      id: id,
      depositMethod: depositMethod,
      accountName: accountName,
      accountNumber: accountNumber,
      bankName: bankName,
      iban: iban,
    );
  }
}

class TransferInfoModel {
  final int id;
  final int depositMethod;
  final String companyName;
  final String receiverName;
  final String receiverPhone;

  TransferInfoModel({
    required this.id,
    required this.depositMethod,
    required this.companyName,
    required this.receiverName,
    required this.receiverPhone,
  });

  factory TransferInfoModel.fromJson(Map<String, dynamic> json) {
    return TransferInfoModel(
      id: json['id'],
      depositMethod: json['deposit_method'],
      companyName: json['company_name'],
      receiverName: json['receiver_name'],
      receiverPhone: json['receiver_phone'],
    );
  }

  TransferInfoEntity toEntity() {
    return TransferInfoEntity(
      id: id,
      depositMethod: depositMethod,
      companyName: companyName,
      receiverName: receiverName,
      receiverPhone: receiverPhone,
    );
  }
}