import 'package:test/test.dart';
import '../lib/domain/quiz.dart';

void main() {
  late Question q1, q2;

  setUp(() {
    q1 = Question(
      title: 'Capital of France?',
      choices: ['Paris', 'London', 'Rome'],
      goodChoice: 'Paris',
      points: 10
    );
    q2 = Question(
      title: '2 + 2 = ?',
      choices: ['2', '4', '5'],
      goodChoice: '4',
      points: 50
    );
  });

  test('score is 100 when all answers correct', () {
    final quiz = Quiz(questions: [q1, q2]);
    quiz.addAnswer(Answer(question: q1, answerChoice: 'Paris'));
    quiz.addAnswer(Answer(question: q2, answerChoice: '4'));
    expect(quiz.getScoreInPercentage(), equals(100));
  });

  test('score is 50 when one answer correct', () {
    final quiz = Quiz(questions: [q1, q2]);
    quiz.addAnswer(Answer(question: q1, answerChoice: 'Paris'));
    quiz.addAnswer(Answer(question: q2, answerChoice: '5')); // wrong
    expect(quiz.getScoreInPercentage(), equals(50));
  });

  test('score is 0 when no answers correct', () {
    final quiz = Quiz(questions: [q1, q2]);
    quiz.addAnswer(Answer(question: q1, answerChoice: 'Rome'));
    quiz.addAnswer(Answer(question: q2, answerChoice: '2'));
    expect(quiz.getScoreInPercentage(), equals(0));
  });
}