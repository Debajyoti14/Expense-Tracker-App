// ignore_for_file: prefer_const_constructors

import 'package:expense_tracker_app/Models/transaction.dart';
import 'package:expense_tracker_app/Widgets/chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

import 'Widgets/new_transaction.dart';
import 'Widgets/transaction_list.dart';

import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';

void main() {
  // add this, and it should be the first line in main method
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Tracker',
      theme: ThemeData(
        fontFamily: 'QuickSand',
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
            .copyWith(secondary: Colors.amber),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  final SmsQuery _query = SmsQuery();
  List<SmsMessage> _messages = [];

  void retrieveSMS() async {
    var permission = await Permission.sms.status;
    if (permission.isGranted) {
      final messages = await _query.querySms(
        kinds: [SmsQueryKind.inbox, SmsQueryKind.sent],
        // address: '+254712345789',
        count: 10,
      );
      debugPrint('sms inbox messages: ${messages.length}');

      setState(() => _messages = messages);
      print(_messages);
    } else {
      await Permission.sms.request();
    }
  }

  final List<Transaction> _usertransactions = [
    // Transaction(
    //   id: 't1',
    //   title: 'Eating Lunch',
    //   amount: 50.00,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'Go to College',
    //   amount: 30.00,
    //   date: DateTime.now(),
    // ),
  ];

  void initstate() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // ignore: avoid_print
    print(state);
  }

  @override
  dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  List<Transaction> get _recentTransactions {
    return _usertransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransactions(String title, double amount, DateTime chosenDate) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: chosenDate);
    setState(() {
      _usertransactions.add(newTx);
    });
  }

  void startAddNewTransactions(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            child: newTransaction(_addNewTransactions),
          );
        });
  }

  void deleteTransaction(String id) {
    setState(() {
      _usertransactions.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text('Personal Expense'),
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.add),
            onPressed: () => startAddNewTransactions(context)),
        IconButton(icon: Icon(Icons.sms), onPressed: () => retrieveSMS())
      ],
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              SizedBox(
                  height: (MediaQuery.of(context).size.height -
                          appBar.preferredSize.height -
                          MediaQuery.of(context).padding.top) *
                      0.3,
                  child: Chart(_recentTransactions)),
              SizedBox(
                  height: (MediaQuery.of(context).size.height -
                          appBar.preferredSize.height) *
                      0.7,
                  child: userTransactionList(
                      _usertransactions, deleteTransaction)),
            ]),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => startAddNewTransactions(context)),
    );
  }
}
