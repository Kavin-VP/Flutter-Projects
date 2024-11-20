import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:native_features/models/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// ignore: library_prefixes
import 'package:path_provider/path_provider.dart' as sysPath;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:sqflite/sqlite_api.dart';
import 'package:http/http.dart' as http;


 Future<Database> getDatabase() async {

    var dbPath = await sqflite.getDatabasesPath();

      var db = await sqflite.openDatabase(

        path.join(dbPath,'places.db'),
        onCreate: (db,version){

          return db.execute(
            '''CREATE TABLE user_places
             (id TEXT PRIMARY KEY, title TEXT, 
             image TEXT, lat REAL, lng REAL, address TEXT )'''
          );
        },
        version: 1
      );

      return db;
  }

  //checking the internet connection status
  Future<List<ConnectivityResult>> _checkConnection() async
  {
    var result = await Connectivity().checkConnectivity();
    print(result);
    return result;
  }

class UserPlacesNotifier extends StateNotifier<List<Place>>{

  UserPlacesNotifier() : super(const []);

  Future<void> getDataFromServer() async
  {
    var result = await _checkConnection();

    if(!result.contains(ConnectivityResult.none))
    {
      

      var url = Uri.parse(
        'https://nativefeatures-f6dcf-default-rtdb.firebaseio.com/places.json');
      
      final response = await http.get(url);

      Map<String, dynamic> responseData = json.decode(response.body);

      final db = await getDatabase();
      await db.delete('user_places');
      

      for(final item in responseData.entries)
      {
        //print(item.value['address']);
        db.insert('user_places', {
          'id':item.value['id'],
          'title':item.value['title'],
          'image':item.value['image'],
          'lat':item.value['lat'],
          'lng':item.value['lng'],
          'address':item.value['address']
        });
      }
    }

  }

  Future<void> loadDatabase() async {
    await getDataFromServer();

    var db = await getDatabase();

    var data = await db.query('user_places');

    final placesData = data.map((row)=>Place(
        id: row['id'] as String,
        title: row['title'] as String, 
        image: File(row['image'] as String), 
        location: PlaceLocation(
        latitude: row['lat'] as double, 
        longitude: row['lng'] as double, 
        address: row['address'] as String)
        )
        ).toList();

      state = placesData;
  }
  void addPlace(String title,File image,PlaceLocation location) async
  {

    var appDirectory = await sysPath.getApplicationDocumentsDirectory();
    //print(appDirectory);

    var fileName = path.basename(image.path);

    //print(fileName);

    var copiedImage = await image.copy('${appDirectory.path}/$fileName');
    //print(copiedImage.path);
    var newPlace = Place(title: title,image:copiedImage,location:location );

    
      var db = await getDatabase();
      var id = await db.insert('user_places',
        {
          'id':newPlace.id,
          'title':newPlace.title,
          'image':newPlace.image.path,
          'lat':newPlace.location.latitude,
          'lng':newPlace.location.longitude,
          'address':newPlace.location.address
        }
      );

      var connectionResult = await _checkConnection();

      if(connectionResult.contains(ConnectivityResult.wifi) || 
      connectionResult.contains(ConnectivityResult.mobile))
      {
        //sending request to db to store the data
        //var url = Uri.parse('https://nativefeatures-f6dcf-default-rtdb.firebaseio.com/user-places.json');
        var url = Uri.parse('https://nativefeatures-f6dcf-default-rtdb.firebaseio.com/places.json');
        try
        {
          final response = await http.post(
            url,
            headers: {
              'Content-Type':'application/json'
            },
            body: json.encode({
            'id':newPlace.id,
            'title':newPlace.title,
            'image':newPlace.image.path,
            'lat':newPlace.location.latitude,
            'lng':newPlace.location.longitude,
            'address':newPlace.location.address
          }));

          //final response = await http.get(url);

          print(response.statusCode);
        }
        catch(ex)
        {
          print(ex.toString());
          //return;
        }
      }

     print( await db.query('user_places',columns: ['id','title','image','address']));
      ///db.query();
      print('inserted row id = $id');

    state = [newPlace,...state];
  }

  // @override
  // void dispose() async{
  //   // TODO: implement dispose
  //   var db =  await getDatabase();
  //   db.close();
  //   db.delete('user_places');
  // }
}

final userPlacesProvider = StateNotifierProvider<UserPlacesNotifier,List<Place>>(
  (ref)=>UserPlacesNotifier()
  );