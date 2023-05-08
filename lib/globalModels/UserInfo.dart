import 'package:cloud_firestore/cloud_firestore.dart';
class UserInformation {
  String userId;
  String userType;
  String name;
  String phone;
  List<BalanceEntry> balance;
  String idFrontSide;
  String idBackSide;
  String email;
  double profit;
  String? profile;

  UserInformation({
    required this.userId,
    required this.userType,
    required this.name,
    required this.phone,
    required this.balance,
    required this.idFrontSide,
    required this.idBackSide,
    required this.email,
    required this.profit,
    required this.profile,
  });

  // Factory method to create a UserInfo object from a Firestore document snapshot
  factory UserInformation.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final List<dynamic> balanceList = data['balance'] ?? [];

    return UserInformation(
      userId: data['userId'],
      userType: data['userType'],
      name: data['name'],
      phone: data['phone'],
      balance: balanceList.map((balanceEntryData) => BalanceEntry.fromJson(balanceEntryData)).toList(),
      idFrontSide: data['idFrontSide'],
      idBackSide: data['idBackSide'],
      email: data['email'],
      profit: data['profit'],
      profile: data['profile'],
    );
  }

  // Convert UserInfo object to a JSON object
  Map<String, dynamic> toJson() {
    final balanceJsonList = balance.map((entry) => entry.toJson()).toList();
    return {
      'userId': userId,
      'userType': userType,
      'name': name,
      'phone': phone,
      'balance': balanceJsonList,
      'idFrontSide': idFrontSide,
      'idBackSide': idBackSide,
      'email': email,
      'profit': profit,
      'profile': profile,
    };
  }
}

class BalanceEntry {
  final double amount;
  final DateTime date;

  BalanceEntry({
    required this.amount,
    required this.date,
  });

  // Convert BalanceEntry object to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'amount': (amount).toDouble(),
      'date': date.toIso8601String(),
    };
  }

  // Create a new BalanceEntry object from a JSON object
  factory BalanceEntry.fromJson(Map<String, dynamic> json) {
    return BalanceEntry(
      amount: json['amount'],
      date: DateTime.parse(json['date']),
    );
  }
}