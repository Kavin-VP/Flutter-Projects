import 'package:flutter/material.dart';

class QuestionSummary extends StatelessWidget{
  const QuestionSummary(this.summaryData,{super.key});
   final List<Map<String,Object>> summaryData;

  @override
  Widget build(BuildContext context) {
    //print('build method');
   return SizedBox(
    height:300,
     child: SingleChildScrollView(
       child: Column(
        children: summaryData.map(
          (data){
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                //padding: EdgeInsets.all(8.0),
                width: 30,
                height: 30,
                margin: const EdgeInsets.only(right: 20.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color:data['user_answer']==data['correct_answer']?const Color.fromARGB(255, 129, 221, 177):const Color.fromARGB(255, 227, 104, 104),
                ),
                child: Text(((data['question_index'] as int) +1).toString(),
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
                  
                ),),
              ),
              Expanded(
                child: Column(
                  
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data['question'] as String,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),),
                    const SizedBox(
                      height: 7,
                    ),
                    Text('Your Answer:${data['user_answer'] as String}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: data['user_answer']==data['correct_answer']?Colors.greenAccent:Colors.redAccent,
                    ),),
                    Text('Correct Answer:${data['correct_answer'] as String}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.greenAccent,
                    ),),
                    const SizedBox(
                      height: 7,
                    ),
                  ],
                ),
              )
            ],
          );
        }).toList(),
       ),
     ),
   );
  }
}