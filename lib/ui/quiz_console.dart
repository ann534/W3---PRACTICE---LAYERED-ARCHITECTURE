import 'dart:io';
import '../domain/quiz.dart';

class QuizConsole {
  Quiz quiz;
  List<PlayerResult> playerResults = [];

  QuizConsole({required this.quiz});

  void startQuiz() {
    while (true) {
      stdout.write('\nYour name: ');
      String? playerName = stdin.readLineSync()?.trim();
      
      if (playerName == null || playerName.isEmpty) {
        _showFinalResults();
        break;
      }

      _runQuizForPlayer(playerName);
      _showPlayerResults(playerName);
    }
  }

  void _runQuizForPlayer(String playerName) {
    quiz.answers.clear(); // Reset answers for new player
    
    for (var question in quiz.questions) {
      print('\nQuestion: ${question.title} - (${question.points} points)');
      print('Choices: ${question.choices}');
      stdout.write('Your answer: ');
      String? userInput = stdin.readLineSync();

      if (userInput != null && userInput.isNotEmpty) {
        Answer answer = Answer(question: question, answerChoice: userInput);
        quiz.addAnswer(answer);
      }
    }

    // Store player's result
    playerResults.removeWhere((result) => result.name == playerName); // Remove previous if exists
    playerResults.add(PlayerResult(
      name: playerName,
      percentage: quiz.getScoreInPercentage(),
      points: quiz.getPoints()
    ));
  }

  void _showPlayerResults(String playerName) {
    print('\n$playerName, your score in percentage: ${quiz.getScoreInPercentage()}%');
    print('$playerName, your score in points: ${quiz.getPoints()}/${quiz.getMaxPoints()}');
    
    print('\nPlayers scores so far:');
    for (var result in playerResults) {
      print('Player: ${result.name}');
      print('Score: ${result.percentage}%\n');
    }
  }

  void _showFinalResults() {
    print('\n--- Quiz Finished ---');
    if (playerResults.isEmpty) {
      print('No players participated.');
      return;
    }
    
    print('Final Scores:');
    for (var result in playerResults) {
      print('Player: ${result.name}');
      print('Score: ${result.percentage}%\n');
    }
  }
}

class PlayerResult {
  final String name;
  final int percentage;
  final int points;

  PlayerResult({
    required this.name,
    required this.percentage,
    required this.points,
  });
}