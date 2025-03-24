class UserProfileEntity {
  final String userImage;
  final String userEmail;
  final String userName;
  final String userPassword;
  final String userPhone;

  UserProfileEntity(
      {required this.userImage,
      required this.userEmail,
      required this.userName,
      required this.userPassword,
      required this.userPhone});
}
