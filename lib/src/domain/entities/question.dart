import 'package:json_annotation/json_annotation.dart';

import 'owner.dart';

part 'question.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Question {
  List<String>? tags;
  final Owner? owner;
  final bool? isAnswered;
  final int? viewCount;
  final int? acceptedAnswerId;
  final int? answerCount;
  final int? score;
  final int? lastActivityDate;
  final int? creationDate;
  final int? questionId;
  final String? contentLicense;
  final String? link;
  final String? title;

  Question(
      {this.tags,
      this.owner,
      this.isAnswered,
      this.viewCount,
      this.acceptedAnswerId,
      this.answerCount,
      this.score,
      this.lastActivityDate,
      this.creationDate,
      this.questionId,
      this.contentLicense,
      this.link,
      this.title});

  factory Question.fromJson(json) => _$QuestionFromJson(json);
  toJson() => _$QuestionToJson(this);

  static List<Question> fromJsonList(List json) {
    return json.map((e) => Question.fromJson(e)).toList();
  }
}
