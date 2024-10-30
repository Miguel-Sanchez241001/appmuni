import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterViewModel extends ChangeNotifier {
  String _firstName = '';
  String _lastName = '';
  String _phoneNumber = '';
  String _email = '';
  String _password = '';
  String _confirmPassword = '';
  bool _isLoading = false;
  bool _isShowPassword = false;
  bool _isShowConfirmPassword = false;
  String _errorMessage = '';

  bool get isLoading => _isLoading;
  bool get isShowPassword => _isShowPassword;
  bool get isShowConfirmPassword => _isShowConfirmPassword;
  String get errorMessage => _errorMessage;

  String get firstName => _firstName;
  String get lastName => _lastName;
  String get phoneNumber => _phoneNumber;
  String get email => _email;
  String get password => _password;
  String get confirmPassword => _confirmPassword;

  void setFirstName(String value) {
    _firstName = value;
    notifyListeners();
  }

  void setLastName(String value) {
    _lastName = value;
    notifyListeners();
  }

  void setPhoneNumber(String value) {
    _phoneNumber = value;
    notifyListeners();
  }

  void setEmail(String value) {
    _email = value;
    notifyListeners();
  }

  void setPassword(String value) {
    _password = value;
    notifyListeners();
  }

  void setConfirmPassword(String value) {
    _confirmPassword = value;
    notifyListeners();
  }

  void togglePasswordVisibility() {
    _isShowPassword = !_isShowPassword;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    _isShowConfirmPassword = !_isShowConfirmPassword;
    notifyListeners();
  }

  void setErrorMessage(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  bool isValidEmail(String email) {
    final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return regex.hasMatch(email);
  }

  bool isValidPhone(String phone) {
    final regex = RegExp(r'^9[0-9]{8}$');
    return regex.hasMatch(phone);
  }

  Future<void> register() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    _isLoading = false;
    notifyListeners();
  }

  Future<void> _saveUserToPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('firstName', _firstName);
    await prefs.setString('lastName', _lastName);
    await prefs.setString('phoneNumber', _phoneNumber);
    await prefs.setString('email', _email);
    await prefs.setString('password', _password);
  }

  void clearFields() {
    _firstName = '';
    _lastName = '';
    _phoneNumber = '';
    _email = '';
    _password = '';
    _confirmPassword = '';
    _errorMessage = '';
    notifyListeners();
  }
}
