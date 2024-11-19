import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:native_features/models/place.dart';
import 'package:http/http.dart' as http;

class MapScreen extends StatefulWidget{
  const MapScreen(
    {
      super.key,
      this.location = const PlaceLocation(latitude: 37.422, longitude: -122.084, address: ''),
      required this.onPickMapLocation});

   final PlaceLocation location;
   final void Function(String url, PlaceLocation location) onPickMapLocation;
  @override
  State<StatefulWidget> createState() {
   return _MapScreenState();
  }
}

class _MapScreenState extends State<MapScreen>{

  LatLng? _pickedPosition;

  String? get mapImage{

    if(_pickedPosition!=null)
    {
       final lat = _pickedPosition!.latitude;
       final lng = _pickedPosition!.longitude;


    return '''https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng&zoom=16&size=600x300&maptype=roadmap
              &markers=color:red%7Clabel:S%7C$lat,$lng
              &key=AIzaSyBVFa7_v7HuMGXgAzkxugdmDmjo3RDLvhg''';
    }
   return null;
  }

  String? mapAddress;
  void getMapAddress() async
  {
  final _latitude = _pickedPosition!.latitude;
  final _longitude = _pickedPosition!.longitude;

  if(_latitude == null || _longitude == null){
    return;
  }
  var url = Uri.parse('https://maps.googleapis.com/maps/api/geocode/json?latlng=$_latitude,$_longitude&key=AIzaSyBVFa7_v7HuMGXgAzkxugdmDmjo3RDLvhg');

  final response = await http.get(url);

  final responseData = json.decode(response.body);
   mapAddress = responseData['results'][0]['formatted_address'];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick your location'),
        actions: [
          IconButton(onPressed: (){
            if(mapImage != null)
            {
              widget.onPickMapLocation(mapImage!, PlaceLocation(latitude: _pickedPosition!.latitude, longitude: _pickedPosition!.longitude, address: mapAddress ?? ''));
              Navigator.of(context).pop();
            }
          }, icon: const Icon(Icons.save))
        ],
      ),
      
      body: GoogleMap(
        onTap: (position){
          setState(() {
            _pickedPosition = position;
          });
        },
        initialCameraPosition:CameraPosition(
          zoom: 16,
          target: LatLng(widget.location.latitude, widget.location.longitude)
          ),
          markers:_pickedPosition == null ? {} : {
            Marker(
              markerId: const MarkerId('mark1'),
              position: _pickedPosition ??  LatLng(
                widget.location.latitude, 
                widget.location.longitude)
                )
          },
          ),
    );
  }
  
}