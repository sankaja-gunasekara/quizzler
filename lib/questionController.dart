import 'questions.dart';

class QuestionController {
  int _questionNum = 0;
  int _correctCount = 0;

  List<Questions> _questionList = [
    Questions("This is the question 1", true),
    Questions("This is the question 2", true),
    Questions("This is the question 3", true),
    Questions("This is the question 4", false),
    Questions("This is the question 5", false),
  ];

  String getQuestionText() {
    return _questionList[_questionNum].questionText;
  }

  bool getQuestionAnswer() {
    return _questionList[_questionNum].questionAnswer;
  }

  void nextQuestion() {
    if (_questionNum < _questionList.length - 1) {
      _questionNum++;
    }
  }

  void addPoint() {
    _correctCount++;
  }

  int getPoint() {
    return _correctCount;
  }

  bool isFinished() {
    if (_questionNum < _questionList.length - 1) {
      return false;
    } else {
      return true;
    }
  }

  void reset() {
    _questionNum = 0;
    _correctCount = 0;
  }
}
