// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Question _$QuestionFromJson(Map<String, dynamic> json) {
  return Question(
    tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
    owner: json['owner'] == null ? null : Owner.fromJson(json['owner']),
    isAnswered: json['is_answered'] as bool?,
    viewCount: json['view_count'] as int?,
    acceptedAnswerId: json['accepted_answer_id'] as int?,
    answerCount: json['answer_count'] as int?,
    score: json['score'] as int?,
    lastActivityDate: json['last_activity_date'] as int?,
    creationDate: json['creation_date'] as int?,
    questionId: json['question_id'] as int?,
    contentLicense: json['content_license'] as String?,
    link: json['link'] as String?,
    title: json['title'] as String?,
  );
}

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
      'tags': instance.tags,
      'owner': instance.owner?.toJson(),
      'is_answered': instance.isAnswered,
      'view_count': instance.viewCount,
      'accepted_answer_id': instance.acceptedAnswerId,
      'answer_count': instance.answerCount,
      'score': instance.score,
      'last_activity_date': instance.lastActivityDate,
      'creation_date': instance.creationDate,
      'question_id': instance.questionId,
      'content_license': instance.contentLicense,
      'link': instance.link,
      'title': instance.title,
    };
