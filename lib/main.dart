import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quizz/QuestionModel.dart';
import 'package:quizz/select_difficulty.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Difficulty(),
    );
  }
}

class Quizz extends StatelessWidget {
  final bool easy;
  final int wrongLimit;
  Quizz({this.easy, this.wrongLimit});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.grey.shade900,
        label: Text("Restart"),
        icon: Icon(Icons.refresh),
        onPressed: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => Difficulty(),
          ));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: QuizPage(easy: easy, wrongLimit: wrongLimit),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  final bool easy;
  final int wrongLimit;
  QuizPage({this.easy, this.wrongLimit});
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  QuizBrain quizBrain = QuizBrain();
  List<Icon> scoreKeeper = [];
  Color color;
  String description;
  int right = 0;
  int wrong = 0;

  @override
  Widget build(BuildContext context) {
    getColor();
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        buildDisplay(),
        buildTrueButton(),
        buildFalseButton(),
        Wrap(
          children: scoreKeeper,
        ),
      ],
    );
  }

  void getColor() {
    if (widget.easy && widget.wrongLimit == 0) {
      color = Colors.green;
      description = "Well Done";
    } else if ((!widget.easy) && widget.wrongLimit == 5) {
      color = Colors.yellow[800];
      description = "Find someone you can be with in your life";
    } else {
      color = Colors.red;
      description = "This tells me you have nothing to do in your life";
    }
  }

  Expanded buildFalseButton() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: FlatButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          color: Colors.red,
          child: Text(
            'False',
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
          onPressed: () {
            //The user picked false.
            setState(() {
              if (quizBrain.getAnswer() == false) {
                ++right;
                //print(right);
                scoreKeeper.add(
                  Icon(
                    Icons.check,
                    color: Colors.green,
                  ),
                );
              } else {
                ++wrong;
                scoreKeeper.add(
                  Icon(
                    Icons.close,
                    color: Colors.red,
                  ),
                );
              }
              if (!widget.easy) {
                if (widget.wrongLimit == wrong) {
                  _nextTimeBox(context); //TODO: There will be the change
                }
              }
              if (!quizBrain.endQuestions()) {
                quizBrain.nextQuestion();
              } else {
                //print(right);
                _dialogBox(context);
              }
            });
          },
        ),
      ),
    );
  }

  Expanded buildTrueButton() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: FlatButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          textColor: Colors.white,
          color: Colors.green,
          child: Text(
            'True',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
          ),
          onPressed: () {
            //The user picked true.
            setState(() {
              if (quizBrain.getAnswer() == true) {
                ++right;
                //print(right);
                scoreKeeper.add(
                  Icon(
                    Icons.check,
                    color: Colors.green,
                  ),
                );
              } else {
                ++wrong;
                scoreKeeper.add(
                  Icon(
                    Icons.close,
                    color: Colors.red,
                  ),
                );
              }
              if (!widget.easy) {
                if (widget.wrongLimit == wrong) {
                  _nextTimeBox(context); //TODO: There will be the change
                }
              }
              if (!quizBrain.endQuestions()) {
                quizBrain.nextQuestion();
              } else {
                //print(right);
                _dialogBox(context);
              }
            });
          },
        ),
      ),
    );
  }

  Expanded buildDisplay() {
    return Expanded(
      flex: 5,
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              color: color,
              border: Border.all(color: Colors.white, width: 3),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Text(
              quizBrain.getQuestion(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  _dialogBox(context) {
    // Reusable alert style
    var alertStyle = AlertStyle(
      animationType: AnimationType.grow,
      isCloseButton: false,
      isOverlayTapDismiss: false,
      descStyle: TextStyle(fontWeight: FontWeight.bold),
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.0),
        side: BorderSide(
          width: 5,
          color: Colors.green,
        ),
      ),
      titleStyle: TextStyle(
        color: color,
      ),
      constraints: BoxConstraints.expand(width: 300),
      //First to chars "55" represents transparency of color
      overlayColor: Color(0x55000000),
      alertElevation: 0,
      alertAlignment: Alignment.center,
    );

    // Alert dialog using custom alert style
    Alert(
      context: context,
      style: alertStyle,
      type: AlertType.success,
      title: description,
      desc: "$right/${quizBrain.getLength()}",
      buttons: [
        DialogButton(
          color: Colors.transparent,
          onPressed: () {
            setState(() {
              scoreKeeper = [];
              right = 0;
            });
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => Difficulty(),
            ));
          },
          child: Text(
            'Play Again',
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              fontSize: 15,
            ),
          ),
        ),
        DialogButton(
          color: Colors.transparent,
          onPressed: () {
            SystemNavigator.pop();
          },
          child: Text(
            'QUIT',
            style: TextStyle(
              color: Colors.blue,
            ),
          ),
        ),
      ],
    ).show();
  }

  _nextTimeBox(context) {
    // Reusable alert style
    var alertStyle = AlertStyle(
      animationType: AnimationType.grow,
      isCloseButton: false,
      isOverlayTapDismiss: false,
      descStyle: TextStyle(
          color: Colors.red, fontSize: 15, fontWeight: FontWeight.bold),
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.0),
        side: BorderSide(
          width: 5,
          color: color,
        ),
      ),
      titleStyle: TextStyle(
        color: color,
      ),
      constraints: BoxConstraints.expand(width: 300),
      //First to chars "55" represents transparency of color
      overlayColor: Color(0x55000000),
      alertElevation: 0,
      alertAlignment: Alignment.center,
    );

    // Alert dialog using custom alert style
    Alert(
      context: context,
      style: alertStyle,
      image: Image.asset("assets/lol.png"),
      // type: AlertType.info,
      title: 'Just Go Home',
      desc: "Can't even walk $wrong steps",
      buttons: [
        DialogButton(
          color: Colors.transparent,
          onPressed: () {
            setState(() {
              scoreKeeper = [];
              right = 0;
              wrong = 0;
            });
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => Difficulty(),
            ));
          },
          child: Text(
            'Play Again',
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              fontSize: 15,
            ),
          ),
        ),
        DialogButton(
          color: Colors.transparent,
          onPressed: () {
            SystemNavigator.pop();
          },
          child: Text(
            'QUIT',
            style: TextStyle(
              color: Colors.blue,
            ),
          ),
        ),
      ],
    ).show();
  }
}
