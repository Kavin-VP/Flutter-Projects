import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:groceries_list/data/categories.dart';
import 'package:groceries_list/models/grocery_item.dart';
import 'package:http/http.dart' as http;

class NewItemScreen extends StatefulWidget{

  const NewItemScreen({super.key});

  @override
  State<NewItemScreen> createState() {
    return _NewItemScreenState();
}
}


class _NewItemScreenState extends State<NewItemScreen>{
  final _formKey = GlobalKey<FormState>();
  var _isSending = false;

  var _enteredName;
  var _enteredQuantity;
  var _selectedCategory = categories[Categories.vegetables]!;

  void _saveForm() async
  {
    if(_formKey.currentState!.validate())
    {
      _isSending=true;

      _formKey.currentState!.save();

      var url = Uri.https('fir-demo-c8eb4-default-rtdb.firebaseio.com','grocery-items.json');

      try{
        final response = await http.post(
              url,
              headers: {
                'Content-Type':'application/json'
            },
            body: json.encode({
              'name':_enteredName,
              'category':_selectedCategory.name,
              'quantity':_enteredQuantity
            })
            );
     
      if(response.statusCode>=400)
      {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please try again'),
            duration: Duration(seconds: 2),)
        );
      }
      else{
         var id = json.decode(response.body);
            var item = GroceryItem(
              id: id['name'], 
              name: _enteredName, 
              quantity: _enteredQuantity, 
              category: _selectedCategory);

         Navigator.of(context).pop(item);
      }
      }
      catch(ex)
      {
        //Navigator.of(context).pop(null);
        ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context)
                  .showSnackBar( const SnackBar(
                    duration: Duration(seconds: 2),
                  content:Text('Something went wrong...'),));
      }
    }
    
    // print(_enteredName);
    // print(_enteredQuantity);
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new Item'),

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextFormField(
                  maxLength: 30,
                  decoration: const InputDecoration(
                    label: Text('Name'),
                    hintText: 'Enter name'
                  ),
                  validator: (value){
                    if(value==null || value.isEmpty || value.trim().length<=2)
                    {
                      return 'please enter a valid name';
                    }
                    return null;
                  },
                  onSaved: (value){
                    _enteredName=value;
                  },
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TextFormField(
                        keyboardType: const TextInputType.numberWithOptions(),
                        initialValue: '1',
                        decoration: const InputDecoration(
                          label:Text('Quantity'),
                          hintText: 'Enter quantity'
                        ),
                        validator: (value){
                          if(value==null || value.isEmpty)
                          {
                            return 'please enter valid quantity';
                          }
                    
                          // if(int.tryParse(value)<)
                          // {
                          //   return 'please enter valid quantity';
                          // }
                          return null;
                        },
                        onSaved: (value){
                          _enteredQuantity = int.parse(value!);
                        },
                      ),
                    ),
                    const SizedBox(width: 20,),
                    Expanded(child: DropdownButtonFormField(
                      validator: (value){
                        if(value==null)
                        {
                          return 'Please select category';
                        }
                        return null;
                      },
                      hint: const Text('--select category--'),
                      //value: Categories,
                      items: [
                        for(final category in categories.entries)
                          DropdownMenuItem(
                            value: category.value,
                            child:
                              Row(
                                children: [
                                  Container(
                                    height: 20,
                                    width: 20,
                                    color: category.value.color,
                                  ),
                                  const SizedBox(width: 20,),
                                  Text(category.value.name),
                                ],
                              )
                            ,
                          )
                      ], 
                      onChanged: (value){
                        if(value!=null)
                        {
                           setState(() {
                          _selectedCategory = value;
                        });
                        }
                      }
                      // onChanged: (value){},
                      // ))
                    //const CircularProgressIndicator(),
                    ))
                  ],
                ),
                 SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                   
                    ElevatedButton(
                      onPressed:_isSending ? null : (){
                        _formKey.currentState!.reset();
                      }, 
                      child: const Text('reset')),
                       const SizedBox(width: 20,),
                      ElevatedButton(
                        onPressed:_isSending ? null : (){
                          _saveForm();
                        }, 
                        child: _isSending ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(),
                        )
                        : const Text('Add Item'))
                  ],
                ),
              ],
            ),
            ),
          ),
      )
    );
  }
}