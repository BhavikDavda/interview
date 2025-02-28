// import 'package:flutter/material.dart';
// import '../../models/models.dart';
// import '../../utils/apihelper.dart';
//
//
// class QuizPage extends StatefulWidget {
//   @override
//   _QuizPageState createState() => _QuizPageState();
// }
//
// class _QuizPageState extends State<QuizPage> {
//   late Future<List<Question>> _questions;
//   int _currentIndex = 0;
//   int _score = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     _questions = ApiService.fetchQuestions();
//   }
//
//   void _checkAnswer(String selected, String correct) {
//     if (selected == correct) {
//       setState(() {
//         _score++;
//       });
//     }
//     setState(() {
//       if (_currentIndex < 29) {
//         _currentIndex++;
//       } else {
//         _showResult();
//       }
//     });
//   }
//
//   void _showResult() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text("Quiz Completed"),
//         content: Text("Your score: $_score / 30"),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//               setState(() {
//                 _currentIndex = 0;
//                 _score = 0;
//               });
//             },
//             child: Text("Restart"),
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Trivia Quiz")),
//       body: FutureBuilder<List<Question>>(
//         future: _questions,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text("Error loading questions"));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(child: Text("No questions available"));
//           }
//
//           var question = snapshot.data![_currentIndex];
//
//           return Padding(
//             padding: EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Question ${_currentIndex + 1}/30",
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(height: 20),
//                 Text(
//                   question.question,
//                   style: TextStyle(fontSize: 18),
//                 ),
//                 SizedBox(height: 20),
//                 ...question.options.map(
//                       (option) => ElevatedButton(
//                     onPressed: () => _checkAnswer(option, question.correctAnswer),
//                     child: Text(option),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }






import 'package:flutter/material.dart';
import 'package:interview/view/screens/quizpage.dart';

class HomePage extends StatelessWidget {
  void startQuiz(BuildContext context, int numQuestions) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => QuizPage(numQuestions: numQuestions)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade900, Colors.blueAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              elevation: 10,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      "Choose the number of questions",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    buildQuizButton(context, "10 Questions", 10),
                    buildQuizButton(context, "30 Questions", 30),
                    buildQuizButton(context, "50 Questions", 50),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildQuizButton(BuildContext context, String text, int numQuestions) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: () => startQuiz(context, numQuestions),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue.shade700,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
          textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 5,
        ),
        child: Text(text),
      ),
    );
  }
}





























