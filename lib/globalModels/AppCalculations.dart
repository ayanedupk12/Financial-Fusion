import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ffapp/globalModels/UserInfo.dart';

class AppCalculations {
  List<BalanceEntry> totalBalance;
  double profit;
  double equity;
  double highest;

  AppCalculations({
    required this.totalBalance,
    required this.profit,
    required this.equity,
    required this.highest,
  });

  // Factory method to create a BalanceInformation object from a Firestore document snapshot
  factory AppCalculations.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final List<dynamic> balanceList = data['totalBalance'] ?? [];

    return AppCalculations(
      totalBalance: balanceList.map((balanceEntryData) => BalanceEntry.fromJson(balanceEntryData)).toList(),
      profit: (data['profit']).toDouble() ?? 0.0,
      equity: (data['equity']).toDouble() ?? 0.0,
      highest: (data['highest']).toDouble() ?? 0.0,
    );
  }

  // Convert BalanceInformation object to a JSON object
  Map<String, dynamic> toJson() {
    final balanceJsonList = totalBalance.map((entry) => entry.toJson()).toList();
    // final totalBalanceJsonList = totalBalance.map((entry) => entry.toJson()).toList();
    return {
      'totalBalance': balanceJsonList,
      'profit': profit,
      'equity': equity,
      'highest': highest,
    };
  }
}