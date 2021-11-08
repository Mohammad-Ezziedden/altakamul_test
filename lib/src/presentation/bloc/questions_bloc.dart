import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:test/src/core/utils/SimpleGenericBloc/generic_bloc.dart';
import 'package:test/src/core/utils/error/failures.dart';
import 'package:test/src/domain/entities/question.dart';
import 'package:test/src/domain/usecases/get_questions.dart';
import 'package:test/src/injections.dart';

class QuestionsBloc extends SimpleLoaderBloc<List<Question>> {
  int page = 0;

  QuestionsBloc() : super(eventParams: "");

  @override
  Future<Either<Failure, List<Question>>> load(SimpleBlocEvent event) async {
    if (event is LoadEvent) page = 0;
    page++;

    return GetQuestions(sl()).call(GetQuestionsParams(page));
  }
}
