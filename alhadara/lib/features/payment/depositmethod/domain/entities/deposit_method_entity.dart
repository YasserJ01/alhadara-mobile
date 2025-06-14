
class DepositMethodEntity {
  final int id;
  final String name;
  final bool isActive;
  final List<BankInfoEntity>? bankInfo;
  final List<TransferInfoEntity>? transferInfo;

  DepositMethodEntity({
    required this.id,
    required this.name,
    required this.isActive,
    this.bankInfo,
    this.transferInfo,
  });
}

class BankInfoEntity {
  final int id;
  final int depositMethod;
  final String accountName;
  final String accountNumber;
  final String bankName;
  final String iban;

  BankInfoEntity({
    required this.id,
    required this.depositMethod,
    required this.accountName,
    required this.accountNumber,
    required this.bankName,
    required this.iban,
  });
}

class TransferInfoEntity {
  final int id;
  final int depositMethod;
  final String companyName;
  final String receiverName;
  final String receiverPhone;

  TransferInfoEntity({
    required this.id,
    required this.depositMethod,
    required this.companyName,
    required this.receiverName,
    required this.receiverPhone,
  });
}