import 'package:flutter/material.dart';
import 'package:interview/view/screens/homepage.dart';
import 'package:interview/view/screens/quizpage.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: "/",
    routes: {
      "/": (context) => HomePage(),

    },
  ));
}