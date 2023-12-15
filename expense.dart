import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();
const uuid = Uuid();

enum Category { food, travel, leisure, work }

const CategoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work
};

class Expense {
  Expense(
      {required this.title,
      required this.amout,
      required this.date,
      required this.catogory})
      : id = uuid.v4();
  final String id;
  final String title;
  final double amout;
  final DateTime date;
  final Category catogory;

  String get formatteddate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  ExpenseBucket({required this.category, required this.expenses});
  final Category category;
  final List<Expense> expenses;

  ExpenseBucket.forcategory(List<Expense> allexpenses, this.category)
      : expenses = allexpenses
            .where((expense) => expense.catogory == category)
            .toList();
  double get totalamount {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amout;
    }
    return sum;
  }
}
