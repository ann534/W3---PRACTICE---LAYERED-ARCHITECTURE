class Question {
  final String title;
  final List<String> choices;
  final String goodChoice;
  final int points;

  Question({
    required this.title, 
    required this.choices, 
    required this.goodChoice, 
    required this.points
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      title: json['title'] as String,
      choices: List<String>.from(json['choices'] as List),
      goodChoice: json['goodChoice'] as String,
      points: json['point'] as int,
    );
  }
}


class Answer{
  final Question question;
  final String answerChoice;
  

  Answer({required this.question, required this.answerChoice});

  bool isGood(){
    return this.answerChoice == question.goodChoice;
  }
}

class Quiz{
  List<Question> questions;
  List <Answer> answers =[];

  Quiz({required this.questions});

  void addAnswer(Answer asnwer) {
     this.answers.add(asnwer);
  }
  int getPoints() {
    int totalPoints = 0;
    for (Answer answer in answers) {
      if (answer.isGood()) {
        totalPoints += answer.question.points;
      }
    }
    return totalPoints;
  }

  int getMaxPoints() {
    return questions.fold(0, (sum, question) => sum + question.points);
  }

  int getScoreInPercentage(){
    int totalSCore =0;
    for(Answer answer in answers){
      if (answer.isGood()) {
        totalSCore++;
      }
    }
    return ((totalSCore/ questions.length)*100).toInt();

  }
}