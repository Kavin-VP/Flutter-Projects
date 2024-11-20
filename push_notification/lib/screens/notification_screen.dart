import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NotificationScreen extends StatelessWidget{
  const NotificationScreen({super.key});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notif'),
      ),
      body: const Center(
        child: Text('Notification Screen'),
      ),
    );
  }
}