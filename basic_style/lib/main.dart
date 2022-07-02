// ignore_for_file: prefer_const_constructors

import 'package:basic_style/models/transaction.dart';
import 'package:basic_style/widgets/chart.dart';
import 'package:basic_style/widgets/listTransactions.dart';
import 'package:basic_style/widgets/newTransactions.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.green,
          // errorColor: Colors.blue,
          textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'Yellowtail',
                fontSize: 14,
                color: Colors.grey,
              ),
              headline5: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 15,
                  fontWeight: FontWeight.bold)),
          appBarTheme: AppBarTheme(
              titleTextStyle: TextStyle(
            fontFamily: 'Yellowtail',
            fontSize: 25,
          ))
          // fontFamily: 'Opensans',
          ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransaction = [];
  List<Transaction> get historyTransaction {
    return _userTransaction.where((element) {
      return element.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  void _addNewTransaction(
      String txtTitle, double dbAmount, DateTime _selectedDate) {
    final newTrans = Transaction(
        id: DateTime.now().toString(),
        date: _selectedDate,
        amount: dbAmount,
        title: txtTitle);
    setState(() {
      _userTransaction.add(newTrans);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransaction.removeWhere((element) => element.id == id);
    });
    Navigator.of(context).pop();
  }

  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
      context: context,
      // builder: (_) {
      //   return GestureDetector(
      //     onTap: () {},
      //     child: NewTransactions(_addNewTransaction),
      //     behavior: HitTestBehavior.opaque,
      //   );
      // },
      builder: (_) {
        return NewTransactions(_addNewTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Basic style',
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _startAddNewTransaction(context);
              // handle the press
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Chart(historyTransaction),
            ListTransaction(_userTransaction, _deleteTransaction)
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            _startAddNewTransaction(context);
          },
          child: Icon(Icons.add)),
    );
  }
}
