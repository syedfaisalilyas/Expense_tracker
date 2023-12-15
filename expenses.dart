import 'package:expense_tracker/wdgets/chart/chart.dart';
import 'package:expense_tracker/wdgets/expenses_list/expenseslist.dart';
import 'package:expense_tracker/wdgets/new_expenses.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExppensesSate();
  }
}

class _ExppensesSate extends State<Expenses> {
  final List<Expense> _registeredexepenses = [
    Expense(
        amout: 19.9,
        title: 'flutter course',
        date: DateTime.now(),
        catogory: Category.work),
    Expense(
        amout: 16.6,
        title: 'cinema',
        date: DateTime.now(),
        catogory: Category.leisure),
  ];

  void _openexpensesheet() {
    showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (ctx) => NewExpenses(
              OnaddExpense: addexpense,
            ));
  }

  void addexpense(Expense expense) {
    setState(() {
      _registeredexepenses.add(expense);
    });
  }

  void removeexpense(Expense expense) {
    final expenseindex = _registeredexepenses.indexOf(expense);
    setState(() {
      _registeredexepenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'Expense deleted',
        ),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredexepenses.insert(expenseindex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    Widget maincontent = const Center(
      child: Text('No expenses found.Try adding some!'),
    );

    if (_registeredexepenses.isNotEmpty) {
      maincontent = ExpensesList(
        expenses: _registeredexepenses,
        onRemove: removeexpense,
      );
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text('Flutter ExpenseTracker'),
          actions: [
            IconButton(
              onPressed: _openexpensesheet,
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        body: width < 600
            ? Column(
                children: [
                  Chart(expenses: _registeredexepenses),
                  Expanded(
                    child: maincontent,
                  )
                ],
              )
            : Row(
                children: [
                  Expanded(child: Chart(expenses: _registeredexepenses)),
                  Expanded(
                    child: maincontent,
                  )
                ],
              ));
  }
}
