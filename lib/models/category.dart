import 'package:quiz_odyssey/utils/question_format.dart';

class Category {
  final int id;
  final String categoryName;

  Category({required this.id, required this.categoryName});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
        id: json['id'],
        categoryName: removeSubtitle(removeHTMLEntityCode(json['name'])));
  }
}
