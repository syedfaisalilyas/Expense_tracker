import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/wdgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expenses, required this.onRemove});
  final void Function(Expense expense) onRemove;
  final List<Expense> expenses;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (ctx, index) => Dismissible(
            key: ValueKey(expenses[index]),
            background: Container(
              color: Theme.of(context).colorScheme.error.withOpacity(0.75),
              margin: Theme.of(context).cardTheme.margin,
            ),
            onDismissed: (direction) {
              onRemove(expenses[index]);
            },
            child: Expense_item(expenses[index])));
  }
}
