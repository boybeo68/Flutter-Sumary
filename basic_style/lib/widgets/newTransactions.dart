import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransactions extends StatefulWidget {
  final Function addTransaction;

  NewTransactions(this.addTransaction);

  @override
  State<NewTransactions> createState() => _NewTransactionsState();
}

class _NewTransactionsState extends State<NewTransactions> {
  final _txtTitleControl = TextEditingController();
  DateTime? _selectedDate;
  final _amountControl = TextEditingController();

  void submitData() {
    final enterTitle = _txtTitleControl.text;
    final enterAmount = double.parse(_amountControl.text);
    if (enterTitle.isEmpty ||
        enterAmount < 0 ||
        _selectedDate == null ||
        _amountControl.text.isEmpty) {
      return;
    }
    widget.addTransaction(enterTitle, enterAmount, _selectedDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        _selectedDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: _txtTitleControl,
              onSubmitted: (_) => submitData(),
              decoration: const InputDecoration(
                label: Text('Title'),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: _amountControl,
              onSubmitted: (_) => submitData(),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                label: Text('Amount'),
              ),
            ),
          ),
          Container(
            height: 70,
            padding: EdgeInsets.all(10),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(_selectedDate == null
                      ? 'No date chosent!'
                      : 'Pick Date ${DateFormat.yMEd().format(_selectedDate ?? DateTime.now())}'),
                ),
                TextButton(
                  onPressed: _presentDatePicker,
                  style: TextButton.styleFrom(
                      primary: Theme.of(context).primaryColor),
                  child: Text('Select Date'),
                )
              ],
            ),
          ),
          ElevatedButton(
            onPressed: (() => submitData()),
            child: Text('Add transaction'),
            style: ElevatedButton.styleFrom(
                onPrimary: Color.fromARGB(221, 238, 227, 0),
                primary: Theme.of(context).primaryColor),
          ),
        ],
      ),
    );
  }
}
