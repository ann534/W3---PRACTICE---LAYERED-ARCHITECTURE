import 'domain/quiz.dart';
import 'ui/quiz_console.dart';
import 'data/quiz_file_provider.dart';

void main() async {
  try {
    final data = await loadJsonFromFile('lib/data/questions.json');
    final questionsList = data['questions'] as List;
    final questions = questionsList
        .map((q) => Question.fromJson(q as Map<String, dynamic>))
        .toList();

    if (questions.isEmpty) {
      print('No questions found in lib/data/questions.json');
      return;
    }
    
    Quiz quiz = Quiz(questions: questions);
    QuizConsole console = QuizConsole(quiz: quiz);
    console.startQuiz();
  } catch (e) {
    print('Error loading questions: $e');
  }
}