import 'package:flutter/material.dart';

class NewTransactions extends StatefulWidget {
  final Function addTransaction;
  const NewTransactions(this.addTransaction);

  @override
  State<NewTransactions> createState() => _NewTransactionsState();
}

class _NewTransactionsState extends State<NewTransactions> {
  final txtTitleControl = TextEditingController();

  final amountControl = TextEditingController();

  void submitData() {
    final enterTitle = txtTitleControl.text;
    final enterAmount = double.parse(amountControl.text);
    if (enterTitle.isEmpty || enterAmount < 0) {
      return;
    }
    widget.addTransaction(enterTitle, enterAmount);
    Navigator.of(context).pop();
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
              controller: txtTitleControl,
              onSubmitted: (_) => submitData(),
              decoration: InputDecoration(
                label: Text('Title'),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: amountControl,
              onSubmitted: (_) => submitData(),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                label: Text('Amount'),
              ),
            ),
          ),
          TextButton(
            onPressed: () => {
              widget.addTransaction(
                  txtTitleControl.text, double.parse(amountControl.text))
            },
            child: Text('Add transaction'),
            style: TextButton.styleFrom(primary: Colors.blue),
          ),
        ],
      ),
    );
  }
}
