import 'package:flutter/material.dart';
import '../../models/models.dart';
import '../../utils/apihelper.dart';

class QuizPage extends StatefulWidget {
  final int numQuestions;
  QuizPage({required this.numQuestions});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  late Future<List<Question>> _questions;
  int _currentIndex = 0;
  int _score = 0;

  @override
  void initState() {
    super.initState();
    _questions = ApiService.fetchQuestions(widget.numQuestions);
  }

  void _checkAnswer(String selected, String correct) {
    if (selected == correct) {
      setState(() {
        _score++;
      });
    }
    setState(() {
      if (_currentIndex < widget.numQuestions - 1) {
        _currentIndex++;
      } else {
        _showResult();
      }
    });
  }

  void _showResult() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Text("Quiz Completed", style: TextStyle(fontWeight: FontWeight.bold)),
        content: Text("Your score: $_score / ${widget.numQuestions}", style: TextStyle(fontSize: 18)),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context); // Go back to HomePage
            },
            child: Text("Back to Home", style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Trivia Quiz", style: TextStyle(fontWeight: FontWeight.bold))),
      body: FutureBuilder<List<Question>>(
        future: _questions,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error loading questions", style: TextStyle(fontSize: 18)));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No questions available", style: TextStyle(fontSize: 18)));
          }

          var question = snapshot.data![_currentIndex];

          return Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [

                LinearProgressIndicator(
                  value: (_currentIndex + 1) / widget.numQuestions,
                  backgroundColor: Colors.grey.shade300,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
                SizedBox(height: 20),


                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  elevation: 8,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Question ${_currentIndex + 1} / ${widget.numQuestions}",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueAccent),
                        ),
                        SizedBox(height: 10),
                        Text(
                          question.question,
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),


                ...question.options.map(
                      (option) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: ElevatedButton(
                      onPressed: () => _checkAnswer(option, question.correctAnswer),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade700,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        elevation: 5,
                      ),
                      child: Text(option, style: TextStyle(fontSize: 18)),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
