import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget{
  @override
  State<NewMessage> createState() {
    return _NewMessageState();
  }

}

class _NewMessageState extends State<NewMessage>
{
  final _messageController = TextEditingController();
  void _sendMessage()
  {
    var message = _messageController.text;

    if(message == null || message.trim().isEmpty)
    {
      return;
    }

    _messageController.clear();
  }
  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: const EdgeInsets.only(left: 20,right: 10,top: 10,bottom: 20),
      child: Row(
        //crossAxisAlignment: CrossAxisAlignment.center,
        //mainAxisAlignment: MainAxisAlignment.end,
        children: [
           Expanded(
            child: TextField(
              autocorrect: true,
              textCapitalization: TextCapitalization.sentences,
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Send new message...',
              ),
            )
            ),
          IconButton(
            onPressed: _sendMessage, 
            icon: const Icon(Icons.send)
            )
        ],
      ),
    );
  }
  
}