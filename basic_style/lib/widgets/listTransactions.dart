// ignore_for_file: prefer_const_constructors

import 'package:basic_style/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListTransaction extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;
  ListTransaction(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      child: transactions.isEmpty
          ? Column(
              children: [
                Text(
                  'No transactions, please add',
                  style: Theme.of(context).textTheme.headline5,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 200,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (ctx, index) {
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: FittedBox(
                          child: Text('\$${transactions[index].amount}'),
                        ),
                      ),
                    ),
                    title: Text(
                      transactions[index].title,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    subtitle: Text(
                        DateFormat.yMEd().format(transactions[index].date)),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (_) {
                              return AlertDialog(
                                title: Text("Thông báo"),
                                content: Text(
                                    "Bạn có thực sự muốn xoá dữ liệu hay không"),
                                actions: [
                                  TextButton(
                                      onPressed: () => deleteTransaction(
                                          transactions[index].id),
                                      child: Text('Ok'))
                                ],
                              );
                            });
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
