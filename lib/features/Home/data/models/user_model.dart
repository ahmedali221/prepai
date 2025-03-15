import 'package:prepai/features/Home/domain/entities/user_profile_entity.dart';

class UserModel {
  final String userEmail;
  final String userName;
  final String userPhone;
  UserModel(
      {required this.userEmail,
      required this.userName,
      required this.userPhone});

  factory UserModel.fromJson(json) {
    return UserModel(
      userEmail: json["email"] ?? "",
      userName: json["name"] ?? "",
      userPhone: json["phone"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "email": userEmail,
      "name": userName,
      "phone": userPhone,
    };
  }

  UserProfileEntity toEntity() {
    return UserProfileEntity(
      userImage: "",
      userPassword: "",
      userName: userName,
      userEmail: userEmail,
      userPhone: userPhone,
    );
  }
}
