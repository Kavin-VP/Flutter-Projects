import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatelessWidget{
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text('Welcome'),
          SizedBox(height: 20,),
          Text('Please signin to get started'),
          SizedBox(height: 20,),
          
          Form(
            key: _formKey,
            child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  label: Text('Email'),
                ),
              ),
              const SizedBox(height: 20,),
              TextFormField(
                validator: (value){
                  if(value==null || value.isEmpty)
                  {
                    return "please enter a value";
                  }
                  else
                  {
                    return null;
                  }
                },
                decoration: const InputDecoration(
                  label: Text('Password'),
                ),
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: (){
                      if(_formKey.currentState!.validate())
                      {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('submitting data...'),
                          duration: Duration(seconds: 3),
                          )
                        );
                      }
                    },
                    child: const Text('Submit')),
                    SizedBox(width: 10,),
                    ElevatedButton(
                      onPressed: (){},
                      child: Text('Reset'))
                ],
              )
            ],
          )
          )
        ],
      ),
    );
  }
}