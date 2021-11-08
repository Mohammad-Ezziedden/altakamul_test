import 'package:dartz/dartz.dart';
import 'package:test/src/core/utils/error/failures.dart';
import 'package:test/src/core/utils/usecases/usecase.dart';
import 'package:test/src/domain/entities/question.dart';
import '../repositories/questions_repository.dart';

class GetQuestionDetails extends UseCase<Question, GetQuestionDetailsParams> {
  final QuestionsRepository repository;
  GetQuestionDetails(this.repository);

  @override
  Future<Either<Failure, Question>> call(
      GetQuestionDetailsParams params) async {
    return await repository.getQuestionDetails(params.questionId);
  }
}

class GetQuestionDetailsParams {
  final int questionId;

  GetQuestionDetailsParams(this.questionId);
}
