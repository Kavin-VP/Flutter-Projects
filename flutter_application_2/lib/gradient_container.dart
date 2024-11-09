import 'package:flutter/material.dart';

class GradientContainer extends StatelessWidget {
  GradientContainer(
    this.color1,
    this.color2, {
    super.key,
  });
  //GradientContainer({key}) : super(key:key);
  final List<String> nameList = [
    'John',
    'Jack',
  ];

  final Color color1;
  final Color color2;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [
          color1,
          color2,
          //Colors.grey,
          //Colors.grey,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      )),
      child: ListView.builder(
          itemCount: nameList.length,
          itemBuilder: (context, idx) {
            var item = nameList[idx];
            return Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                //crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image(
                      height: 50,
                      width: 50,
                      image: NetworkImage(
                          'https://w7.pngwing.com/pngs/178/595/png-transparent-user-profile-computer-icons-login-user-avatars-thumbnail.png')),
                  Text(
                    item,
                    style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.white,
                        //backgroundColor: Colors.black,
                        height: 2,
                        letterSpacing: 2.0),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        print('button pressed');
                      },
                      child: Text('Info')),
                ],
              ),
            );
          }),
    );
  }
}

// Image(
//                 height: 100.0,
//                 width: 100.0,
//                 image: NetworkImage(
//                     'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg')),
//             Image(
//                 height: 100.0,
//                 width: 100.0,
//                 image: NetworkImage(
//                     'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg')),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Expanded(
//                   child: Image(
//                       height: 80.0,
//                       width: 100.0,
//                       image: NetworkImage(
//                           'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg')),
//                 ),
//                 Expanded(
//                   child: Image(
//                       height: 80.0,
//                       width: 100.0,
//                       image: NetworkImage(
//                           'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg')),
//                 ),
//                 Expanded(
//                   // flex: 2,
//                   child: Image(
//                       height: 80.0,
//                       width: 100.0,
//                       image: NetworkImage(
//                           'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg')),
//                 ),
//                 Expanded(
//                   child: Image(
//                       height: 80.0,
//                       width: 100.0,
//                       image: NetworkImage(
//                           'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg')),
//                 )
//               ],
//             ),