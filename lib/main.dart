import 'package:flutter/material.dart';
import 'questionController.dart';
import 'package:alert/alert.dart';
import 'package:platform_alert_dialog/platform_alert_dialog.dart';

void main() => runApp(QuizApp());

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.orange[100],
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: MainPage(),
          ),
        ),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Icon> scoreKeeper = [];
  QuestionController questionController = QuestionController();

  void answerCheck(bool userAnswer) {
    bool answer = questionController.getQuestionAnswer();
    setState(() {
      if (answer == userAnswer) {
        questionController.addPoint();
        scoreKeeper.add(Icon(
          Icons.check,
          color: Colors.teal,
        ));
      } else {
        scoreKeeper.add(Icon(
          Icons.close,
          color: Colors.red[400],
        ));
      }

      if (questionController.isFinished() == true) {
        int finalPoints = questionController.getPoint();

        showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return PlatformAlertDialog(
              title: Text('Finished!'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text('You have got $finalPoints questions right'),
                  ],
                ),
              ),
              actions: <Widget>[
                PlatformDialogAction(
                  child: Text('Start Again'),
                  actionType: ActionType.Preferred,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );

        scoreKeeper = [];
        questionController.reset();
      } else {
        questionController.nextQuestion();
      }
    });
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 6,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                questionController.getQuestionText(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
            child: TextButton(
              onPressed: () {
                answerCheck(true);
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.teal[400]),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ))),
              child: Text(
                "True",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
            child: TextButton(
              onPressed: () {
                answerCheck(false);
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red[400]),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ))),
              child: Text(
                "False",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 8, 10, 0),
          child: Row(
            children: scoreKeeper,
          ),
        ),
      ],
    );
  }
}
