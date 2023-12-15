import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:expense_tracker/models/expense.dart';

class NewExpenses extends StatefulWidget {
  const NewExpenses({super.key, required this.OnaddExpense});
  final void Function(Expense expense) OnaddExpense;
  @override
  State<NewExpenses> createState() {
    return _NewexpenseState();
  }
}

class _NewexpenseState extends State<NewExpenses> {
  final _titlecontroller = TextEditingController();
  final _amountcontroller = TextEditingController();
  DateTime? _selecteddate;
  Category _selectedcategory = Category.leisure;

  void _presentdatepicker() async {
    final now = DateTime.now();
    final firstdate = DateTime(now.year - 1, now.month, now.day);
    final pickeddate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstdate,
        lastDate: now);
    setState(() {
      _selecteddate = pickeddate;
    });
  }

  void _submitExpenseDate() {
    final selectedamount = double.tryParse(_amountcontroller.text);
    final invalidamount = selectedamount == null || selectedamount <= 0;
    if (_titlecontroller.text.isEmpty ||
        invalidamount ||
        _selecteddate == null) {
      showCupertinoDialog(
          context: context,
          builder: (ctx) => CupertinoAlertDialog(
                title: const Text(
                  'Invalid Input',
                ),
                content: const Text(
                    'Please make sure that a valid title, amount, date and category was enetered'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                      },
                      child: const Text('Okay'))
                ],
              ));

      // showDialog(
      //   context: context,
      //   builder: (ctx) => AlertDialog(
      //     title: const Text(
      //       'Invalid Input',
      //     ),
      //     content: const Text(
      //         'Please make sure that a valid title, amount, date and category was enetered'),
      //     actions: [
      //       TextButton(
      //           onPressed: () {
      //             Navigator.pop(ctx);
      //           },
      //           child: const Text('Okay'))
      //     ],
      //   ),
      // );
      return;
    }
    widget.OnaddExpense(
      Expense(
        title: _titlecontroller.text,
        amout: selectedamount,
        date: _selecteddate!,
        catogory: _selectedcategory,
      ),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titlecontroller.dispose();
    _amountcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardspace = MediaQuery.of(context).viewInsets.bottom;
    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 48, 16, keyboardspace + 16),
          child: Column(
            children: [
              TextField(
                controller: _titlecontroller,
                maxLength: 50,
                decoration: const InputDecoration(label: Text('Title')),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _amountcontroller,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        prefix: Text('\$'),
                        label: Text('Amount'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(_selecteddate == null
                            ? 'No Date Selected'
                            : formatter.format(_selecteddate!)),
                        IconButton(
                            onPressed: _presentdatepicker,
                            icon: const Icon(Icons.calendar_month))
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  DropdownButton(
                      value: _selectedcategory,
                      items: Category.values
                          .map(
                            (category) => DropdownMenuItem(
                              value: category,
                              child: Text(
                                category.name.toUpperCase(),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value == null) {
                          return;
                        }
                        setState(() {
                          _selectedcategory = value;
                        });
                      }),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: _submitExpenseDate,
                    child: const Text('Save Expense'),
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
