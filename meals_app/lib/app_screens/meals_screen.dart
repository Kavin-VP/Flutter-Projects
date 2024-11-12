import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';

class MealsScreen extends StatelessWidget{
  const MealsScreen({
    super.key,
    required this.title,
    required this.meals}
    );

  final String title;
  final List<Meal> meals;

 
  @override
  Widget build(BuildContext context) {

     Widget content = ListView.builder(
        itemCount: meals.length,
        itemBuilder: (context,index){
          return Text(meals[index].title);
        });

  if(meals.isEmpty)
  {
    content=const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Uh...oh nothing here!!!',style: TextStyle(color: Colors.white),),
          SizedBox(height: 16.0,),
          Text('Try selecting different category',style: TextStyle(color: Colors.white),),
        ],
      ),

    );
  }
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: content
    );
  }
}