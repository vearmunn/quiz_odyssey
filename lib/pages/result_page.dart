import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_odyssey/controllers/db_controller.dart';
import 'package:quiz_odyssey/pages/primary_page.dart';
import 'package:quiz_odyssey/theme/colors.dart';
import 'package:quiz_odyssey/utils/question_format.dart';
import 'package:quiz_odyssey/utils/spacer.dart';

import '../controllers/api_controller.dart';
import '../widgets/my_button.dart';
import 'result_detail_page.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  final confettiController = ConfettiController();

  @override
  void initState() {
    confettiController.play();
    super.initState();
  }

  @override
  void dispose() {
    confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ac = Get.find<ApiController>();
    final dbc = Get.find<DBController>();

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [bgColor, navBarColor, exodusFruit])),
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            ConfettiWidget(
              confettiController: confettiController,
              shouldLoop: false,
              blastDirectionality: BlastDirectionality.explosive,
              numberOfParticles: 5,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                verticalSpacer(20),
                SizedBox(
                    height: MediaQuery.of(context).size.height * 0.15,
                    child: Image.asset('assets/images/trophy.png')),
                verticalSpacer(20),
                const Text(
                  'Congratulations!\nYou have completed this quiz',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 28),
                ),
                verticalSpacer(20),
                Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(
                        text: 'You got',
                        style: const TextStyle(color: Colors.white),
                        children: [
                          TextSpan(
                              text:
                                  " ${ac.questionsAnsweredCorrectly.value}/5 ",
                              style: const TextStyle(color: Colors.green)),
                          const TextSpan(text: 'questions correct! in'),
                          TextSpan(
                            text:
                                ' ${removeSubtitle(ac.questionList[0].category)} category on ${ac.questionList[0].difficulty} difficulty',
                          ),
                        ])),
                verticalSpacer(30),
                Row(
                  children: [
                    Expanded(
                      child: MyButton(
                          bgColor: Colors.white,
                          textColor: exodusFruit,
                          text: 'Results Details',
                          onTap: () => Get.to(() => const ResultDetailPage())),
                    ),
                    horizontalSpacer(16),
                    Expanded(
                      child: MyButton(
                          text: 'Homepage',
                          bgColor: exodusFruit,
                          onTap: () {
                            Get.offAll(() => const PrimaryPage());
                            dbc.coins.value =
                                ac.questionsAnsweredCorrectly.value;
                            dbc.saveQuizRecord(ac.questionList[0].difficulty);
                            ac.questionsAnsweredCorrectly.value = 0;
                            ac.userAnswers.clear();
                          }),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
