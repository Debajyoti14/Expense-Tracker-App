import 'package:flutter/material.dart';

class newTransaction extends StatelessWidget {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final Function AddTx;

  newTransaction(this.AddTx);
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
              ),
              TextField(
                  controller: amountController,
                  decoration: InputDecoration(labelText: 'Amount')),
              FlatButton(
                  onPressed: () {
                    AddTx(titleController.text,
                        double.parse(amountController.text));
                  },
                  textColor: Colors.purple,
                  child: Text('Add Transcript'))
            ],
          ),
        ));
  }
}
