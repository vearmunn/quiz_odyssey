import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_odyssey/controllers/db_controller.dart';

import 'package:quiz_odyssey/pages/primary_page.dart';
import 'package:quiz_odyssey/theme/colors.dart';
import 'package:quiz_odyssey/utils/spacer.dart';
import 'package:quiz_odyssey/widgets/my_button.dart';

import '../controllers/api_controller.dart';
import '../widgets/answer_tile.dart';

class ResultDetailPage extends StatelessWidget {
  const ResultDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ac = Get.find<ApiController>();
    final dbc = Get.find<DBController>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: navBarColor,
        title: const Text(
          'Results Details',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      backgroundColor: bgColor,
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
        separatorBuilder: (context, index) => const Divider(
          height: 30,
        ),
        itemCount: ac.questionList.length,
        itemBuilder: (BuildContext context, int questionIndex) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpacer(8),
              Text(ac.questionList[questionIndex].question,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  )),
              verticalSpacer(16),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: ac.questionList[questionIndex].allAnswers.length,
                itemBuilder: (BuildContext context, int answerIndex) {
                  var answer =
                      ac.questionList[questionIndex].allAnswers[answerIndex];
                  var userAnswer = ac.userAnswers[questionIndex];
                  var correctAnswer =
                      ac.questionList[questionIndex].correctAnswer;
                  return AnswerTile(
                      answer: answer,
                      bgColor: answer == correctAnswer
                          ? Colors.green
                          : answer == userAnswer && answer != correctAnswer
                              ? Colors.red
                              : Colors.grey.shade300,
                      useTrailing: answer == correctAnswer,
                      onTap: () {});
                },
              ),
            ],
          );
        },
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(16),
        color: navBarColor,
        height: 85,
        child: MyButton(
            text: 'Homepage',
            onTap: () {
              Get.offAll(() => const PrimaryPage());
              dbc.coins.value = ac.questionsAnsweredCorrectly.value;
              dbc.saveQuizRecord(ac.questionList[0].difficulty);
              ac.questionsAnsweredCorrectly.value = 0;
              ac.userAnswers.clear();
            }),
      ),
    );
  }
}
