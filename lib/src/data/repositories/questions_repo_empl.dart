import 'package:dartz/dartz.dart';
import 'package:test/src/core/utils/connectivity/ConnectivityBloc/connectivity_bloc.dart';
import 'package:test/src/core/utils/error/exceptions.dart';
import 'package:test/src/core/utils/error/failures.dart';
import 'package:test/src/data/data_sources/questions_shared_prefs.dart';
import 'package:test/src/domain/entities/question.dart';
import 'package:test/src/injections.dart';
import '../../domain/repositories/questions_repository.dart';
import '../data_sources/questions_api.dart';

class QuestionsRepositoryImpl extends QuestionsRepository {
  final QuestionsApi questionsApi;
  final QuestionsSharedPrefs questionsSharedPrefs;
  QuestionsRepositoryImpl(this.questionsApi, this.questionsSharedPrefs);

  @override
  Future<Either<Failure, List<Question>>> getQuestions(int page) async {
    try {
      if (sl<ConnectivityHelper>().isConnected) {
        final result = await questionsApi.getQuestions(page);
        // cach just last page
        questionsSharedPrefs.saveQuestions(result);
        return Right(result);
      } else if (page == 1) {
        // internet problem not after first pagination then  return cached items
        final result = await questionsSharedPrefs.getQuestions();
        if (result != null) {
          return Right(result);
        }
      }
      return Left(ServerFailure("No Internet Connection"));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Question>> getQuestionDetails(int questionId) async {
    try {
      final result = await questionsApi.getQuestionDetails(questionId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
