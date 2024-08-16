import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_odyssey/pages/homepage.dart';
import 'package:quiz_odyssey/pages/quiz_page.dart';
import 'package:quiz_odyssey/utils/spacer.dart';
import 'package:quiz_odyssey/widgets/my_button.dart';

import '../controllers/api_controller.dart';

class ResultDetailPage extends StatelessWidget {
  const ResultDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ac = Get.find<ApiController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Results Details'),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey.shade300,
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
                      fontSize: 22, fontWeight: FontWeight.bold)),
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
                              : Colors.white,
                      onTap: () {});
                },
              ),
              // verticalSpacer(80),
              // MyButton(text: 'Homepage', onTap: ()=> Get.offAll(()=> const Homepage()))
            ],
          );
        },
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        height: 85,
        child: MyButton(
            text: 'Homepage',
            onTap: () {
              Get.offAll(() => const Homepage());
              ac.questionsAnsweredCorrectly.value = 0;
              ac.userAnswers.clear();
            }),
      ),
    );
  }
}
