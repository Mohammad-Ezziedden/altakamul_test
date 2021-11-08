// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'owner.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Owner _$OwnerFromJson(Map<String, dynamic> json) {
  return Owner(
    accountId: json['account_id'] as int?,
    reputation: json['reputation'] as int?,
    userId: json['user_id'] as int?,
    userType: json['user_type'] as String?,
    profileImage: json['profile_image'] as String?,
    displayName: json['display_name'] as String?,
    link: json['link'] as String?,
  );
}

Map<String, dynamic> _$OwnerToJson(Owner instance) => <String, dynamic>{
      'account_id': instance.accountId,
      'reputation': instance.reputation,
      'user_id': instance.userId,
      'user_type': instance.userType,
      'profile_image': instance.profileImage,
      'display_name': instance.displayName,
      'link': instance.link,
    };
