import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../providers/expense_provider.dart';
import '../models/expense.dart';
import '../widgets/expense_form.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _openForm(BuildContext context, [Expense? expense]) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: ExpenseForm(
          expense: expense,
          onSubmit: (e) {
            if (expense == null) {
              final newExpense = Expense(
                id: const Uuid().v4(),
                title: e.title,
                amount: e.amount,
                date: e.date,
                category: e.category,
              );
              Provider.of<ExpenseProvider>(context, listen: false)
                  .addExpense(newExpense);
            } else {
              Provider.of<ExpenseProvider>(context, listen: false)
                  .updateExpense(e);
            }
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final expenses = Provider.of<ExpenseProvider>(context).expenses;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _openForm(context),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (_, i) {
          final e = expenses[i];
          return ListTile(
            title: Text(e.title),
            subtitle: Text('${e.category} - ${e.date.toLocal().toString().split(' ')[0]}'),
            trailing: Text('\$${e.amount.toStringAsFixed(2)}'),
            onTap: () => _openForm(context, e),
          );
        },
      ),
    );
  }
}
