class UserEntity {
  final String uid;
  final String name;
  final String email;
  final String phone;

  const UserEntity({
    required this.uid,
    required this.name,
    required this.email,
    required this.phone,
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'phone': phone,
    };
  }
}
