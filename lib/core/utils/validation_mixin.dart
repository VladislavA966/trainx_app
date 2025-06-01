mixin ValidationMixin {
  String? validateEmail(String? value) {
    final emailRegExp =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    } else if (!emailRegExp.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? validatePassword(String? value) {
    final passwordRegExp =
        RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#\$%\^&\*\(\)_\+\-=.]).{8,}$');

    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    } else if (!passwordRegExp.hasMatch(value)) {
      return 'Password must be at least 8 characters, with one letter, one number, and one special character';
    }
    return null;
  }

  String? validateConfirmPassword({String? password, String? confirmPassword}) {
    if (password != confirmPassword) {
      return 'Passwords do not match';
    }
    return null;
  }
}
