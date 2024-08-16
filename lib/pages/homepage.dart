import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_odyssey/controllers/api_controller.dart';
import 'package:quiz_odyssey/pages/quiz_page.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    final apiController = Get.put(ApiController());
    apiController.fetchAllCategories();

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
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Choose difficulty!'),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Get.to(() => const QuizPage());
                      ac.fetchQuestions(
                          ac.categoryList[index].id.toString(), 'easy');
                    },
                    child: const Text('Easy')),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Get.to(() => const QuizPage());
                      ac.fetchQuestions(
                          ac.categoryList[index].id.toString(), 'medium');
                    },
                    child: const Text('Medium')),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Get.to(() => const QuizPage());
                      ac.fetchQuestions(
                          ac.categoryList[index].id.toString(), 'hard');
                    },
                    child: const Text('Hard'))
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Homepage'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (ac.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (ac.errMessage.isNotEmpty) {
          return Center(child: Text(ac.errMessage.value));
        } else {
          return ListView.separated(
            itemCount: ac.categoryList.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                  title: Text(ac.categoryList[index].categoryName),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 12,
                  ),
                  onTap: () => showDifficultyDialog(index));
            },
            separatorBuilder: (context, index) => const Divider(
              indent: 16,
              endIndent: 20,
            ),
          );
        }
      }),
    );
  }
}
