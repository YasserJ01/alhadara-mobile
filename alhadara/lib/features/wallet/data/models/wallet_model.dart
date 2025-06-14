import 'package:alhadara/features/wallet/domain/entities/wallet_entity.dart';

class WalletModel {
  final int id;
  final int user;
  final String userUsername;
  final String currentBalance;
  final DateTime lastUpdated;

  WalletModel({
    required this.id,
    required this.user,
    required this.userUsername,
    required this.currentBalance,
    required this.lastUpdated,
  });

  factory WalletModel.fromJson(Map<String, dynamic> json) {
    return WalletModel(
      id: json['id'] ?? 0, // Default value if null
      user: json['user'] ?? 0,
      userUsername: json['user_username'] ?? '', // Empty string if null
      currentBalance: json['current_balance']?.toString() ?? '0.00', // Ensure string and provide default
      lastUpdated: json['last_updated'] != null 
          ? DateTime.parse(json['last_updated'])
          : DateTime.now(), // Current date if null
    );
  }

  WalletEntity toEntity() {
    return WalletEntity(
      id: id,
      user: user,
      userUsername: userUsername,
      currentBalance: currentBalance,
      lastUpdated: lastUpdated,
    );
  }
}