import 'package:flutter/material.dart';
import 'package:origin_quiz/models/question.dart';

import 'components/finish_quiz.dart';
import 'controllers/quiz_controller.dart';

class OriginQuiz extends StatefulWidget {
  @override
  _OriginQuizState createState() => _OriginQuizState();
}

class _OriginQuizState extends State<OriginQuiz> {
  final _controller = QuizController();

  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    await _controller.initialize();

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.grey.shade900,
        title: Text('Origens das Montadoras'),
        centerTitle: true,
        elevation: 0.0,
      ),
      //backgroundColor: Colors.grey.shade900,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: _buildQuiz(),
        ),
      ),
    );
  }

  _buildQuiz() {
    if (_loading) return Center(child: CircularProgressIndicator());

    if (_controller.questionsQtd == 0) return;

    final currQuestion = _controller.getQuestion();
    var quizWidgets = [_buildQuestion(currQuestion)];
    quizWidgets.addAll(_buildAnswerButtons(currQuestion));

    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: quizWidgets);
  }

  Widget _buildQuestion(Question _question) {
    return Expanded(
      flex: 5,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: Center(
          child: Text(
            _question.question,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25.0,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildAnswerButtons(Question question) {
    return List<Widget>.from(question.options.map((e) => Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: GestureDetector(
              child: Container(
                padding: EdgeInsets.all(4.0),
                color: Colors.lightBlue[200],
                child: Center(
                  child: Text(
                    e['value'],
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
              onTap: () {
                setState(() {
                  _controller.registerAnswer(question.id, e['id']);
                  if (_controller.currQuestionStep < _controller.questionsQtd) {
                    _controller.nextQuestion();
                  } else {
                    FinishDialog.show(context, result: _controller.getResult());
                  }
                });
              },
            ),
          ),
        )));
  }
}
