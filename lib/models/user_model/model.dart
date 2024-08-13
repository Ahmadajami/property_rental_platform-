import 'dart:developer';

import 'package:airbnb/core/constants/pocketbase_constants.dart';
import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';
@JsonEnum()
enum Gender { male,female }
@JsonSerializable()
class UserModel {
  final String id;
  final String username;
  final bool verified;
  final bool emailVisibility;
  final String email;
  final String name;

  final String? avatar;
  final Gender gender;

  UserModel({
    required this.id,
    required this.username,
    required this.verified,
    required this.emailVisibility,
    required this.email,
    required this.name,
    this.avatar,
    required this.gender,
  });

  UserModel copyWith({
    String? id,
    String? collectionId,
    String? collectionName,
    String? username,
    bool? verified,
    bool? emailVisibility,
    String? email,
    DateTime? created,
    DateTime? updated,
    String? name,
    String? avatar,
    Gender? gender,
  }) =>
      UserModel(
        id: id ?? this.id,
        username: username ?? this.username,
        verified: verified ?? this.verified,
        emailVisibility: emailVisibility ?? this.emailVisibility,
        email: email ?? this.email,
        name: name ?? this.name,
        avatar: avatar ?? this.avatar,
        gender: gender ?? this.gender,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
  String get _filePathUrl =>"api/files/${PocketBaseConstants.usersCollection}/$id";
  String? get avtarUrl  => avatar == null || avatar!.isEmpty ? null:'${PocketBaseConstants.apiUrl}/$_filePathUrl/$avatar';
}


