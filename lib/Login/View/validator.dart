class Validator {
  static String? valueExists(dynamic value) {
    if (value == null || value.isEmpty) {
      return "Please fill this field";
    } else {
      return null;
    }
  }

  static String? passwordCorrect(dynamic value) {
    var emptyResult = valueExists(value);
    if (emptyResult == null || emptyResult.isEmpty) {
      var pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[#?!@$%^&*-]).{8,}$';
      var regExp = RegExp(pattern);
      if (!regExp.hasMatch(value)) {
        return 'Password must contain at least 8 characters,\nupper/lowercase, numbers and special characters';
      } else {
        return null;
      }
    } else {
      return emptyResult;
    }
  }

  static String? validatePhoneNumber(dynamic value) {
    var pattern =r'(^(?:[+0]9)?[0-9]{10,12}$)';
       // r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    var regExp = RegExp(pattern);
    var emptyResult = valueExists(value);
    if (emptyResult != null) {
      return emptyResult;
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    } else {
      return null;
    }
  }
}
