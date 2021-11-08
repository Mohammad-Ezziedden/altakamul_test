import 'package:dartz/dartz.dart';
import 'package:test/src/core/utils/error/failures.dart';
import 'package:test/src/core/utils/usecases/usecase.dart';
import 'package:test/src/domain/entities/question.dart';
import '../repositories/questions_repository.dart';

class GetQuestions extends UseCase<List<Question>, GetQuestionsParams> {
  final QuestionsRepository repository;
  GetQuestions(this.repository);

  @override
  Future<Either<Failure, List<Question>>> call(
      GetQuestionsParams params) async {
    return await repository.getQuestions(params.page);
  }
}

class GetQuestionsParams {
  final int page;
  GetQuestionsParams(this.page);
}
