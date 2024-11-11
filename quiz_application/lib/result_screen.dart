import 'package:flutter/material.dart';
import 'package:quiz_application/data/questions.dart';
import 'package:quiz_application/question_summary.dart';

class ResultScreen extends StatelessWidget{
  ResultScreen(this.retryQuiz,this.homeScreen,{super.key,required this.chosenAnswers});
  
  final List<String> chosenAnswers;
  Function retryQuiz;
  Function homeScreen;
  List<Map<String,Object>> getSummaryData()
  {
    final List<Map<String,Object>> summaryData=[];

    for(int i=0;i<chosenAnswers.length;i++)
    {
      summaryData.add({
        'question_index':i,
        'question':questions[i].question,
        'correct_answer':questions[i].answers[0],
        'user_answer':chosenAnswers[i],
      });
    }

    return summaryData;
  }
  

  @override
  Widget build(context)
  {
    
    final summaryData=getSummaryData();
    int correctAnswers=summaryData.where(
      (data){
        return data['correct_answer']==data['user_answer'];
      }
    ).length;
    return SizedBox(
      width: double.infinity,
        child: Container(
          margin: const EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('You have answered $correctAnswers out of ${chosenAnswers.length} questions correctly.',
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 255, 255, 255),
              ),),
              const SizedBox(
                height: 30,
              ),
              QuestionSummary(getSummaryData()),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                //mainAxisSize: MainAxisSize.min,
                //crossAxisAlignment: CrossAxisAlignment.,
                children: [
                  OutlinedButton.icon(onPressed: ()
                  {
                    retryQuiz();
                  }, label:const  Text('Retry Quiz',style: TextStyle(
                    color: Colors.white
                  ),),
                  icon: const Icon(Icons.refresh),),
                  const SizedBox(width: 20,),
                  OutlinedButton.icon(
                    icon: const Icon(Icons.home),
                    onPressed: ()
                    {
                      homeScreen();
                    }, label: const Text('Home',
                  style: TextStyle(
                    color: Colors.white
                  ),)),
                ],
              )
             ],
          ),
        ),
      );
  }
}