import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/api_controller.dart';
import '../widgets/my_button.dart';
import 'homepage.dart';
import 'result_detail_page.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ac = Get.find<ApiController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Results'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Text(
              "Questions answered correctly: ${ac.questionsAnsweredCorrectly.value}"),
          Row(
            children: [
              MyButton(
                  text: 'Results Details',
                  onTap: () => Get.to(() => const ResultDetailPage())),
              MyButton(
                  text: 'Homepage',
                  onTap: () {
                    Get.offAll(() => const Homepage());
                    ac.questionsAnsweredCorrectly.value = 0;
                    ac.userAnswers.clear();
                  }),
            ],
          )
        ],
      ),
    );
  }
}
