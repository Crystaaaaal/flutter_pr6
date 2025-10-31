import 'package:flutter/material.dart';
import '../models/transaction.dart';

class TransactionCard extends StatelessWidget {
  final Transaction transaction;

  const TransactionCard({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(transaction.name),
      subtitle: Text(transaction.reason),
      trailing: Text('${transaction.amount} ₽'),
    );
  }
}
