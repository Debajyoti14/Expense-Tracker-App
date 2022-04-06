import 'package:expense_tracker_app/Widgets/transaction_list.dart';
import 'package:flutter/material.dart';

import '../Models/transaction.dart';
import 'new_transaction.dart';

class userTransaction extends StatefulWidget {
  @override
  State<userTransaction> createState() => _userTransactionState();
}

class _userTransactionState extends State<userTransaction> {
  final List<Transaction> _usertransactions = [
    Transaction(
      id: 't1',
      title: 'Eating Lunch',
      amount: 50.00,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Go to College',
      amount: 30.00,
      date: DateTime.now(),
    ),
  ];
  void _addNewTransactions(String title, double amount) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: DateTime.now());
    setState(() {
      _usertransactions.add(newTx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      newTransaction(_addNewTransactions),
      userTransactionList(_usertransactions)
    ]);
  }
}
