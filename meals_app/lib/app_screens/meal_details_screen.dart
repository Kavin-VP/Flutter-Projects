import 'package:flutter/material.dart';
import 'package:meals_app/main.dart';
import 'package:meals_app/models/meal.dart';
import 'package:transparent_image/transparent_image.dart';

class MealDetailsScreen extends StatelessWidget{
  const MealDetailsScreen(
    {
      super.key, 
      required this.meal,
      required this.onToggleFavourite,
      }
      );

  //final String title;
  final Meal meal;
  //final void Function() onTapFavourite;
  final void Function(Meal meal) onToggleFavourite;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
            onPressed: (){
              onToggleFavourite(meal);
              }, 
            icon: const Icon(Icons.star))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
            children: [
              FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(meal.imageUrl),
                height: 250,
                fit: BoxFit.cover,
                width: double.infinity,
                )
              ,
              Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: Container(
                  color: Colors.black54,
                  padding: const EdgeInsets.all(10.0),
                  child: Text(meal.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white
                  ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Ingredients',
                style: TextStyle(
                  color: Color.fromARGB(255, 235, 127, 4),
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                ),),
                const SizedBox(height: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for(var ingredient in meal.ingredients)
                    Text('.$ingredient',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      wordSpacing: 2,
                      letterSpacing: 1
                    ),),
                    //SizedBox(height: 3,)
                  ],
                ),
                const SizedBox(height: 10,),
                
                  const Text('Steps',
                  //textAlign: TextAlign.start,
                style: TextStyle(
                  color: Color.fromARGB(255, 235, 127, 4),
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                ),),
                const SizedBox(height: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for(var step in meal.steps)
                    Text('->$step\n',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      wordSpacing: 2,
                      letterSpacing: 1,
                    ),)
                  ],
                ),
              ],
            ),
          )
          ]
        ),
      ),
    );
  }
}