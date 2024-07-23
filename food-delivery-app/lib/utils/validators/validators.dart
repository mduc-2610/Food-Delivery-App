

class TValidator {
  static String? validateEmail(String? value) {
    if(value == null || value.isEmpty) {
      return 'Email is required';
    }

    final emailRegExp = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

    if(!emailRegExp.hasMatch(value)) {
      return 'Invalid email address';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    String pattern = r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#\$&*~]).{8,}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Password must be at least 8 characters long and include an uppercase letter, a lowercase letter, a number, and a special character';
    }
    return null;
  }

  static String? validateConfirmPassword(String? value, String value2) {
    if (value == null || value.isEmpty) {
      return 'Confirm password is required';
    }
    if (value != value2) {
      return 'Passwords do not match';
    }
    return null;
  }

  static String? validateTextField(String? value) {
    if(value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }
}