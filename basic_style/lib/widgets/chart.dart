import 'dart:ffi';

import 'package:basic_style/models/transaction.dart';
import 'package:basic_style/widgets/chartBar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  Chart(this.recentTransactions);

  List<Map<String, dynamic>> get groupTransactionValue {
    return List.generate(7, (index) {
      // subtract: thời gian hiện tại lùi đi 7 ngày
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      var totalSum = 0.0;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }
      return {'day': DateFormat.E().format(weekDay), 'amount': totalSum};
    });
  }

  double get totalSpending {
    return groupTransactionValue.fold(
        0.0, (previousValue, element) => previousValue + element['amount']);
  }

  @override
  Widget build(BuildContext context) {
    print(groupTransactionValue);
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: groupTransactionValue.map((e) {
          return Flexible(
            fit: FlexFit.tight,
            child: ChartBar(e['day'], e['amount'],
                totalSpending == 0.0 ? 0.0 : e['amount'] / totalSpending),
          );
        }).toList(),
      ),
    );
  }
}
