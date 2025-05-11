import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../models/expense.dart';
import '../providers/expense_provider.dart';
import '../widgets/expense_form.dart';

class AddExpenseScreen extends StatelessWidget {
  const AddExpenseScreen({super.key});

  void _handleSubmit(BuildContext context, Expense expense) {
    // If the ID is null, assign a new UUID
    final updatedExpense = expense.id == null
        ? expense.copyWith(id: const Uuid().v4())
        : expense;

    Provider.of<ExpenseProvider>(context, listen: false).addExpense(updatedExpense);
  }

  @override
  Widget build(BuildContext context) {
    return ExpenseForm(
      onSubmit: (expense) => _handleSubmit(context, expense),
    );
  }
}
