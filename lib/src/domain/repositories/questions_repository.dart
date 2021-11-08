import 'package:dartz/dartz.dart';
import 'package:test/src/core/utils/error/failures.dart';
import 'package:test/src/domain/entities/question.dart';

abstract class QuestionsRepository {
  Future<Either<Failure, List<Question>>> getQuestions(int page);
  Future<Either<Failure, Question>> getQuestionDetails(int questionId);
}
