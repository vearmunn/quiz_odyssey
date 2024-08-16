import 'package:html_character_entities/html_character_entities.dart';

String removeHTMLEntityCode(String question) {
  return HtmlCharacterEntities.decode(question);
}

String removeSubtitle(String category) {
  return category.replaceAll("Entertainment: ", "").replaceAll("Science: ", "");
}
