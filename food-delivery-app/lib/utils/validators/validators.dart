

class TValidator {
  static String? validateEmail(String? value) {
    if(value == null || value.isEmpty) {
      return 'Email is required';
    }

    final emailRegExp = RegExp("");

    if(!emailRegExp.hasMatch(value)) {
      return 'Invalid email address';
    }
    return null;
  }

  static String? validatePassword(String? value) {

  }
}