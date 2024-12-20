import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async
{
  print('Title : ${message.notification?.title}');
  print('body : ${message.notification?.body}');
  print('Payload : ${message.data}');
}
class FirebaseApi {

  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async{
    await _firebaseMessaging.requestPermission();

    final token = await _firebaseMessaging.getToken();

    print('Token : $token');

    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }
}