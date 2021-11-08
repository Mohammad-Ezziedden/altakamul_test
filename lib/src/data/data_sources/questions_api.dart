import 'package:dio/dio.dart';
import 'package:test/src/core/utils/error/exceptions.dart';
import 'package:test/src/core/utils/network/dio_error_handler.dart';
import 'package:test/src/domain/entities/question.dart';

import '../../injections.dart';

class QuestionsApi {
  Future<List<Question>> getQuestions(int page) async {
    try {
      return Question.fromJsonList((await sl<Dio>().get(
        "questions?page=$page&order=desc&sort=activity&filter=default&site=stackoverflow",
      ))
          .data['items']);
    } on DioError catch (e) {
      throw ServerException(handleDioError(e));
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  Future<Question> getQuestionDetails(int questionId) async {
    try {
      final result = Question.fromJsonList((await sl<Dio>().get(
        "questions/$questionId?order=desc&sort=activity&site=stackoverflow",
      ))
          .data['items']);

      return result.first;
    } on DioError catch (e) {
      throw ServerException(handleDioError(e));
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
