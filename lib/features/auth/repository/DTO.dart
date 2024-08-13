
import 'package:airbnb/models/user_model/model.dart';
import 'package:pocketbase/pocketbase.dart';

class UserMapper{
  static UserModel userFromAuthStore(RecordModel model){
    final UserModel x =UserModel.fromJson(model.toJson());
    return x;
  }
}

class UserModelDto {
  final String token;
  final UserModel record;

  UserModelDto({
    required this.token,
    required this.record,
  });

  UserModelDto copyWith({
    String? token,
    UserModel? record,
  }) =>
      UserModelDto(
        token: token ?? this.token,
        record: record ?? this.record,
      );

  factory UserModelDto.fromJson(Map<String, dynamic> json) => UserModelDto(
    token: json["token"],
    record: UserModel.fromJson(json["record"]),
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "record": record.toJson(),
  };
}





