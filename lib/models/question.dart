import 'package:quiz_odyssey/utils/question_format.dart';

class Question {
  final String type;
  final String difficulty;
  final String category;
  final String question;
  final String correctAnswer;
  final List<dynamic> incorrectAnswers;
  final List<String> allAnswers;

  Question(
      {required this.type,
      required this.difficulty,
      required this.category,
      required this.question,
      required this.correctAnswer,
      required this.incorrectAnswers,
      required this.allAnswers});

  factory Question.fromJson(Map<String, dynamic> json) {
    // decode HTML entity code, for example: from &amp to &;
    var inCorrectAnswers = json['incorrect_answers']
        .map((answer) => removeHTMLEntityCode(answer))
        .toList();
    var correctAnswer = removeHTMLEntityCode(json['correct_answer']);

    // combining incorrect answers and correct answer into one list and then shuffle it
    List<String> answers = [];
    answers.addAll(List<String>.from(inCorrectAnswers));
    answers.add(correctAnswer);
    answers.shuffle();

    return Question(
        type: json['type'],
        difficulty: json['difficulty'],
        category: removeHTMLEntityCode(
          json['category'],
        ),
        question: removeHTMLEntityCode(json['question']),
        correctAnswer: correctAnswer,
        incorrectAnswers: inCorrectAnswers,
        allAnswers: answers);
  }
}
