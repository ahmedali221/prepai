class Validators {
  static bool isValidEmail(String email) {
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return regex.hasMatch(email);
  }

  static bool isValidPassword(String password) {
    final regex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');
    return regex.hasMatch(password);
  }

  static bool isValidPhone(String phone) {
    final regex = RegExp(r'^\+?[0-9]{10,15}$');
    return regex.hasMatch(phone);
  }
}
