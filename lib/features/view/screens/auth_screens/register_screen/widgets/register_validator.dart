String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Email is required';
  } else if (!RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$').hasMatch(value)) {
    return 'Enter a valid Gmail address';
  }
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Password is required';
  } else if (value.length < 8) {
    return 'Password must be at least 8 characters';
  } else if (!RegExp(r'(?=.*[A-Z])').hasMatch(value)) {
    return 'Password must contain at least one uppercase letter';
  } else if (!RegExp(r'(?=.*\d)').hasMatch(value)) {
    return 'Password must contain at least one number';
  } else if (!RegExp(r'(?=.*[@$!%*?&])').hasMatch(value)) {
    return 'Password must contain at least one special character';
  }
  return null;
}
