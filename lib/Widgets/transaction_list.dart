// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Models/transaction.dart';

// ignore: camel_case_types
class userTransactionList extends StatefulWidget {
  final List<Transaction> transactions;

  final Function deleteTransaction;
  const userTransactionList(this.transactions, this.deleteTransaction,
      {Key? key})
      : super(key: key);

  @override
  State<userTransactionList> createState() => _userTransactionListState();
}

// ignore: camel_case_types
class _userTransactionListState extends State<userTransactionList> {
  Color? _bgColor;

  @override
  void initState() {
    super.initState();
    const availableColors = [
      Colors.black,
      Colors.purple,
      Colors.blue,
      Colors.deepOrange
    ];
    _bgColor = availableColors[Random().nextInt(4)];
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 300,
        child: widget.transactions.isEmpty
            ? Column(
                children: <Widget>[
                  Text('No transactions added yet',
                      style: TextStyle(
                          fontFamily: 'QuickSand',
                          fontWeight: FontWeight.bold,
                          fontSize: 20)),
                  SizedBox(height: 15),
                  SizedBox(
                      height: 200,
                      child: Image.asset('assets/images/waiting.png',
                          fit: BoxFit.cover))
                ],
              )
            : ListView.builder(
                itemBuilder: (ctx, index) {
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: _bgColor,
                        radius: 30,
                        child: Padding(
                          padding: EdgeInsets.all(6),
                          child: FittedBox(
                            child:
                                Text('₹${widget.transactions[index].amount}'),
                          ),
                        ),
                      ),
                      title: Text(
                        widget.transactions[index].title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      subtitle: Text(
                        DateFormat.yMMMd()
                            .format(widget.transactions[index].date),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        color: Colors.red,
                        onPressed: () => widget
                            .deleteTransaction(widget.transactions[index].id),
                      ),
                    ),
                  );
                },
                itemCount: widget.transactions.length,
              ));
  }
}
