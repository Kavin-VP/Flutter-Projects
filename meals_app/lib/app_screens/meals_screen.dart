import 'package:flutter/material.dart';
import 'package:meals_app/app_screens/meal_details_screen.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget{
   MealsScreen({
    super.key,
    this.title,
    required this.meals,
    required this.onToggleFavourite,
    }
    );

  final String? title;
  final List<Meal> meals;
  final void Function(Meal meal) onToggleFavourite;

  void _selectMeal(BuildContext context, Meal meal)
  {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx)=> MealDetailsScreen(
          meal: meal,
          onToggleFavourite: onToggleFavourite,
          )
          )
          );
  }
  @override
  Widget build(BuildContext context) {

     Widget content = ListView.builder(
        itemCount: meals.length,
        itemBuilder: (context,index){
          return MealItem(meal: meals[index],onSelectMeal: (){
            _selectMeal(context, meals[index]);
          },);
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
  if(title==null)
  {
    return content;
  }
    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content
    );
  }
}