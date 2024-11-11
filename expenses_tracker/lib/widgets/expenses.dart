import 'package:expenses_tracker/widgets/expenses-list/expenses_list.dart';
import 'package:expenses_tracker/models/expense.dart';
import 'package:flutter/material.dart';
//import 'package:expenses_tracker/expenses.dart';
class Expenses extends StatefulWidget{
  const Expenses({super.key});
  @override
  State<Expenses> createState()
  {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses>
{
  final List<Expense> _registeredExpenses=[
    Expense(title: 'Work travel', amount: 234.32, date: DateTime.now(), category: Category.work),
    Expense(title: 'Movie out', amount: 500.00, date: DateTime.now(), category: Category.movie),
    Expense(title: 'Traveling with friends', amount: 2034.23, date: DateTime.now(), category: Category.travel),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 36, 72, 135),
        actions: [
          IconButton(onPressed: (){}, 
          icon:const Icon(Icons.add) )
        ],
      ),
      body: Column(
        children: [
          const Text('Expenses chart'),
          Expanded(child: ExpensesList(expensesList: _registeredExpenses)),
        ],
      ),
    );
  }
  
}