import 'package:flutter/material.dart';

class FiltersScreen extends StatefulWidget{
  FiltersScreen({super.key, required this.filterValues});

  Map<Filter,bool> filterValues;
  @override
  State<FiltersScreen> createState() {
    return _FiltersScreenState();
  }
}

enum Filter{
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}
class _FiltersScreenState extends State<FiltersScreen>{

  bool _isGlutenFree = false;
  bool _isLactoseFree = false;
  bool _isVegetarian = false;
  bool _isVegan = false;
  // void toggleSwitch(bool value)
  // {
  //   setState(() {
  //     _isGlutenFree = value;
  //   });
  // }

  @override void initState() {
    // TODO: implement initState
    super.initState();
    _isGlutenFree = widget.filterValues[Filter.glutenFree]!;
    _isLactoseFree = widget.filterValues[Filter.lactoseFree]!;
    _isVegetarian = widget.filterValues[Filter.vegetarian]!;
    _isVegan = widget.filterValues[Filter.vegan]!;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
      ),
      
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (bool didPop,dynamic result){
          if(didPop) return;
          Navigator.of(context).pop({
            Filter.glutenFree : _isGlutenFree,
            Filter.lactoseFree : _isLactoseFree,
            Filter.vegetarian : _isVegetarian,
            Filter.vegan : _isVegan,
          });
        },
        child: Column(
          children: [
            SwitchListTile(
              value:_isGlutenFree ,
              onChanged: (changed){
               setState(() {
                  _isGlutenFree=changed;
               });
              },
              title: const Text('Gluten-free'),
              subtitle: const Text('Include gluten free meals only'),
              activeColor: Colors.greenAccent,
              contentPadding: const EdgeInsets.only(left: 20,right: 20),
            ),
             SwitchListTile(
              value:_isLactoseFree ,
              onChanged: (changed){
                setState(() {
                  _isLactoseFree=changed;
                });
              },
              title: const Text('Lactose-free'),
              subtitle: const Text('Include lactose free meals only'),
              activeColor: Colors.greenAccent,
              contentPadding: const EdgeInsets.only(left: 20,right: 20),
            ),
             SwitchListTile(
              value:_isVegetarian ,
              onChanged: (changed){
               setState(() {
                  _isVegetarian=changed;
               });
              },
              title: const Text('Vegetarian'),
              subtitle: const Text('Include vegetarian meals only'),
              activeColor: Colors.greenAccent,
              contentPadding: const EdgeInsets.only(left: 20,right: 20),
            ),
             SwitchListTile(
              value:_isVegan ,
              onChanged: (changed){
                setState(() {
                  _isVegan=changed;
                });
              },
              title: const Text('Vegan'),
              subtitle: const Text('Include vegan meals only'),
              activeColor: Colors.greenAccent,
              contentPadding: const EdgeInsets.only(left: 20,right: 20),
            ),
          ],
        ),
      ),
    );
  }
}