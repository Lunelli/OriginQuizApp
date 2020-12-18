import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:origin_quiz/models/result.dart';

import '../quiz.dart';

class FinishDialog {
  static Future show(
    BuildContext context, {
    @required Future<Result> result,
  }) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return FutureBuilder<Result>(
          future: result,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                title: CircleAvatar(
                  maxRadius: 35.0,
                  backgroundColor: snapshot.data.hitPercentage < 60
                      ? Colors.red
                      : Colors.green,
                  child: Icon(
                    snapshot.data.hitPercentage < 60
                        ? Icons.warning
                        : Icons.favorite,
                    color: Colors.white,
                  ),
                ),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      snapshot.data.statement,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                actions: [
                  FlatButton(
                    child: const Text('Jogar novamente'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => OriginQuiz()),
                      );
                    },
                  ),
                  FlatButton(
                    child: const Text('Finalizar'),
                    onPressed: () {
                      SystemNavigator.pop();
                    },
                  )
                ],
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                content: Center(child: CircularProgressIndicator()));

            //return CircularProgressIndicator();
          },
        );
      },
    );
  }
}
