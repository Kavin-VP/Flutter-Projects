import 'package:flutter/material.dart';
import 'package:native_features/models/place.dart';
import 'package:native_features/screens/map_screen.dart';

class PlaceDetailScreen extends StatelessWidget{
  const PlaceDetailScreen({required this.place,super.key});

  final Place place;

  String get locationImage{
    final lat = place.location.latitude;
    final lng = place.location.longitude;


    return '''https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng&zoom=16&size=600x300&maptype=roadmap
              &markers=color:red%7Clabel:S%7C$lat,$lng
              &key=AIzaSyBVFa7_v7HuMGXgAzkxugdmDmjo3RDLvhg''';
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
      ),
      body: Stack(
        children: [
          Image.file(
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            place.image),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (ctx)=>
                        MapScreen(location: place.location,onPickMapLocation: (String url, PlaceLocation location){},))
                      );
                    },
                    child: CircleAvatar(
                      radius: 90,
                      backgroundImage: NetworkImage(locationImage),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: Text(place.location.address!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20
                    ),
                    textAlign: TextAlign.center,
                    ),
                  )
                ],
              )
            
            )
        ],
      )
      );
  }

}