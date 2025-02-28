// import 'dart:convert';
//
// import '../models/models.dart';
// import 'package:http/http.dart' as http;
//
//
// class ApiService {
//   static String url = "https://opentdb.com/api.php?amount=30&type=multiple";
//
//   static Future<List<Question>> fetchQuestions() async {
//     final response = await http.get(Uri.parse(url));
//
//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       return (data['results'] as List).map((json) => Question.fromJson(json)).toList();
//     } else {
//       throw Exception("Failed to load questions");
//     }
//   }
// }

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/models.dart';

class ApiService {
  static Future<List<Question>> fetchQuestions(int amount) async {
    final String url = "https://opentdb.com/api.php?amount=$amount&type=multiple";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['results'] as List).map((json) => Question.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load questions");
    }
  }
}

