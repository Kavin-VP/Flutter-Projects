
import 'dart:io';

import 'package:uuid/uuid.dart';


final uuid = Uuid();
class Place {
  Place(
    {
      required this.title,
      required this.image, 
      required this.location
      }):id=uuid.v4();

  String id;
  String title;
  File image;
  PlaceLocation location;
}

class PlaceLocation{
   const PlaceLocation(
    {
      required this.latitude, 
      required this.longitude, 
      required this.address
    }
    );


  final double latitude;
  final double longitude;
  final String address;
}