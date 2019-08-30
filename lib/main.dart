import 'package:flutter/material.dart';
import 'package:quizzler/quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  QuizBrain _quizBrain = QuizBrain();
  List<Icon> _scoreKeeper = [];

  void _resetProgress() {
    setState(() {
      print('resetting');
      _quizBrain.reset();
      _scoreKeeper = [];
    });
  }

  void _checkAnswer(bool answer, BuildContext context) {
    if (_quizBrain.hasNextQuestion()) {
      bool correctAnswer = _quizBrain.getQuestionAnswer();
      setState(() {
        if (correctAnswer == answer) {
          _scoreKeeper.add(
            Icon(
              Icons.check,
              color: Colors.green,
            ),
          );
        } else {
          _scoreKeeper.add(
            Icon(
              Icons.close,
              color: Colors.red,
            ),
          );
        }
        _quizBrain.nextQuestion();
      });
    } else {
      _onBasicAlertPressed(context);
    }
  }

  void _onBasicAlertPressed(context) {
    Alert(
        context: context,
        type: AlertType.info,
        title: 'Finished',
        desc: 'You reached the end of the game',
        buttons: <DialogButton>[
          DialogButton(
            child: Text('OK'),
            onPressed: () {
              _resetProgress();
              Navigator.pop(context);
            },
          ),
        ],
        closeFunction: () => _resetProgress()).show();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                _quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () => _checkAnswer(true, context),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () => _checkAnswer(false, context),
            ),
          ),
        ),
        Row(
          children: _scoreKeeper,
        )
      ],
    );
  }
}
