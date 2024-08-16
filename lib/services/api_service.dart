import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:quiz_odyssey/models/category.dart';

import '../models/question.dart';

const String BASE_URL = "https://opentdb.com/";

class ApiService {
  Dio dio = Dio();

  Future<Either<String, List<Category>>> fetchAllCategories() async {
    try {
      var response = await dio.get('${BASE_URL}api_category.php');
      var categoryList = response.data['trivia_categories']
          .map((json) => Category.fromJson(json))
          .toList();
      return right(List<Category>.from(categoryList));
    } on DioException catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, List<Question>>> fetchQuestions(
      String categoryId, String difficulty) async {
    try {
      var response = await dio.get(
          '${BASE_URL}api.php?amount=5&category=$categoryId&difficulty=$difficulty');
      var questionList = response.data['results']
          .map((json) => Question.fromJson(json))
          .toList();
      // print(questionList);
      if (response.data['response_code'] == 0) {
        return right(List<Question>.from(questionList));
      }
      throw response.data['response_code'];
    } on DioException catch (e) {
      print(e);
      return left(e.toString());
    } catch (e) {
      return left(e.toString());
    }
  }
}
