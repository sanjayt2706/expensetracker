import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/expense_provider.dart';
import '../widgets/expense_list.dart';

class DateWiseScreen extends StatefulWidget {
  const DateWiseScreen({super.key});

  @override
  State<DateWiseScreen> createState() => _DateWiseScreenState();
}

class _DateWiseScreenState extends State<DateWiseScreen> {
  DateTime _selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() => _selectedDate = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final expenseProvider = Provider.of<ExpenseProvider>(context);
    final expenses = expenseProvider.getExpensesByDate(_selectedDate);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Date-wise Expenses'),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () => _selectDate(context),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              DateFormat('MMMM dd, yyyy').format(_selectedDate),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          Expanded(
            child: ExpenseList(expenses: expenses),
          ),
        ],
      ),
    );
  }
}
