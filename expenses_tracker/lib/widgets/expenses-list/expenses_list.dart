import 'package:expenses_tracker/widgets/expenses-list/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:expenses_tracker/models/expense.dart';

class ExpensesList extends StatelessWidget{
  const ExpensesList(
    {super.key,
    required this.expensesList,
    required this.onRemoveExpense}
    );
  
  final List<Expense> expensesList;
  final Function(Expense expense) onRemoveExpense;
  // void addExpenses(Expense exp)
  // {
  //   expensesList.add(exp);
  // }
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expensesList.length,
      itemBuilder: (context, index)
      {
        return Dismissible(
          key: Key(expensesList[index].id),
          onDismissed: (direction){
            onRemoveExpense(expensesList[index]);
          },
          child: ExpenseItem(expensesList[index]));
      },
      
    );
  }
}