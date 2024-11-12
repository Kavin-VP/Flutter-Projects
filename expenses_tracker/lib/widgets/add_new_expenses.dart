import 'package:flutter/material.dart';
import 'package:expenses_tracker/models/expense.dart';
import 'package:expenses_tracker/widgets/expenses-list/expenses_list.dart';

class AddNewExpenses extends StatefulWidget{

  const AddNewExpenses({super.key, required this.onAddExpense});

  final Function(Expense expense) onAddExpense;
  @override
  State<AddNewExpenses> createState()
  {
    return _AddNewExpensesState();
  }

}

class _AddNewExpensesState extends State<AddNewExpenses>{

  // String _titleInputValue='';

  // void _onTitleInputChange(String value) {
  //   _titleInputValue=value;
  // }
  //using a text input controller for storing and accessing user inputs

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  Category _selectedCategory = Category.food;
  DateTime? userSelectedDate;
  //to dispose the textediting controller
  //when the widget overlay is closed
  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  //adding a date picker
  void _datePicker() async
  {
    final currentDate = DateTime.now();
    final firstDate = DateTime(currentDate.year-2, currentDate.month, currentDate.day);

    //returns a future type
    final selectedDate = await showDatePicker
    (context: context,
     firstDate:firstDate ,
     lastDate: currentDate);

     setState(() {
       userSelectedDate=selectedDate;
     });
  }

  //validating the input values from the user before submitting
  void _submitExpenseData()
  {
    final enteredAmount = double.tryParse(_amountController.text);
    final IsAmountInvalid = enteredAmount==null;

    if(_titleController.text.trim().isEmpty || IsAmountInvalid || userSelectedDate==null)
    {
      //show error to the user
      showDialog(context: context, builder: (context)
      {
        return AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text(
            'Please make sure that all the inputs are entered correctly!!!'
          ),
          actions: [
            TextButton(onPressed: (){
              Navigator.pop(context);
            }, child: const Text('Okay'))
          ],
        );
      });
      return;
    }
    //ExpensesList(expensesList: expensesList)
    final expenseObject = Expense(
      title: _titleController.text, 
      amount: double.tryParse(_amountController.text)!,
      date: userSelectedDate!,
      category: _selectedCategory);

      Navigator.pop(context);
      widget.onAddExpense(expenseObject);
    //ExpensesList().addExpenses(expenseObject);
  }
  
  @override
  Widget build(context)
  {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (context,constraints){
      final width = constraints.maxWidth;

      return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding:EdgeInsets.fromLTRB(16.0,50.0,16.0,keyboardSpace+16.0),
        
          child: Column(
            children: [

              if(width>=600)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextField(
                                      //onChanged: _onTitleInputChange,
                                      //to specify the textediting controller
                                      //for title input
                                      controller: _titleController,
                                      maxLength: 40,
                                      decoration: const InputDecoration(
                                        label: Text('Title'),
                                      ),
                                    ),
                    ),
                    const SizedBox(width: 16,),
              Expanded(
                    child: TextField(
                      maxLength: 10,
                      controller: _amountController,
                      keyboardType: const TextInputType.numberWithOptions(),
                      decoration: const InputDecoration(
                        label: Text('Amount'),
                        prefixText: '\$',
                      ),
                    ),
                  ),
                  ],
                )

              else
              TextField(
                //onChanged: _onTitleInputChange,
                //to specify the textediting controller
                //for title input
                controller: _titleController,
                maxLength: 40,
                decoration: const InputDecoration(
                  label: Text('Title'),
                ),
              ),
              if(width<=600)
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      maxLength: 10,
                      controller: _amountController,
                      keyboardType: const TextInputType.numberWithOptions(),
                      decoration: const InputDecoration(
                        label: Text('Amount'),
                        prefixText: '\$',
                      ),
                    ),
                  ),
                  const SizedBox(width: 16.0,),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          // !-> telling dart that this variable wont be null
                          userSelectedDate == null ? 'No date Selected' : formatter.format(userSelectedDate!),
                        ),
                        IconButton(onPressed:_datePicker, 
                        icon: const Icon(Icons.calendar_month),
                        ),
                      ],
                    ),
                  )
        
                ],
              )
              else
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                DropdownButton(
                    value: _selectedCategory,
                    items: Category.values.map(
                    (category){
                      return DropdownMenuItem(
                        value: category,
                        child: Text(category.name.toUpperCase()),
                        );
                    }
                  ).toList(), 
                  onChanged: (value){
                    //print(value);
                    if(value==null)
                    {
                      return;
                    }
                    setState(() {
                      _selectedCategory=value;
                    });
                  }),
                  const SizedBox(width: 20,),
                   Text(
                          // !-> telling dart that this variable wont be null
                          userSelectedDate == null ? 'No date Selected' : formatter.format(userSelectedDate!),
                        ),
                        IconButton(onPressed:_datePicker, 
                        icon: const Icon(Icons.calendar_month),
                        ),
              ],),

              if(width<=600)
              const SizedBox(height: 16.0,),

              if(width<=600)
              Row(
                children: [
                  DropdownButton(
                    value: _selectedCategory,
                    items: Category.values.map(
                    (category){
                      return DropdownMenuItem(
                        value: category,
                        child: Text(category.name.toUpperCase()),
                        );
                    }
                  ).toList(), 
                  onChanged: (value){
                    //print(value);
                    if(value==null)
                    {
                      return;
                    }
                    setState(() {
                      _selectedCategory=value;
                    });
                  }),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: (){
                      print(_titleController.text);
                      print(_amountController.text);
                      print(_selectedCategory);
                      _submitExpenseData();
                    },
                    child: const Text('Save Expense'),
                    ),
                    const SizedBox(width: 10,),
                     ElevatedButton(onPressed: ()
                      {
                        //dispose();
                        Navigator.pop(context);
                      }, child: const Text('Cancel')),
                ],
              )
              else
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                ElevatedButton(
                    onPressed: (){
                      // print(_titleController.text);
                      // print(_amountController.text);
                      // print(_selectedCategory);
                      _submitExpenseData();
                    },
                    child: const Text('Save Expense'),
                    ),
                    const SizedBox(width: 10,),
                     ElevatedButton(onPressed: ()
                      {
                        //dispose();
                        Navigator.pop(context);
                      }, child: const Text('Cancel')),
              ],),
               
            ],
          ),
        ),
      ),
    );
    });
    
  }
}