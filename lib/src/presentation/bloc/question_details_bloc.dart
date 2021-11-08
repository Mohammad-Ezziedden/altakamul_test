import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:test/src/core/utils/SimpleGenericBloc/generic_bloc.dart';
import 'package:test/src/core/utils/error/failures.dart';
import 'package:test/src/domain/entities/question.dart';
import 'package:test/src/domain/usecases/get_question_details.dart';
import 'package:test/src/injections.dart';

class QuestionDetailsBloc extends SimpleLoaderBloc<Question> {
  final int questionId;
  QuestionDetailsBloc(this.questionId) : super(eventParams: "");

  @override
  Future<Either<Failure, Question>> load(SimpleBlocEvent event) async {
    return GetQuestionDetails(sl()).call(GetQuestionDetailsParams(questionId));
  }
}
