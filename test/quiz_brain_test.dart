import 'package:flutter_test/flutter_test.dart';
import 'package:quizzler/quiz_brain.dart';

void main() {
  QuizBrain quizBrain;
  setUp(() {
    quizBrain = QuizBrain();
  });

  tearDown(() {
    quizBrain = null;
  });

  group('QuizBrain class', () {
    test('Quiz should have next question', () {
      expect(quizBrain.hasNextQuestion(), true);
    });

    test('Quiz should contain 12 questions and answers', () {
      for (int i = 0; i <= 11; i++) {
        expect(quizBrain.getQuestionText(), isA<String>());
        expect(quizBrain.getQuestionAnswer(), isA<bool>());
        quizBrain.nextQuestion();
      }
      expect(quizBrain.hasNextQuestion(), isFalse);
    });

    test('Quiz should be resettable', () {
      while (quizBrain.hasNextQuestion()) {
        quizBrain.nextQuestion();
      }
      expect(quizBrain.hasNextQuestion(), isFalse);
      quizBrain.reset();
      expect(quizBrain.hasNextQuestion(), isTrue);
    });
  });
}
