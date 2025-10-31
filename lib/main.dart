import 'package:flutter/material.dart';
import 'features/finance/models/transaction.dart';
import 'features/finance/screens/expense_list_screen.dart';
import 'features/finance/screens/income_list_screen.dart';
import 'features/finance/widgets/balance_card.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;
  double _balance = 0;

  final List<Transaction> _expenses = [];
  final List<Transaction> _incomes = [];

  void _addExpense(Transaction expense) {
    setState(() {
      _expenses.add(expense);
      _balance -= expense.amount;
    });
  }

  void _addIncome(Transaction income) {
    setState(() {
      _incomes.add(income);
      _balance += income.amount;
    });
  }

  void _deleteExpense(int index) {
    setState(() {
      _balance += _expenses[index].amount;
      _expenses.removeAt(index);
    });
  }

  void _deleteIncome(int index) {
    setState(() {
      _balance -= _incomes[index].amount;
      _incomes.removeAt(index);
    });
  }

  @override
  void initState() {
    super.initState();

    // Стартовые расходы
    final initialExpenses = [
      Transaction(
        name: 'Продукты',
        amount: 1200,
        reason: 'Покупка еды в супермаркете',
        date: DateTime.now().subtract(const Duration(days: 1)),
        isIncome: false,
      ),
      Transaction(
        name: 'Транспорт',
        amount: 350,
        reason: 'Проезд на автобусе',
        date: DateTime.now(),
        isIncome: false,
      ),
    ];

    // Стартовые доходы
    final initialIncomes = [
      Transaction(
        name: 'Зарплата',
        amount: 50000,
        reason: 'Основная работа',
        date: DateTime.now().subtract(const Duration(days: 3)),
        isIncome: true,
      ),
      Transaction(
        name: 'Фриланс',
        amount: 7000,
        reason: 'Проект по дизайну',
        date: DateTime.now().subtract(const Duration(days: 2)),
        isIncome: true,
      ),
    ];

    // Добавляем стартовые элементы через методы
    for (var income in initialIncomes) {
      _addIncome(income);
    }

    for (var expense in initialExpenses) {
      _addExpense(expense);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      IncomeListScreen(
        incomes: _incomes,
        onAddIncome: _addIncome,
        onDeleteIncome: _deleteIncome,
      ),
      ExpenseListScreen(
        expenses: _expenses,
        onAddExpense: _addExpense,
        onDeleteExpense: _deleteExpense,
      ),
    ];

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Контроль расходов')),
        body: Column(
          children: [
            BalanceCard(balance: _balance),
            Expanded(child: screens[_selectedIndex]),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle),
              label: 'Пополнения',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.remove_circle),
              label: 'Расходы',
            ),
          ],
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}
