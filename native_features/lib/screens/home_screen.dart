import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:native_features/providers/user_places_notifier.dart';
import 'package:native_features/screens/addnew_screen.dart';
import 'package:native_features/screens/place_detail_screen.dart';
//import 'package:shared_preferences/shared_preferences.dart';
//import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends ConsumerStatefulWidget{
  const HomeScreen({super.key});
  
  @override
  ConsumerState<HomeScreen> createState() {
   return _HomeScreenState();
  }

}


class _HomeScreenState extends ConsumerState<HomeScreen>
{

  late Future<void> _placesFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _placesFuture = ref.read(userPlacesProvider.notifier).loadDatabase();
  }
  // void _storeData() async{
  @override
  Widget build(BuildContext context) {

    final placesList= ref.watch(userPlacesProvider);

    var _isLoading = false;

    var content = placesList.isEmpty ? 
                  const Center(
                    child: Text('No places, try adding some'),
                  )
                  :
                  FutureBuilder(future: _placesFuture, builder: (ctx, snapshot){

                    return snapshot.connectionState == ConnectionState.waiting ? 
                    const Center(
                      child: CircularProgressIndicator(),
                    ):
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