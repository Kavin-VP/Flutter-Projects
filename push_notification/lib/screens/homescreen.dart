import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Homescreen extends StatelessWidget{
  const Homescreen({super.key});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text('home'),
      ),
      body: const Center(
        child: Text('Home Screen'),
      ),
    );
  }
}