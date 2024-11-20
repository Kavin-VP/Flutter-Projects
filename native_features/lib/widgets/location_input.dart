import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:native_features/models/place.dart';
import 'package:native_features/screens/map_screen.dart';

class LocationInput extends StatefulWidget{
  const LocationInput({super.key,required this.onPickLocation});


  final void Function(PlaceLocation location) onPickLocation;
  
  
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LocationInputState();
  }

}

class _LocationInputState extends State<LocationInput>
{

  PlaceLocation? _pickedLocation;
  var _isGettingLocation = false;
  

  void _getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

  setState(() {
    _isGettingLocation = true;
  });
  locationData = await location.getLocation();


  final _latitude = locationData.latitude;
  final _longitude = locationData.longitude;

  if(_latitude == null || _longitude == null){
    return;
  }
  var url = Uri.parse('https://maps.googleapis.com/maps/api/geocode/json?latlng=$_latitude,$_longitude&key=AIzaSyBVFa7_v7HuMGXgAzkxugdmDmjo3RDLvhg');

  final response = await http.get(url);

  final responseData = json.decode(response.body);
  final address = responseData['results'][0]['formatted_address'];


  print(responseData['results'][0]['formatted_address']);

  setState(() {
    _isGettingLocation = false;
    _pickedLocation = PlaceLocation(latitude: _latitude, longitude: _longitude, address: address);

  if(_pickedLocation!=null)
  {
    widget.onPickLocation(_pickedLocation!);
  }
    
  });
  // print(locationData.latitude);
  // print(locationData.longitude);
  }

  String? mapImageUrl;
  void mapLocationImage(String url, PlaceLocation location) async
  {
    setState(() {
      mapImageUrl = url;
      _pickedLocation = location;
      
    });
    await getMapAddress();

    widget.onPickLocation(_pickedLocation!);
  }

  Future<void> getMapAddress() async
  {
    final _latitude = _pickedLocation!.latitude;
    final _longitude = _pickedLocation!.longitude;

  if(_latitude == null || _longitude == null){
    return;
  }
  var url = Uri.parse('https://maps.googleapis.com/maps/api/geocode/json?latlng=$_latitude,$_longitude&key=AIzaSyBVFa7_v7HuMGXgAzkxugdmDmjo3RDLvhg');

  final response = await http.get(url);
  //http.MultipartFile(field, stream, length)

  final responseData = json.decode(response.body);
  final address = responseData['results'][0]['formatted_address'];

  _pickedLocation = PlaceLocation(latitude: _pickedLocation!.latitude, longitude: _pickedLocation!.longitude, address: address);
  //_pickedLocation!.address = address;
  }
  String get locationImage{

    if(_pickedLocation==null)
    {
      return '';
    }

    final lat = _pickedLocation!.latitude;
    final lng = _pickedLocation!.longitude;


    return '''https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng&zoom=16&size=600x300&maptype=roadmap
&markers=color:red%7Clabel:S%7C$lat,$lng
&key=AIzaSyBVFa7_v7HuMGXgAzkxugdmDmjo3RDLvhg''';
  }

  @override
  Widget build(BuildContext context) {

    var content = _isGettingLocation ? const CircularProgressIndicator()
                  :
                  const Text('Choose location',)
                  ;

          if(_pickedLocation!=null)
          {
            setState(() {
              content = Flexible(
                child: Image.network(
                  locationImage,
                  //height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  ),
              );
            });
          }

          if(mapImageUrl != null)
          {
            setState(() {
              content = Flexible(
                child: Image.network(
                  mapImageUrl!,
                  //height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  ),
              );
            });
          }
                  
    return Column(
      children: [
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: Colors.black,
            )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              content,
            ],
          ),
        ),
        Row(
                //crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton.icon(
                    onPressed: _getCurrentLocation, 
                    label: const Text('Use Current Location'),
                    icon: const Icon(Icons.location_on),
                    ),
                    const SizedBox(width: 10,),
                    TextButton.icon(
                      onPressed: (){
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx)=>MapScreen(
                              onPickMapLocation: mapLocationImage,
                              location: _pickedLocation ?? PlaceLocation(latitude: 37.422, longitude: -122.084, address: ''),
                              )
                              )
                              );
                      }, 
                      label: const Text('Select on map'),
                      icon: const Icon(Icons.map),
                      )
        
                ],
              )
      ],
    );
  }
  
}