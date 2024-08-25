class ValidateService {
  static String? isEmptyField(String value) {
    if (value.isEmpty) {
      return 'Required';
    }
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    String? isEmpty = isEmptyField(value!);
    int len = value.length;

    if (isEmpty != null) {
      return isEmpty;
    } else if (len != 10) {
      return "Mobile Number must be of 10 digits";
    }
    return null;
  }

  static String? validateEmail(String? value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    String? isEmpty = isEmptyField(value!);

    if (isEmpty != null) {
      return isEmpty;
    } else if (!regExp.hasMatch(value)) {
      return "Invalid Email";
    }
    return null;
  }

  static String? validatePassword2(String password) {
    if (password.length < 8) {
      return 'Password must be at \nleast 8 characters long.';
    }
    if (!RegExp(r'(?=.*[A-Z])').hasMatch(password)) {
      return 'Password must contain at\nleast one uppercase letter.';
    }
    if (!RegExp(r'(?=.*[a-z])').hasMatch(password)) {
      return 'Password must contain at\nleast one lowercase letter.';
    }
    if (!RegExp(r'(?=.*\d)').hasMatch(password)) {
      return 'Password must contain at\nleast one digit.';
    }
    if (!RegExp(r'(?=.*[!@#$%^&*(),.?":{}|<>])').hasMatch(password)) {
      return 'Password must contain at\nleast one special character.';
    }
    return null; // Valid password
  }

  static String? validatePassword(String? value) {
    String? isEmpty = isEmptyField(value!);
    if (isEmpty != null) {
      return isEmpty;
    } else {
      return validatePassword2(value);
    }
  }
}
