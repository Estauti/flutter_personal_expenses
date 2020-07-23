import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  List<Transaction> transactions;
  Function deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      'No Transactions added yet!',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset('assets/images/waiting.png'),
                  )
                ],
              );
            },
          )
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (ctx, index) {
              final transaction = transactions[index];

              return Card(
                margin: EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 20,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: FittedBox(
                        child:
                            Text("\$${transaction.amount.toStringAsFixed(2)}"),
                      ),
                    ),
                  ),
                  title: Text(
                    transaction.title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  subtitle: Text(
                    DateFormat('dd/MM/y').format(transaction.date),
                  ),
                  trailing: MediaQuery.of(context).size.width > 450
                      ? FlatButton.icon(
                          onPressed: () => deleteTransaction(transaction.id),
                          icon: Icon(Icons.delete),
                          label: Text('Delete'),
                          textColor: Theme.of(context).errorColor,
                        )
                      : IconButton(
                          color: Theme.of(context).errorColor,
                          icon: Icon(Icons.delete),
                          onPressed: () => deleteTransaction(transaction.id),
                        ),
                ),
              );
            },
          );
  }
}
