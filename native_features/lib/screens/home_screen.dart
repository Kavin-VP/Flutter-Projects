import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:native_features/providers/user_places_notifier.dart';
import 'package:native_features/screens/addnew_screen.dart';
import 'package:native_features/screens/place_detail_screen.dart';
//import 'package:shared_preferences/shared_preferences.dart';
//import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends ConsumerWidget{
  const HomeScreen({super.key});

  // void _storeData() async{
  @override
  Widget build(BuildContext context,WidgetRef ref) {

    final placesList= ref.watch(userPlacesProvider);

    var content = placesList.isEmpty ? 
                  const Center(
                    child: Text('No places, try adding some'),
                  )
                  :
                  ListView.builder(
        itemCount: placesList.length,
        itemBuilder: (ctx,index){
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: InkWell(
            onTap: (){
              Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx)=>
                PlaceDetailScreen(place: placesList[index],)));
            },
            child: ListTile(
              leading: CircleAvatar(
                radius: 20,
                backgroundImage: FileImage(placesList[index].image),
              ),
              title: Text(placesList[index].title),
              subtitle: Text(placesList[index].location.address!),
              )
              ),
        );
      });

    //Future<List<String>?> placesList = _getData();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
              return const AddnewScreen();
            }));
          }, icon: const Icon(Icons.add)),
        ],
      ),
      body: content
    );
  }
}