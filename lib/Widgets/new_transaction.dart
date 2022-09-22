// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: camel_case_types
class newTransaction extends StatefulWidget {
  // ignore: non_constant_identifier_names
  final Function AddTx;
  const newTransaction(this.AddTx, {Key? key}) : super(key: key);

  @override
  State<newTransaction> createState() => _newTransactionState();
}

// ignore: camel_case_types
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
    return SingleChildScrollView(
      child: Card(
          elevation: 5,
          child: Container(
            padding: EdgeInsets.only(
              top: 10,
              right: 10,
              left: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10,
            ),
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
                SizedBox(
                    height: 70,
                    child: Row(children: <Widget>[
                      Expanded(
                        child: Text(selectedDate == null
                            ? 'No date Chosen'
                            : DateFormat.yMd().format(selectedDate!)),
                      ),
                      TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Theme.of(context).primaryColor,
                          ),
                          child: Text(
                            'Choose Date',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          onPressed: _presentDatePicker),
                    ])),
                ElevatedButton(
                    onPressed: () => submitData(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.purple, // background (button) color
                      foregroundColor: Colors.white, // foreground (text) color
                    ),
                    child: Text('Add Transcript'))
              ],
            ),
          )),
    );
  }
}
