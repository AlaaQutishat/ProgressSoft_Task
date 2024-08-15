
bool isValidPassword(String? inputString, {bool isRequired = false}) {
  bool isInputStringValid = false;

  if ((inputString == null ? true : inputString.isEmpty) && !isRequired) {
    isInputStringValid = true;
  }

  if (inputString
  != null) {
    if (inputString.length
    < 8) return false;

    // Regular expression for complex password
    const pattern = r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$';

    final regExp = RegExp(pattern);

    isInputStringValid = regExp.hasMatch(inputString);
  }

  return isInputStringValid;
}

bool isValidEmail(String? inputString, {bool isRequired = false}) {
  bool isInputStringValid = false;

  if ((inputString == null ? true : inputString.isEmpty) && !isRequired) {
    isInputStringValid = true;
  }

  if (inputString != null) {
    const pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    final regExp = RegExp(pattern);

    isInputStringValid = regExp.hasMatch(inputString);
  }

  return isInputStringValid;
}

/// Checks if string is phone number

bool isValidPhone(String? inputString, {bool isRequired = false}) {
  bool isInputStringValid = false;

  if ((inputString == null ? true : inputString.isEmpty) && !isRequired) {
    isInputStringValid = true;
  }

  if (inputString != null) {
    if (inputString.length
    != 9) return false;

    const pattern = r"^(79|77|78)\d{7}$";

    final regExp = RegExp(pattern);

    isInputStringValid = regExp.hasMatch(inputString);
  }

  return isInputStringValid;
}

bool isText(String? inputString, {bool isRequired = false}) {
  bool isInputStringValid = false;

  if ((inputString == null ? true : inputString.isEmpty) && !isRequired) {
    isInputStringValid = false;
  }

  if (inputString!.isNotEmpty) {
    isInputStringValid = true;
  }

// if (inputString != null) {
//
// const pattern = r'^[a-zA-Z]+$';
//
// final regExp = RegExp(pattern);
//
// isInputStringValid = regExp.hasMatch(inputString) ;
//
// }

  return isInputStringValid;
}

bool isequaltext(String? inputString, String? inputString2) {
  bool isInputStringValid = false;

  if ((inputString == inputString2)) {
    isInputStringValid = true;
  }

  return isInputStringValid;
}

bool isValidFullName(String inputString ) {
  bool isInputStringValid = false;
  List<String> parts = inputString.trim().split(' ');

  if ( parts.length ==4) {
    isInputStringValid = true;
  }

  return isInputStringValid;
}

bool isValidVoucher(String inputString) {
  bool isInputStringValid = false;

  // Remove leading and trailing spaces, then check if the length is exactly 8
  String trimmedString = inputString.trim();
  if (trimmedString.length == 8) {
    // Use a regular expression to check if the string contains only letters and numbers
    RegExp regExp = RegExp(r'^[a-zA-Z0-9]+$');
    if (regExp.hasMatch(trimmedString)) {
      isInputStringValid = true;
    }
  }

  return isInputStringValid;
}