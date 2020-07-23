import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

import './chart_bar.dart';

class Chart extends StatelessWidget {
  List<Transaction> transactions;

  Chart(this.transactions);

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.0;

      for (var tx in transactions) {
        if (tx.date.day == weekDay.day &&
            tx.date.month == weekDay.month &&
            tx.date.year == weekDay.year) {
          totalSum += tx.amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay)[0],
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactions.fold(0.0, (previousValue, element) {
      return previousValue + element['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactions.map((item) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label: item['day'],
                spendingAmount: item['amount'],
                spendingPctOfTotal: totalSpending == 0.0
                    ? 0.0
                    : (item['amount'] as double) / totalSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
