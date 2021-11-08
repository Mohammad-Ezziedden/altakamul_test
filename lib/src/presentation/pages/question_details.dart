import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/src/core/utils/SimpleGenericBloc/generic_bloc.dart';
import 'package:test/src/domain/entities/question.dart';
import 'package:test/src/presentation/bloc/question_details_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class QuestionDetailsPage extends StatefulWidget {
  const QuestionDetailsPage({Key? key, required this.questionId})
      : super(key: key);
  final int questionId;
  @override
  _QuestionDetailsPageState createState() => _QuestionDetailsPageState();
}

class _QuestionDetailsPageState extends State<QuestionDetailsPage> {
  late final QuestionDetailsBloc bloc;

  @override
  void initState() {
    bloc = QuestionDetailsBloc(widget.questionId);
    bloc.add(LoadEvent(""));
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Question Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder(
          bloc: bloc,
          builder: (context, state) {
            if (state is LoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is ErrorState) {
              return Center(
                child: Text(state.error),
              );
            }
            if (state is SuccessState<Question>) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage:
                            NetworkImage(state.items.owner?.profileImage ?? ""),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(state.items.owner?.displayName ?? "")
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Text(
                    state.items.title ?? "",
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Text("tags: " +
                      (state.items.tags
                              ?.reduce((value, element) => value + ", ") ??
                          "")),
                  const SizedBox(
                    height: 25,
                  ),
                  Text(
                    "is Answered: " + state.items.isAnswered.toString(),
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    "acceptedAnswerId: " +
                        state.items.acceptedAnswerId.toString(),
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    "view Count: " + state.items.viewCount.toString(),
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    "content License: " + state.items.contentLicense.toString(),
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: () async {
                      if (await canLaunch(state.items.link.toString())) {
                        launch(state.items.link.toString());
                      }
                    },
                    child: Text(
                      "link: " + state.items.link.toString(),
                      style: const TextStyle(
                          fontSize: 16, decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
