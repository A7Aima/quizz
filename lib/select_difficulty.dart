import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quizz/main.dart';

class Difficulty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.exit_to_app),
        label: Text("Exit"),
        backgroundColor: Colors.grey.shade900,
        onPressed: () => SystemNavigator.pop(),
      ),
      backgroundColor: Colors.grey.shade900,
      body: SafeArea(
        child: Center(
          child: Container(
            margin: EdgeInsets.all(100),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 1,
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => Quizz(easy: true, wrongLimit: 0),
                      ));
                    },
                    color: Colors.green,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Easy",
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          "(Even you can get it)",
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => Quizz(easy: false, wrongLimit: 5),
                      ));
                    },
                    color: Colors.yellow[800],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Hard",
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          "(Yours life hardest part)",
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => Quizz(easy: false, wrongLimit: 1),
                      ));
                    },
                    color: Colors.red,
                    child: Text(
                      "Go HOME",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
