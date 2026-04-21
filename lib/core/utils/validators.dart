class Validators {
  static String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Name is required";
    }
    if (value.length < 3) {
      return "Enter valid name";
    }
    return null;
  }

  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Email is required";
    }

    final emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+\-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );

    if (!emailRegex.hasMatch(value)) {
      return "Enter valid email";
    }

    return null;
  }

  static String? phoneValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Phone number required";
    }

    if (!value.startsWith('+')) {
      return "Phone must start with + country code";
    }

    final digits = value.substring(1);

    if (!RegExp(r'^[0-9]+$').hasMatch(digits)) {
      return "Phone must contain only numbers after +";
    }

    if (digits.length < 10 || digits.length > 15) {
      return "Enter valid international phone number";
    }

    return null;
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Password required";
    }

    if (value.length < 6) {
      return "Password must be at least 6 characters";
    }

    return null;
  }
}
