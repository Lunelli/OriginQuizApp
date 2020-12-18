import 'package:origin_quiz/models/answer.dart';
import 'package:origin_quiz/models/question.dart';
import 'package:origin_quiz/models/result.dart';
import 'package:origin_quiz/services/quiz_api.dart';

class QuizController {
  List<Question> _questions;
  List<Answer> _answers;

  int _questionIndex = 0;

  int get questionsQtd => _questions.length ?? 0;
  int get currQuestionStep => (_questionIndex + 1);
  List<Answer> get answers => _answers;
  Question get question => _questions[_questionIndex];

  Future<void> initialize() async {
    _questionIndex = 0;
    _answers = [];
    _questions = await QuizApi.getQuestions();
    _questions.shuffle();
  }

  void nextQuestion() {
    _questionIndex = ++_questionIndex % _questions.length;
  }

  void registerAnswer(String _questionId, String _answerId) {
    _answers.add(new Answer(questionId: _questionId, answerId: _answerId));
  }

  Question getQuestion() {
    return _questions[_questionIndex];
  }

  Future<Result> getResult() {
    return QuizApi.getResult(_answers);
  }
}
