class Transaction {
  final String id;
  final double amount;
  final DateTime date;
  final String title;
  Transaction(
      {required this.id,
      required this.date,
      required this.amount,
      required this.title});
}
