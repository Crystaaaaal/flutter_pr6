import 'package:flutter/material.dart';
import '../models/transaction.dart';

class AddIncomeScreen extends StatefulWidget {
  const AddIncomeScreen({super.key});

  @override
  State<AddIncomeScreen> createState() => _AddIncomeScreenState();
}

class _AddIncomeScreenState extends State<AddIncomeScreen> {
  final _formKey = GlobalKey<FormState>();
  String _reason = '';
  double? _amount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Добавить пополнение')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
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
                decoration: const InputDecoration(labelText: 'Источник'),
                validator: (v) =>
                v == null || v.trim().isEmpty ? 'Введите источник' : null,
                onSaved: (v) => _reason = v!.trim(),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    child: const Text('Отмена'),
                    onPressed: () => Navigator.pop(context),
                  ),
                  ElevatedButton(
                    child: const Text('Добавить'),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();

                        final transaction = Transaction(
                          name: 'Пополнение',
                          amount: _amount!,
                          reason: _reason,
                          date: DateTime.now(),
                          isIncome: true,
                        );

                        Navigator.pop(context, transaction);
                      }
                    },
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
