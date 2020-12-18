import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:origin_quiz/models/answer.dart';
import 'package:origin_quiz/models/question.dart';
import 'package:origin_quiz/models/result.dart';

class QuizApi {
  static final questionsUrl = "https://10.0.2.2:5001/quiz";

  static Future<List<Question>> getQuestions() async {
    try {
      var data = [];
      final response = await http.get(questionsUrl);
      if (response.statusCode == 200) {
        data = jsonDecode(response.body);
        return List<Question>.from(data.map((e) => Question.fromJson(e)));
      } else {
        throw Exception('Failed to load questions');
      }
    } catch (err) {
      print(err);
      return List<Question>();
    }
  }

  static Future<Result> getResult(List<Answer> answers) async {
    try {
      var data = {};
      final response = await http.post(
        questionsUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(answers),
      );
      if (response.statusCode == 200) {
        data = jsonDecode(response.body);
        return Result.fromJson(data);
      } else {
        throw Exception('Failed to load result');
      }
    } catch (err) {
      print(err);
      return new Result();
    }
  }
}
