import 'package:flutter/material.dart';
import 'package:meals_app/app_screens/meals_screen.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/category_grid_item.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/category.dart';

class Categories extends StatelessWidget{
  const Categories(
    {
      super.key,
      required this.onToggleFavourite,
      required this.availableMeals,
      });

  final void Function(Meal meal) onToggleFavourite;
  final List<Meal> availableMeals;

  void _selectCategory(BuildContext context,Category category)
  {
    final filteredMeals = availableMeals.
            where((meal)=>meal.categories.contains(category.id)).toList();

    //Navigator.push(context,route); ->alternative
    Navigator.of(context).push(MaterialPageRoute(
      builder: (ctx)=> MealsScreen(
        title: category.title,
        meals: filteredMeals,
        onToggleFavourite: onToggleFavourite,
        )));
  }
  @override
  Widget build(BuildContext context) {
    
    return GridView(
        padding: const EdgeInsets.all(20.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20.0,
          mainAxisSpacing: 20.0,
          childAspectRatio: 3/2,
          ),
          children:[
            for(final category in availableCategories)
              CategoryGridItem(category: category,
              onSelectCategory:(){
                _selectCategory(context,category);
              },),
        ],
        );
        
  }
}