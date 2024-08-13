// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) {

try{
  return UserModel(
      id: json['id'] as String,
      username: json['username'] as String,
      verified: json['verified'] as bool,
      emailVisibility: json['emailVisibility'] as bool,
      email: json['email'] as String,
      name: json['name'] as String,
      avatar: json['avatar'] as String?,
      gender: $enumDecode(_$GenderEnumMap, json['gender']),
    );
}
  catch(e){
    log("Errore happend in usermodel");
    return UserModel(
      id: json['id'] as String,
      username: json['username'] as String,
      verified: json['verified'] as bool,
      emailVisibility: json['emailVisibility'] as bool,
      email: json['email'] as String,
      name: json['name'] as String,
      avatar: json['avatar'] as String?,
      gender: $enumDecode(_$GenderEnumMap, json['gender']),
    );
  }
}

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'verified': instance.verified,
      'emailVisibility': instance.emailVisibility,
      'email': instance.email,
      'name': instance.name,
      'avatar': instance.avatar,
      'gender': _$GenderEnumMap[instance.gender]!,
    };

const _$GenderEnumMap = {
  Gender.male: 'male',
  Gender.female: 'female',
};
