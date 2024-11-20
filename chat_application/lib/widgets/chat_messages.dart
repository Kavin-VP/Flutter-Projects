import 'package:chat_application/widgets/new_message.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatelessWidget{
  const ChatMessages({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Column(
      children: [
        const Expanded(
          child: Center(child: Text('No messages'))),
        NewMessage(),
      ],
    );
  }

}