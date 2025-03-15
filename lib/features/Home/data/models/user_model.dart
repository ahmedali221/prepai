import 'package:prepai/features/Home/domain/entities/user_profile_entity.dart';

class UserModel extends UserProfileEntity {
  UserModel(
      {required super.userImage,
      required super.userImail,
      required super.userName,
      required super.userPassword,
      required super.userPhone});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userImage: json["userImage"] ?? "",
      userImail: json["userImail"] ?? "",
      userName: json["userName"] ?? "",
      userPassword: json["userPassword"] ?? "",
      userPhone: json["userPhone"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "userImage": userImage,
      "userImail": userImail,
      "userName": userName,
      "userPassword": userPassword,
      "userPhone": userPhone,
    };
  }
}
