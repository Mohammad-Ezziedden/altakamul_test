import 'package:json_annotation/json_annotation.dart';

part 'owner.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Owner {
  final int? accountId;
  final int? reputation;
  final int? userId;
  final String? userType;
  final String? profileImage;
  final String? displayName;
  final String? link;

  Owner(
      {this.accountId,
      this.reputation,
      this.userId,
      this.userType,
      this.profileImage,
      this.displayName,
      this.link});

  factory Owner.fromJson(json) => _$OwnerFromJson(json);
  toJson() => _$OwnerToJson(this);

  static List<Owner> fromJsonList(List json) {
    return json.map((e) => Owner.fromJson(e)).toList();
  }
}
