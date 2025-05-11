import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import '../providers/expense_provider.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryData = Provider.of<ExpenseProvider>(context).getExpensesByCategory();

    final chartData = [
      charts.Series<MapEntry<String, double>, String>(
        id: 'Expenses',
        domainFn: (entry, _) => entry.key,
        measureFn: (entry, _) => entry.value,
        data: categoryData.entries.toList(),
        labelAccessorFn: (entry, _) => '${entry.key}: \$${entry.value.toStringAsFixed(2)}',
      )
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Statistics')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text('Expense Distribution',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 300,
              child: charts.PieChart(
                  chartData,
                  animate: true,
                  defaultRenderer: charts.ArcRendererConfig(
                      arcRendererDecorators: [
                        charts.ArcLabelDecorator(
                            labelPosition: charts.ArcLabelPosition.auto
                        )
                      ]
                  )
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: categoryData.length,
                itemBuilder: (context, index) {
                  final entry = categoryData.entries.elementAt(index);
                  return ListTile(
                    title: Text(entry.key),
                    trailing: Text('\$${entry.value.toStringAsFixed(2)}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}