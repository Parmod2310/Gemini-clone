class ValidationUtils {
  static String? validateInput(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field cannot be empty';
    }
    if (value.length < 2) {
      return 'Input must be at least 2 characters long';
    }
    return null;
  }
}