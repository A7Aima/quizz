class QuestionClass {
  String questions;
  bool check;
  QuestionClass({this.questions, this.check});
}

//

//

//

//

class QuizBrain {
  int _questionNo = 0;

  List<QuestionClass> _questionCollection = [
    QuestionClass(
        questions: "Approximately one quarter of human bones are in the feet.",
        check: true),
    QuestionClass(
        questions:
            "Cyclones spin in a clockwise direction in the southern hemisphere",
        check: true),
    QuestionClass(
        questions: "Goldfish only have a memory of three seconds",
        check: false),
    QuestionClass(questions: "The capital of Libya is Benghazi", check: false),
    QuestionClass(
        questions: "Dolly Parton is the godmother of Miley Cyrus", check: true),
    QuestionClass(
      questions:
          "Roger Federer has won the most Wimbledon titles of any player",
      check: false,
    ),
    QuestionClass(questions: "An octopus has five hearts", check: false),
    QuestionClass(
        questions:
            "Brazil is the only country in the Americas to have the official language of Portuguese",
        check: true),
    QuestionClass(
        questions: "The Channel Tunnel is the longest rail tunnel in the world",
        check: false),
    QuestionClass(
        questions:
            "Darth Vader famously says the line “Luke, I am your father” in The Empire Strikes Back",
        check: false),
    QuestionClass(
        questions:
            "Olivia Newton-John represented the UK in the Eurovision Song Contest in 1974, the year ABBA won with “Waterloo”",
        check: true),
    QuestionClass(
        questions: "Stephen Hawking declined a knighthood from the Queen",
        check: true),
    QuestionClass(
        questions: "The highest mountain in England is Ben Nevis",
        check: false),
    QuestionClass(
        questions:
            "Nicolas Cage and Michael Jackson both married the same woman",
        check: true),
    QuestionClass(
        questions:
            "Japan and Russia did not sign a peace treaty after World War Two so are technically still at war",
        check: true),
    QuestionClass(
        questions:
            "The mathematical name for the shape of a Pringle is hyperbolic paraboloid",
        check: true),
    QuestionClass(
        questions:
            "Charlie Chaplin came first in a Charlie Chaplin look-alike contest",
        check: false),
    QuestionClass(
        questions: "Michael Keaton’s real name is Michael Douglas",
        check: true),
    QuestionClass(
        questions: "Napoleon was of below-average height", check: false),
    QuestionClass(
        questions: "Donald Duck’s middle name is Fauntelroy", check: true),
    QuestionClass(
        questions: "The Statue of Liberty was a gift from France", check: true),
    QuestionClass(
        questions:
            "According to Scottish law, it is illegal to be drunk in charge of a cow",
        check: true),
    QuestionClass(
        questions: "The Great Wall of China is visible from space",
        check: false),
    QuestionClass(
        questions: "The first tea bags were made of silk", check: true),
    QuestionClass(
        questions: "Meghan Markle’s first name is Rachel", check: true),
    QuestionClass(questions: "Warsaw is the capital of Bulgaria", check: false),
    QuestionClass(questions: "A metre is further than a yard", check: true),
    QuestionClass(questions: "A woman has walked on the moon", check: false),
    QuestionClass(
        questions:
            "Flying in an aeroplane is statistically safer than driving in a car",
        check: true),
    QuestionClass(
        questions: "John Challis plays Boycie in Only Fools and Horses",
        check: true),
    QuestionClass(questions: "Valletta is the capital of Cyprus", check: false),
    QuestionClass(
        questions: "The currency of France is the Franc", check: false),
    QuestionClass(
        questions: "Radiohead wrote the song Love is All Around", check: false),
    QuestionClass(
        questions: "You can lead a cow down stairs but not up stairs.",
        check: false),
  ];

  void nextQuestion() {
    if (_questionNo < _questionCollection.length - 1) {
      _questionNo++;
    }
  }

  bool endQuestions() {
    return _questionNo == _questionCollection.length - 1;
  }

  String getQuestion() {
    return "${_questionNo + 1} : ${_questionCollection[_questionNo].questions}";
  }

  bool getAnswer() {
    return _questionCollection[_questionNo].check;
  }

  int getLength() {
    return _questionCollection.length;
  }
}
