import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class Auth extends StatefulWidget{
  @override
  State<Auth> createState() {
   return _AuthState();
  }
}

  final _firebase = FirebaseAuth.instance;

class _AuthState extends State<Auth>{

   final _formKey = GlobalKey<FormState>();
   var _isLogin = true;
   var _isAuthLoading = false;
   final _emailController = TextEditingController();
   final _passwordController = TextEditingController();
   final _userNameController = TextEditingController();

   File? _userProfile;
   String? _enteredEmail;
   String? _enteredPassword;
   String _enteredUserName = '';

   void _submitForm() async
   {
    var _isValid = _formKey.currentState!.validate();

    if(!_isValid)
    {
      return;
    }

    _formKey.currentState!.save();

    try{

      if(_isLogin)
      {
        setState(() {
          _isAuthLoading = true;
        });
        final userCredentials = await _firebase.signInWithEmailAndPassword(email: _enteredEmail!, password: _enteredPassword!);

         setState(() {
          _isAuthLoading = false;
        });
        //print(userCredentials);
      }
    else{

       setState(() {
          _isAuthLoading = true;
        });
        final userCredentials = await _firebase.createUserWithEmailAndPassword(email: _enteredEmail!, password: _enteredPassword!);
        
         setState(() {
          _isAuthLoading = false;
        });

        final storageRef = FirebaseStorage.instance
        .ref()
        .child('user-profile-images')
        .child('${userCredentials.user!.uid}.jpg');

        await storageRef.putFile(_userProfile!);
        final imageDownloadUrl = await storageRef.getDownloadURL();

        //storing user data and image url in firestore db

        await FirebaseFirestore.instance.collection('users')
        .doc(userCredentials.user!.uid)
        .set({
          'user_id':userCredentials.user!.uid,
          'user_name':_enteredUserName,
          'user_email':userCredentials.user!.email,
          'image_url':imageDownloadUrl,
        });

        //print(imageDownloadUrl);
        //print(userCredentials);
      }
    }
    on FirebaseAuthException catch(ex)
    {
      setState(() {
          _isAuthLoading = false;
        });

      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            ex.message ?? 'Authentication failed')
            )
            );
    }
   }

   //image picker function
   void _pickImage() async
   {

    String? userOption = await imageSourceDialog();

    if(userOption != null)
    {
      final image = await ImagePicker().pickImage(
      source:userOption == 'camera' ? 
      ImageSource.camera 
      : 
      ImageSource.gallery);

    if(image!=null)
    {
      setState(() {
        _userProfile = File(image.path);
      });
    }
    else{
      //_userProfile =
      //Image(image: AssetImage(''),).
      //Image.file();
      //rootBundle.load('assets/images/user_icon.png');
    }
    }

   }

   //user option for image source - gallery/camera

   Future<String?> imageSourceDialog() async{

    return showDialog<String>(
      barrierDismissible: false,
      context: context, builder: (context){

       return AlertDialog(
        icon: const Icon(Icons.ads_click),
        title: const Text('Choose image source'),
        actions: [
           Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              TextButton.icon(
                onPressed: (){
                Navigator.of(context).pop('gallery');
                //userOption = 'gallery';
                }, 
                label: const Text('Chose from gallery'),
                icon: const Icon(Icons.image_outlined),
                ),
                TextButton.icon(
                onPressed: (){
                   Navigator.of(context).pop('camera');
                   //userOption = 'camera';
                },
                label: const Text('Take Picture'),
                icon: const Icon(Icons.camera_alt),
                )
            ],
                    ),
          
      ],
      );
    });
   }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            //verticalDirection: VerticalDirection.down,
            children: [
              Image.asset('assets/images/chatimage.png',
              width: 200,
              height: 200,),

              Card(
                margin: const EdgeInsets.only(bottom: 20,left: 20,right: 20),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                        children: [
                          if(!_isLogin)
                          Column(
                            children: [
                              CircleAvatar(
                                foregroundImage:_userProfile !=null ? 
                                    FileImage(_userProfile!) 
                                    :
                                    const AssetImage('assets/images/user_icon.png'),
                                radius: 40,
                              ),
                              //IconButton(onPressed: (){}, icon: const Icon(Icons.image)),
                              TextButton.icon(
                                onPressed: _pickImage, 
                                icon: const Icon(Icons.face),
                                label: const Text('Choose profile picture'))
                            ],
                          )
                          ,
                          if(!_isLogin)
                           TextFormField(
                            controller: _userNameController,
                            decoration: const InputDecoration(
                              label: Text('Username'),
                            ),
                            keyboardType: TextInputType.text,
                            enableSuggestions: false,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            validator: (userName){

                              if(userName==null || userName.trim().isEmpty || userName.length<4)
                              {
                                return 'Please enter a valid username (atleast 4 characters)';
                              }
                              return null;
                            },
                            onSaved: (newValue) => _enteredUserName = newValue!,
                          ),
                          
                          const SizedBox(height: 20,),

                          TextFormField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                              label: Text('Email'),
                            ),
                            keyboardType: TextInputType.text,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            validator: (email){

                              if(email==null || email.trim().isEmpty || !email.contains('@'))
                              {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                            onSaved: (newValue) => _enteredEmail = newValue,
                          ),
                          const SizedBox(height: 20,),
                          TextFormField(
                            controller: _passwordController,
                            decoration: const InputDecoration(
                              label: Text('Password'),
                            ),
                            keyboardType: TextInputType.text,
                            autocorrect: false,
                            obscureText: true,
                            validator: (password){

                              if(password==null || password.trim().isEmpty || password.length<5){
                                return 'Password should not be less than 5 characters';
                              }
                              return null;
                            },
                            onSaved: (newValue) => _enteredPassword = newValue,
                          ),
                          const SizedBox(height: 16,),
                          ElevatedButton(
                            onPressed: _submitForm, 
                            child:_isAuthLoading ? const CircularProgressIndicator() : Text(_isLogin ? 'Login' : 'Signup')
                            ),
                            const SizedBox(height: 16,),
                            TextButton(
                              onPressed:_isAuthLoading ? null : (){
                                 setState(() {
                                _isLogin = !_isLogin;
                              });
                              },
                              child: Text(_isLogin ? 'Create an account' : 'Already have account! Login')
                            ),
                        ],
                      )),
                    )
                  ],
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}