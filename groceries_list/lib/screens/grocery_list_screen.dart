import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:groceries_list/data/categories.dart';
import 'package:groceries_list/data/dummy_data.dart';
import 'package:groceries_list/models/grocery_item.dart';
import 'package:groceries_list/screens/new_item_screen.dart';
import 'package:http/http.dart' as http;

class GroceryListScreen extends StatefulWidget{

  const GroceryListScreen({super.key});

  @override
  State<GroceryListScreen> createState() => _GroceryListScreenState();
}

class _GroceryListScreenState extends State<GroceryListScreen> {

  List<GroceryItem> groceryItems=[];
  var _isLoading = false;
  var _isEmptyData = false;
  String? _error;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //groceryItems.clear();
    _loadData();
  }

  void _loadData() async
    {
      _isLoading=true;
      List<GroceryItem> dummyList=[];
      final url = Uri.https('fir-demo-c8eb4-default-rtdb.firebaseio.com','grocery-items.json');

      final response = await http.get(url);
      //print(json.decode(response.body));

      if(response.statusCode>=400)
      {
        setState(() {
          _isLoading = false;
          _error = 'Failed to fetch data, Please try again later.';
        });
      }
      else
      {
        var listData ={};
        var data = json.decode(response.body);
 
        if(data==null)
        {
          setState(() {
            _isEmptyData=true;
            _isLoading=false;
          });
          return;
        }
        else
        {
          listData=data;
          _isEmptyData = false;
          _isLoading = false;
        }
      for(final item in listData.entries)
      {
        //print(item.value['category']);
        var category = categories.entries.firstWhere(
          (catItem)=>catItem.value.name == item.value['category']
        );
        //print(category);
        dummyList.add(
          GroceryItem(
            id: item.key, 
            name: item.value['name'], 
            quantity: item.value['quantity'], 
            category: category.value
            )
        );
      }
        setState(() {
          groceryItems = dummyList;
          _isLoading=false;
        });
      }       
    }

  void _deleteItem(GroceryItem item,int index) async
  {
     setState(() {
      groceryItems.remove(item);
    });

    var undoItem = false;
    var url = Uri.https('fir-demo-c8eb4-default-rtdb.firebaseio.com','grocery-items/${item.id}.json');

    ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context)
      .showSnackBar( SnackBar(
      content: const Text('Item deleted'),
      action: SnackBarAction(label: 'Undo', onPressed: (){
        undoItem = true;
       _undoItem(true, index, item);
      }),
      duration: const Duration(seconds: 3),));

      Future.delayed(const Duration(seconds: 3)).then(
       (onValue) async {
        //final response;
          if(!undoItem)
          {
            final response = await http.delete(url);
            if(response.statusCode>=400)
                {
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context)
                  .showSnackBar( const SnackBar(
                  content:Text('Please try again'),));
                  setState(() {
                    groceryItems.insert(index, item);
                  });
                }
          }
       }
      );

    if(groceryItems.length==0)
    {
      setState(() {
        _isEmptyData = true;
      });
    }
  }

  void _undoItem(bool undoItem,int index,GroceryItem item)
  {
    if(undoItem)
    {
      setState(() {
        groceryItems.insert(index, item);
        _isEmptyData =false;
      });
    }
  }
  //List<GroceryItem> addedItems=groceryItems;
  @override
  Widget build(BuildContext context) {

    void _addItem() async
    {
      //var url = Uri.https('fir-demo-c8eb4-default-rtdb.firebaseio.com','grocery-items.json');
      final newItem = await Navigator.of(context).push<GroceryItem>(MaterialPageRoute(
        builder: (ctx)=> const NewItemScreen()
        )
        );

        if(newItem!=null)
        {
          setState(() {
          _isEmptyData = false;
              groceryItems.add(newItem!);
            //getting the response object
            //using async and await or using the then() method;
            // ).then((response){
            //   //print(response.statusCode);
            // });
          
        });
        }
        
    }

    var content = _isLoading ? const Center(
        child: CircularProgressIndicator(),
      ) : ListView.builder(
        itemCount: groceryItems.length,
        itemBuilder:(context,index){
           return Dismissible(
            onDismissed: (direction){
              _deleteItem(groceryItems[index],index);
            },
            key: ValueKey(groceryItems[index].id),
             child: ListTile(
              title: Text(groceryItems[index].name),
              leading: Container(
                height: 20,
                width: 20,
                color: groceryItems[index].category.color,
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(groceryItems[index].quantity.toString()),
                  const SizedBox(width: 10,),
                  
                  IconButton(
                    //key: ValueKey(groceryItems[index].id),
                    onPressed: (){
                      
                    }, 
                    icon: const Icon(Icons.delete)),
                    const Text('Delete',style: TextStyle(color: Colors.redAccent),),
                    const Icon(Icons.arrow_right_alt)
                ],
              ),
                       ),
           );
        } );

    if(_isEmptyData)
    {
      content = const Center(
        child: Text('No content, Try adding some!'),
      );
    }
    if(_error!=null)
    {
      content = Center(
        child: Text(_error!),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Groceries'),
        actions: [
          IconButton(onPressed: _addItem, icon: const Icon(Icons.add))
        ],
      ),
      body: content
    );
  }
}