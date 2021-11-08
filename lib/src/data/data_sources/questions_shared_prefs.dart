import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/src/domain/entities/question.dart';

class QuestionsSharedPrefs {
  final SharedPreferences _preferences;
  QuestionsSharedPrefs(this._preferences);

  Future<List<Question>?> getQuestions() async {
    final result = _preferences.getStringList("questions");
    if (result != null) {
      return Question.fromJsonList(result.map((e) => jsonDecode(e)).toList());
    }
    return null;
  }

  Future<void> saveQuestions(List<Question> questions) async {
  
    _preferences.setStringList(
        "questions", questions.map((e) => jsonEncode(e.toJson())).toList());
  }
}
