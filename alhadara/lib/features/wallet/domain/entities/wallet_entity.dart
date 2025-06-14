class WalletEntity {
  final int id;
  final int user;
  final String userUsername;
  final String currentBalance;
  final DateTime lastUpdated;

  WalletEntity({
    required this.id,
    required this.user,
    required this.userUsername,
    required this.currentBalance,
    required this.lastUpdated,
  });
  
}