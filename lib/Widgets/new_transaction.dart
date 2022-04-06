import 'package:flutter/material.dart';

class newTransaction extends StatefulWidget {
  final Function AddTx;
  newTransaction(this.AddTx);

  @override
  State<newTransaction> createState() => _newTransactionState();
}

class _newTransactionState extends State<newTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submitData() {
    final enteredTitles = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitles.isEmpty || enteredAmount <= 0) {
      return;
    }
    widget.AddTx(enteredTitles, enteredAmount);

    Navigator.of(context).pop();
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
              FlatButton(
                  onPressed: () => submitData,
                  textColor: Colors.purple,
                  child: Text('Add Transcript'))
            ],
          ),
        ));
  }
}
