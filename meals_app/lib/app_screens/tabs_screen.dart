import 'package:flutter/material.dart';
import 'package:meals_app/app_screens/categories_screen.dart';
import 'package:meals_app/app_screens/filters_screen.dart';
import 'package:meals_app/app_screens/meals_screen.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/main_drawer.dart';

const kInitialFilterValues={
  Filter.glutenFree:false,
  Filter.lactoseFree:false,
  Filter.vegetarian:false,
  Filter.vegan:false,
};

class TabsScreen extends StatefulWidget{
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen>{
  
  int _selectedPageIndex=0;
  Map<Filter,bool> filterValues = kInitialFilterValues;
  void _selectPage(int index)
  {
    setState(() {
      _selectedPageIndex=index;
    });
  }
  
    //method for showing info snackbar
    void _showInfoMesage(String message)
    {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          content: Text(message)
          )
      );
    }
  final List<Meal> _favouriteMeals=[];

  void _toggleFavouriteIcon(Meal meal)
  {
    var isExisting = _favouriteMeals.contains(meal);

    if(isExisting)
    {
      setState(() {
        _favouriteMeals.remove(meal);
        _showInfoMesage('Removed from Favourites');
      });
    }
    else
    {
      setState(() {
        _favouriteMeals.add(meal);
        _showInfoMesage('Added to Favourites');
      });
    }
  }
  
  //side drawer screen


  @override
  Widget build(BuildContext context) {

    List<Meal> filteredMeals=dummyMeals;

    if(filterValues[Filter.glutenFree]!||filterValues[Filter.lactoseFree]!||
    filterValues[Filter.vegan]!||filterValues[Filter.vegetarian]!)
    {
      setState(() {
        filteredMeals = dummyMeals.where(
      (meal){
        if(filterValues[Filter.glutenFree]! && !meal.isGlutenFree)
        {
          return false;
        }
        if(filterValues[Filter.lactoseFree]! && !meal.isLactoseFree)
        {
          return false;
        }
        if(filterValues[Filter.vegetarian]! && !meal.isVegetarian)
        {
          return false;
        }
        if(filterValues[Filter.vegan]! && !meal.isVegan)
        {
          return false;
        }

        return true;
      }
      
    ).toList();
      });
    }
    

    Widget activePage = Categories(
          onToggleFavourite: _toggleFavouriteIcon,
          availableMeals: filteredMeals,
          );

     void _setScreen(String tappedScreen) async
  {
    //Navigator.pop(context); -> alternative
    Navigator.of(context).pop();
    if(tappedScreen=='filter')
    {
      // setState(() {
      //   activePage = FiltersScreen();
      // });
      final result = await Navigator.of(context).push<Map<Filter,bool>>(MaterialPageRoute(builder: 
      (ctx)=>  FiltersScreen(filterValues: filterValues,)));
      setState(() {
      filterValues=result ?? kInitialFilterValues;
      });//_runFilterList();
      //print(result);
    }
    else
    {
      //Navigator.of(context).pop();
      _selectPage(0);
      setState(() {
        activePage = Categories(
          onToggleFavourite: _toggleFavouriteIcon,
          availableMeals: filteredMeals,
          );
      });
    }
  }
    //print(filteredMeals);
   activePage =  Categories(
    onToggleFavourite: _toggleFavouriteIcon,
    availableMeals: filteredMeals,
    );

    var activePageTitle = 'Categories';
    if(_selectedPageIndex==1)
    {
      activePage =  MealsScreen(
        meals: _favouriteMeals,
        onToggleFavourite: _toggleFavouriteIcon,);
      activePageTitle = 'Your Favourites';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(setScreen: _setScreen,),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: _selectPage,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favourites')
        ]),
    );
  }
}