import 'package:flutter/material.dart';
import '../models/transaction.dart';
import '../widgets/transaction_card.dart';
import 'add_expense_screen.dart';

class ExpenseListScreen extends StatelessWidget {
  final List<Transaction> expenses;
  final Function(Transaction) onAddExpense;
  final Function(int) onDeleteExpense;

  const ExpenseListScreen({
    super.key,
    required this.expenses,
    required this.onAddExpense,
    required this.onDeleteExpense,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: expenses.isEmpty
          ? const Center(child: Text('Нет расходов'))
          : ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (context, index) => ListTile(
          leading: IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () => onDeleteExpense(index),
            tooltip: 'Удалить',
          ),
          title: TransactionCard(transaction: expenses[index]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final Transaction? expense = await Navigator.push<Transaction>(
            context,
            MaterialPageRoute(
              builder: (_) => const AddExpenseScreen(),
            ),
          );

          if (expense != null) {
            onAddExpense(expense);
          }
        },
        tooltip: 'Добавить расход',
        child: const Icon(Icons.add),
      ),
    );
  }
}
