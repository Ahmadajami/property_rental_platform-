extension ExtString on String {
  static final _emailRegExp = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  static final _nameRegExp = RegExp(r'^[A-Za-z\s]+(?:[A-Za-z\s]+\.)?[A-Za-z\s]+$');
  static final _passwordRegExp = RegExp(r'.{8,}');
  static final _phoneRegExp = RegExp(r'^\+?([0-9]{2})?[0-9]{10}$');

  bool get isValidEmail => _emailRegExp.hasMatch(this);

  bool get isValidName => _nameRegExp.hasMatch(this);

  bool get isValidPassword => _passwordRegExp.hasMatch(this);

  bool get isValidPhone => _phoneRegExp.hasMatch(this);
}
extension ExtDate on DateTime {
  bool _validateDate(DateTime? date) {
    if (date == null) return false;
    return date.isAfter(DateTime.now());
  }
  bool get isValidDate => _validateDate(this);
}