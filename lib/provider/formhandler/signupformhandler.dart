class SignUpFormHandler {
  static String? fullNameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'please enter your name';
    }
    return null;
  }
 static String? discriptionValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'description cann\'t be empty';
    }
    if(value.length>2100){
       return 'description length cann\'t be more than 2100 characters';
    }
    return null;
  }

  static String? emailValidator(String? value) {
    if (value!.isEmpty) {
      return ' email can not be embty';
    }
    if (!value.contains('@')) {
      return 'please, enter valid email';
    }
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value!.isEmpty) {
      return "Password can't be  empty";
    }
    if (value.length < 4) {
      return 'password length must be at least 4';
    }
    if (value.length > 20) {
      return 'password length must not be greater than 20';
    }
    RegExp passwordRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{4,20}$');
    // RegExp regExp = new RegExp(pattern);
    if (!passwordRegex.hasMatch(value)) {
      return 'password must meet the requirements';
    }
    return null;
  }

  static String? termsAndAgreementsValidator(String? value) {
    return null;
  }

  static String? mobileNumberValidator(String? value) {
    if (value!.isEmpty) {
      return 'please enter your mobile number';
    }
    return null;
  }
}
