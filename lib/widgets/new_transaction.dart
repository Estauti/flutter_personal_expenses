import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  NewTransaction(this.addTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void submitForm() {
    final inputTitle = _titleController.text;
    final inputAmount = double.parse(_amountController.text);

    if (inputTitle.isEmpty || inputAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTransaction(inputTitle, inputAmount, _selectedDate);

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((selectedDate) {
      if (selectedDate == null) {
        return;
      }

      setState(() {
        _selectedDate = selectedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: _titleController,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: _amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitForm(),
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Text(_selectedDate == null
                          ? 'No date chosen!'
                          : 'Picked Date: ${DateFormat('dd/MM/y').format(_selectedDate)}')),
                  Platform.isIOS
                      ? CupertinoButton(
                          child: Text(
                            'Choose date',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: _presentDatePicker,
                        )
                      : FlatButton(
                          onPressed: _presentDatePicker,
                          child: Text(
                            'Choose date',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                ],
              ),
            ),
            RaisedButton(
              onPressed: () => submitForm(),
              child: Text('Add Transaction'),
              color: Theme.of(context).primaryColor,
              textColor: Theme.of(context).textTheme.button.color,
            )
          ],
        ),
      ),
    );
  }
}
