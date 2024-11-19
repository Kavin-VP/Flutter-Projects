import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:native_features/models/place.dart';
import 'package:native_features/providers/user_places_notifier.dart';
import 'package:native_features/widgets/image_input.dart';
import 'package:native_features/widgets/location_input.dart';

class AddnewScreen extends ConsumerStatefulWidget{
  const AddnewScreen({super.key});

  //final void Function(File image) onPickImage;
  
  @override
  ConsumerState<AddnewScreen> createState() {
    return _AddNewScreenState();
  }

}

class _AddNewScreenState extends ConsumerState<AddnewScreen>{

  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  File? _selectedImage;
  PlaceLocation? _pickedLocation;

  void _savePlace(){
    if(_formKey.currentState!.validate())
    {
      ref.read(userPlacesProvider.notifier).addPlace(_titleController.text,_selectedImage!,_pickedLocation!);

      Navigator.of(context).pop();
    }
  }

  void onPickImage(File image){
    _selectedImage = image;
  }

  void onPickLocation(PlaceLocation location)
  {
    _pickedLocation = location;
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _titleController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new Place'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
          children: [
            TextFormField(
              controller: _titleController,
              maxLength: 20,
              decoration: const InputDecoration(
                label: Text('Place name'),
              ),
              validator: (value){
                if(value==null || value.isEmpty)
                {
                  return 'please enter a place';
                }
                return null;
              },
              onSaved: (value){
        
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ImageInput(onPickImage: onPickImage,),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: LocationInput(onPickLocation: onPickLocation,),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton.icon(onPressed: (){
                  _savePlace();
                }, label: const Text('Add Place'),
                icon: const Icon(Icons.add),
                ),
              ],
            )
          ],
        )),
      ),
    );
  }
}