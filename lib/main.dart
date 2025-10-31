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

    final initialExpenses = [
      Transaction(
        name: 'Продукты',
        amount: 1200,
        reason: 'Покупка еды в супермаркете',
        date: DateTime.now().subtract(const Duration(days: 1)),
        isIncome: false,
          photoURL: "https://images.thevoicemag.ru/upload/img_cache/493/493173ba9d947eb9624440f06237437e_cropped_666x444.jpg",
      ),
      Transaction(
        name: 'Транспорт',
        amount: 350,
        reason: 'Проезд на автобусе',
        date: DateTime.now(),
        isIncome: false,
          photoURL: "https://www.shutterstock.com/image-vector/transport-travel-car-train-bus-600w-506212144.jpg",
      ),
    ];

    final initialIncomes = [
      Transaction(
        name: 'Зарплата',
        amount: 50000,
        reason: 'Основная работа',
        date: DateTime.now().subtract(const Duration(days: 3)),
        isIncome: true,
          photoURL: "https://img.gazeta.ru/files3/705/16249705/vkonvertr-pic_32ratio_1200x800-1200x800-79503.jpg",

      ),
      Transaction(
        name: 'Фриланс',
        amount: 7000,
        reason: 'Проект по дизайну',
        date: DateTime.now().subtract(const Duration(days: 2)),
        isIncome: true,
          photoURL: "https://cdn-icons-png.flaticon.com/512/1807/1807705.png"
      ),
    ];

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
