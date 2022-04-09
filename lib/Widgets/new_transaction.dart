// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class newTransaction extends StatefulWidget {
  final Function AddTx;
  newTransaction(this.AddTx);

  @override
  State<newTransaction> createState() => _newTransactionState();
}

class _newTransactionState extends State<newTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  DateTime? selectedDate;

  void submitData() {
    if (amountController.text.isEmpty) {
      return;
    }
    final enteredTitles = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitles.isEmpty || enteredAmount <= 0 || selectedDate == null) {
      return;
    }
    widget.AddTx(
      enteredTitles,
      enteredAmount,
      selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2003),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        selectedDate = pickedDate;
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
            children: <Widget>[
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
                onSubmitted: (_) => submitData(),
              ),
              TextField(
                controller: amountController,
                decoration: InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
                onSubmitted: (_) => submitData(),
              ),
              Container(
                  height: 70,
                  child: Row(children: <Widget>[
                    Expanded(
                      child: Text(selectedDate == null
                          ? 'No date Chosen'
                          : DateFormat.yMd().format(selectedDate!)),
                    ),
                    Container(
                      child: FlatButton(
                          textColor: Theme.of(context).primaryColor,
                          child: Text(
                            'Choose Date',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          onPressed: _presentDatePicker),
                    ),
                  ])),
              RaisedButton(
                  onPressed: () => submitData,
                  color: Colors.purple,
                  textColor: Colors.white,
                  child: Text('Add Transcript'))
            ],
          ),
        ));
  }
}
