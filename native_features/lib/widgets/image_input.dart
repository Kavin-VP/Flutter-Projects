import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:native_features/models/place.dart';

class ImageInput extends StatefulWidget{
  const ImageInput({super.key,required this.onPickImage});

  final void Function(File image) onPickImage;
  

  @override
  State<ImageInput> createState() {
    // TODO: implement createState
    return _ImageInputState();
  }

}

class _ImageInputState extends State<ImageInput>
{

  File? _selectedImage;

  void _takePicture() async{

    final imagePicker = ImagePicker();

    var pickedImage = await imagePicker.pickImage(source: ImageSource.camera);

    if(pickedImage!=null)
    {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });

      widget.onPickImage(_selectedImage!);
    }
    else{
      return null;
    }
    
  }

  void _chooseFromGallery() async{

    final imagePicker = new ImagePicker();
    final choosedImage = await imagePicker.pickImage(source: ImageSource.gallery);

    if(choosedImage==null)
    {
      return;
    }
     setState(() {
       _selectedImage = File(choosedImage.path);
     });
  }
  @override
  Widget build(BuildContext context) {

    Widget content;

    if(_selectedImage!=null)
    {
      content = GestureDetector(
        onTap: (){
          setState(() {
            _selectedImage=null;
          });
          
          },
        child: Image.file(
          _selectedImage!,
          fit: BoxFit.cover,
          width: double.infinity,),
      );
    }
    else{
      content = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton.icon(onPressed: _takePicture, 
          label: const Text('Take Picture'),
          icon: const Icon(Icons.camera),
          ),

          TextButton.icon(
            icon: const Icon(Icons.image),
            onPressed: _chooseFromGallery, 
            label: const Text('Gallery'))
        ],
      );
    }
    // TODO: implement build
    return Container(
      //padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.black,
        )
      ),
      height: 200,
      width: double.infinity,
      child: content
    );
  }
  
}