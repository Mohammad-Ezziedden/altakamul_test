import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/src/core/utils/SimpleGenericBloc/generic_bloc.dart';
import 'package:test/src/domain/entities/question.dart';
import 'package:test/src/presentation/bloc/questions_bloc.dart';
import 'package:test/src/presentation/pages/question_details.dart';

class QuestionsPage extends StatefulWidget {
  const QuestionsPage({Key? key}) : super(key: key);

  @override
  _QuestionsPageState createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  final QuestionsBloc questionsBloc = QuestionsBloc();
  @override
  void initState() {
    questionsBloc.add(LoadEvent(""));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Questions",
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder(
                bloc: questionsBloc,
                builder: (context, state) {
                  if (state is LoadingState) {
                    return SizedBox(
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [CircularProgressIndicator()],
                      ),
                    );
                  }
                  if (state is ErrorState) {
                    return Text(state.error);
                  }
                  if (state is SuccessState<List<Question>>) {
                    return ListView.builder(
                        controller: questionsBloc.scrollController,
                        itemCount: state.hasReachedMax
                            ? state.items.length
                            : state.items.length + 1,
                        itemBuilder: (context, index) {
                          if (index >= state.items.length) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                CircularProgressIndicator(),
                              ],
                            );
                          }
                          final question = state.items[index];
                          return ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => QuestionDetailsPage(
                                          questionId:
                                              question.questionId ?? 1)));
                            },
                            title: Text(
                              question.title ?? "",
                              style:
                                  const TextStyle(fontWeight: FontWeight.w500),
                            ),
                            leading: CircleAvatar(
                              onBackgroundImageError: (obj, trace) {},
                              backgroundImage: NetworkImage(
                                  question.owner?.profileImage ?? ""),
                            ),
                            subtitle: Text(
                                "Answers: " + question.answerCount.toString()),
                          );
                        });
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ));
  }
}
