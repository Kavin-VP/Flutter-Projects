import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget{
  const MainDrawer(
    {
      super.key,
      required this.setScreen,
      });

  final void Function(String identifier) setScreen;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        backgroundColor: Colors.black,
        child: Column(
          children: [
             Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  const Icon(Icons.fastfood,size: 40,),
                  const SizedBox(width: 10,),
                  const Text('Cooking Up!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                  ),),
                  const SizedBox(width: 10,),
                  IconButton(
                    color: Colors.redAccent,
                    iconSize: 35.0,
                    onPressed:
                   (){
                    Navigator.of(context).pop();
                   }, 
                   icon: const Icon(Icons.close))
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.restaurant),
              title: const Text('Meals',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),),
              onTap: (){
                setScreen('meals');
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Filters',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),),
              onTap: (){
                setScreen('filter');
              },
            ),
          ],
        ),
      ),
    );
  }
}