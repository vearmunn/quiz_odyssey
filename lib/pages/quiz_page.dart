// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_odyssey/theme/colors.dart';

import 'package:quiz_odyssey/utils/question_format.dart';
import 'package:quiz_odyssey/utils/spacer.dart';
import 'package:quiz_odyssey/widgets/my_button.dart';

import '../controllers/api_controller.dart';
import '../utils/white_loading.dart';
import '../widgets/answer_tile.dart';
import 'result_page.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ac = Get.find<ApiController>();
    final pageController = PageController(initialPage: 0, keepPage: false);

    void changePage(int index) {
      pageController.animateToPage(index,
          duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
    }

    void showAlert(String message, String yesButtonText, VoidCallback onTap) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Warning'),
          content: Text(message),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel')),
            TextButton(onPressed: onTap, child: Text(yesButtonText)),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: navBarColor,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            showAlert("Are you sure you want to quit this quiz?", "Quit", () {
              Navigator.pop(context);
              Get.back();
            });
          },
        ),
        title: Obx(() => Column(
              children: [
                Text(
                  ac.isFetchQuestionLoading.value
                      ? '...'
                      : ac.fetchQuestionErrMessage.value.isNotEmpty
                          ? ""
                          : removeSubtitle(ac.questionList[0].category),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  ac.isFetchQuestionLoading.value
                      ? '...'
                      : ac.fetchQuestionErrMessage.value.isNotEmpty
                          ? ""
                          : ac.questionList[0].difficulty,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ],
            )),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(10.0),
          child: Container(),
        ),
      ),
      body: Obx(() {
        if (ac.isFetchQuestionLoading.value) {
          return whiteCircleLoading();
        } else if (ac.fetchQuestionErrMessage.isNotEmpty) {
          return Center(child: Text(ac.fetchQuestionErrMessage.value));
        } else {
          return Container(
            color: bgColor,
            child: PageView.builder(
              controller: pageController,
              itemBuilder: (context, questionIndex) => Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Question ${questionIndex + 1} of ${ac.questionList.length}",
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    verticalSpacer(16),
                    Text(
                      ac.questionList[questionIndex].question,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    verticalSpacer(20),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount:
                          ac.questionList[questionIndex].allAnswers.length,
                      itemBuilder: (BuildContext context, int answerIndex) {
                        return Obx(() {
                          var answer = ac.questionList[questionIndex]
                              .allAnswers[answerIndex];
                          var userAnswer = ac.userAnswers[questionIndex];
                          return AnswerTile(
                            answer: answer,
                            bgColor: userAnswer == answer
                                ? Colors.blue
                                : Colors.white,
                            onTap: () {
                              ac.saveUserAnswer(questionIndex, answer);

                              changePage(questionIndex + 1);
                            },
                          );
                        });
                      },
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Expanded(
                          child: MyButton(
                              bgColor: Colors.white,
                              textColor: Colors.black,
                              text: 'Previous',
                              onTap: () {
                                changePage(questionIndex - 1);
                              }),
                        ),
                        horizontalSpacer(16),
                        Obx(
                          () => Expanded(
                            child: MyButton(
                                text:
                                    questionIndex == ac.questionList.length - 1
                                        ? 'Finish'
                                        : 'Next',
                                onTap: () {
                                  if (questionIndex == 4) {
                                    showAlert(
                                        'Are you sure you want to finish this quiz?',
                                        "Finish", () {
                                      Get.offAll(() => const ResultPage());
                                    });
                                  } else {
                                    changePage(questionIndex + 1);
                                  }
                                }),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              itemCount: ac.questionList.length,
            ),
          );
        }
      }),
    );
  }
}
