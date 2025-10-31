import 'package:flutter/material.dart';
import '../models/transaction.dart';
import '../widgets/transaction_card.dart';
import 'add_income_screen.dart';

class IncomeListScreen extends StatelessWidget {
  final List<Transaction> incomes;
  final Function(Transaction) onAddIncome;
  final Function(int) onDeleteIncome;

  const IncomeListScreen({
    Key? key,
    required this.incomes,
    required this.onAddIncome,
    required this.onDeleteIncome,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: incomes.isEmpty
          ? const Center(child: Text('Нет пополнений'))
          : ListView.builder(
        itemCount: incomes.length,
        itemBuilder: (context, index) => ListTile(
          leading: IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () => onDeleteIncome(index),
            tooltip: 'Удалить',
          ),
          title: TransactionCard(transaction: incomes[index]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final Transaction? income = await Navigator.push<Transaction>(
            context,
            MaterialPageRoute(
              builder: (_) => const AddIncomeScreen(),
            ),
          );

          if (income != null) {
            onAddIncome(income);
          }
        },
        tooltip: 'Добавить пополнение',
        child: const Icon(Icons.add),
      ),
    );
  }
}
