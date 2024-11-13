import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget{

  const MealItem({super.key,required this.meal,required this.onSelectMeal});

  final Meal meal;
  final void Function() onSelectMeal;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8)
      ),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: onSelectMeal,
        child: Stack(
          children: [
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(meal.imageUrl),
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: Colors.black54,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 6
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          meal.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          softWrap: true,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                    
                          ),),
                          const SizedBox(height: 10,),
                          Row(
                            children: [
                              MealItemTrait(icon: Icons.schedule, label: '${meal.duration} min'),
                              const SizedBox(width: 30,),
                              MealItemTrait(icon: Icons.work, label: '${meal.complexity.name.toUpperCase()}'),
                              const SizedBox(width: 30,),
                              MealItemTrait(icon: Icons.money, label: meal.affordability.name.toUpperCase())
                            ],
                          )
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}