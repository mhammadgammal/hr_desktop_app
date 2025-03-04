abstract class Validators {
  static String? validateEmail(String? value) {
    if (value != null && value.isEmpty) {
      return 'Email is required';
    }
    // if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
    //   return 'Please enter a valid email';
    // }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value != null && value.isEmpty) {
      return 'Password is required';
    }

    if (value != null && value.length < 8) {
      return 'Password must be at least 8 characters';
    }

    return null;
  }
}
