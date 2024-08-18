import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_odyssey/controllers/api_controller.dart';
import 'package:quiz_odyssey/pages/quiz_page.dart';
import 'package:quiz_odyssey/theme/colors.dart';
import 'package:quiz_odyssey/theme/images.dart';
import 'package:quiz_odyssey/utils/spacer.dart';
import 'package:quiz_odyssey/utils/white_loading.dart';
import 'package:quiz_odyssey/widgets/category_tile.dart';
import 'package:quiz_odyssey/widgets/my_button.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ac = Get.find<ApiController>();

    void showDifficultyDialog(int index) {
      showDialog(
        context: context,
        builder: (context) => Dialog(
          child: Container(
            decoration: BoxDecoration(
                color: navBarColor, borderRadius: BorderRadius.circular(15)),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                        ))),
                const Text(
                  'Select difficulty!',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                verticalSpacer(28),
                MyButton(
                    text: 'Easy',
                    bgColor: emerald,
                    onTap: () {
                      Navigator.pop(context);
                      Get.to(() => const QuizPage());
                      ac.fetchQuestions(
                          ac.categoryList[index].id.toString(), 'easy');
                    }),
                verticalSpacer(20),
                MyButton(
                    text: 'Medium',
                    bgColor: orange,
                    onTap: () {
                      Navigator.pop(context);
                      Get.to(() => const QuizPage());
                      ac.fetchQuestions(
                          ac.categoryList[index].id.toString(), 'medium');
                    }),
                verticalSpacer(20),
                MyButton(
                    text: 'Hard',
                    bgColor: chiGong,
                    onTap: () {
                      Navigator.pop(context);
                      Get.to(() => const QuizPage());
                      ac.fetchQuestions(
                          ac.categoryList[index].id.toString(), 'hard');
                    }),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'Choose Category!',
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            verticalSpacer(8),
            const Text(
              'Pick the Category That Interests You Most and Dive Into the Quiz Odyssey!',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            verticalSpacer(20),
            Obx(() {
              if (ac.isLoading.value) {
                return whiteCircleLoading();
              } else if (ac.errMessage.isNotEmpty) {
                return Center(child: Text(ac.errMessage.value));
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: ac.categoryList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CategoryTile(
                        bgColor: categoryColors[index],
                        name: ac.categoryList[index].categoryName,
                        urlImage: categoryImages[index],
                        onTap: () => showDifficultyDialog(index));
                  },
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
