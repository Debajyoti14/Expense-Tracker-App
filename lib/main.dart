// ignore_for_file: prefer_const_constructors

import 'package:expense_tracker_app/transaction.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final List<Transaction> transactions = [
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 30,
              child: Card(
                color: Colors.blue,
                child: Text('Chart'),
                elevation: 5,
              ),
            ),
            Column(
              children: transactions
                  .map((transaction) => Card(
                        child: Row(children: <Widget>[
                          Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.purple, width: 2)),
                              padding: EdgeInsets.all(10),
                              child: Text('₹ ${transaction.amount}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.purple,
                                      fontSize: 20))),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(transaction.title,
                                    style: TextStyle(
                                        color: Colors.purple,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400)),
                                Text(transaction.date.toString(),
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 66, 66, 66),
                                        fontSize: 10))
                              ])
                        ]),
                      ))
                  .toList(),
            )
          ]),
    );
  }
}