import 'package:flutter/material.dart';
import '../models/transaction.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _reason = '';
  double? _amount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Добавить расход')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Название'),
                validator: (v) =>
                v == null || v.trim().isEmpty ? 'Введите название' : null,
                onSaved: (v) => _title = v!.trim(),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Сумма'),
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Введите сумму';
                  final n = double.tryParse(v);
                  if (n == null || n <= 0) return 'Только положительное число';
                  return null;
                },
                onSaved: (v) => _amount = double.parse(v!),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Причина'),
                validator: (v) =>
                v == null || v.trim().isEmpty ? 'Введите причину' : null,
                onSaved: (v) => _reason = v!.trim(),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Отмена'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();

                        final transaction = Transaction(
                          name: _title,
                          amount: _amount!,
                          reason: _reason,
                          date: DateTime.now(),
                          isIncome: false,
                        );

                        Navigator.pop(context, transaction);
                      }
                    },
                    child: const Text('Добавить'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
