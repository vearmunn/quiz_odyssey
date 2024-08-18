import 'package:get/get.dart';
import 'package:quiz_odyssey/controllers/db_controller.dart';
import 'package:quiz_odyssey/services/api_service.dart';

import '../models/category.dart';
import '../models/question.dart';

class ApiController extends GetxController {
  var isLoading = false.obs;
  var errMessage = ''.obs;

  var isFetchQuestionLoading = false.obs;
  var fetchQuestionErrMessage = ''.obs;

  RxList<Question> questionList = <Question>[].obs;
  RxList<Category> categoryList = <Category>[].obs;
  RxMap<int, String> userAnswers = <int, String>{}.obs;

  var questionsAnsweredCorrectly = 0.obs;

  final apiService = ApiService();
  final dbController = DBController();

  Future fetchAllCategories() async {
    isLoading.value = true;

    // fetch all categories
    final res = await apiService.fetchAllCategories();

    // if error, append error to errMessage, else, append result to categoryList
    res.fold((l) => errMessage.value = l, (r) => categoryList.value = r);

    // sort category list alphabetically
    categoryList.sort(
      (a, b) => a.categoryName.compareTo(b.categoryName),
    );

    isLoading.value = false;
  }

  Future fetchQuestions(String categoryId, String difficulty) async {
    isFetchQuestionLoading.value = true;
    final res = await apiService.fetchQuestions(categoryId, difficulty);
    res.fold((l) => fetchQuestionErrMessage.value = l,
        (r) => questionList.value = r);
    // print(errMessage.value);
    // print(questionList[0].allAnswers);
    isFetchQuestionLoading.value = false;
  }

  void saveUserAnswer(int questionIndex, String answer) {
    // save user answer to a map
    userAnswers[questionIndex] = answer;

    // loop through user's answers map and count the questions answered correctly
    int answeredCorrectly = 0;
    userAnswers.forEach((questionIndex, answer) {
      if (answer == questionList[questionIndex].correctAnswer) {
        answeredCorrectly += 1;
      }
    });
    questionsAnsweredCorrectly.value = answeredCorrectly;

    print("Answered correctly : $questionsAnsweredCorrectly");
    // print(userAnswers);
  }
}
