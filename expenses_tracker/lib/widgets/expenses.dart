import 'package:expenses_tracker/widgets/expenses-list/expenses_list.dart';
import 'package:expenses_tracker/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:expenses_tracker/widgets/add_new_expenses.dart';
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

  void addNewExpense(Expense exp) {
    setState(() {
      _registeredExpenses.add(exp);
    });
  }

  void removeExpense(Expense expense)
  {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });

  //removing any existing snackbar messages from the screen 
  //before removing the another item

  ScaffoldMessenger.of(context).clearSnackBars();
  //showing snackbars to undo the deleted item(expense)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 5),
        content: const Text('Expense Deleted...'),
        action: SnackBarAction(label: 'Undo', 
        onPressed: (){
          setState(() {
            _registeredExpenses.insert(expenseIndex, expense);
          });
        }),
      )
    );
  }

  @override
  Widget build(BuildContext context) {

    Widget expenseListContent = const Center(
      child:Text('No Expenses found. Try adding some !!!'),
      );

    if(_registeredExpenses.isNotEmpty)
    {
      expenseListContent = Expanded(child: ExpensesList(
            expensesList: _registeredExpenses,
            onRemoveExpense: removeExpense,));
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 36, 72, 135),
        actions: [
          IconButton(onPressed: _openAddExpenseOverlay, 
          icon:const Icon(Icons.add) )
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 10,),
          const Text('Expenses chart'),
          expenseListContent
        ],
      ),
    );
  }

  void _openAddExpenseOverlay()
  {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx){
      return AddNewExpenses(onAddExpense: addNewExpense,);
    });
  }
  
}