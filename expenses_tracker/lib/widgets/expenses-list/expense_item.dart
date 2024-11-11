import 'package:flutter/material.dart';
import 'package:expenses_tracker/models/expense.dart';
class ExpenseItem extends StatelessWidget{

  const ExpenseItem(this.expenseItem,{super.key});
  final Expense expenseItem;
  @override
  Widget build(context)
  {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,vertical: 16.0,
        ),
        child: Column(
          children: [
            Text(expenseItem.title),
            Row(
              children: [
                Text('\$${expenseItem.amount.toStringAsFixed(2)}'),
                //const SizedBox(width: 20,),
                const Spacer(),
                Row(
                  children: [
                     Icon(categoryIcons[expenseItem.category]),
                    const SizedBox(width:8),
                    Text(expenseItem.formattedDate),
                  ],
                )
              ],
            ),
            
          ],
        ),
      ),
    );
  }
}