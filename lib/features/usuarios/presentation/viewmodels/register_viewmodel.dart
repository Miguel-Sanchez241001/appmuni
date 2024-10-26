
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
  bool _isShowPassword = true;
  bool _isShowConfirmPassword = true;
  String _errorMessage = '';

  String get firstName => _firstName;
  String get lastName => _lastName;
  String get phoneNumber => _phoneNumber;
  String get email => _email;
  String get password => _password;
  String get confirmPassword => _confirmPassword;
  bool get isLoading => _isLoading;
  bool get isShowPassword => _isShowPassword;
  bool get isShowConfirmPassword => _isShowConfirmPassword;
  String get errorMessage => _errorMessage;

  void setFirstName(String firstName) {
    _firstName = firstName;
    notifyListeners();
  }

  void setLastName(String lastName) {
    _lastName = lastName;
    notifyListeners();
  }

  void setPhoneNumber(String phoneNumber) {
    _phoneNumber = phoneNumber;
    notifyListeners();
  }

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  void setConfirmPassword(String confirmPassword) {
    _confirmPassword = confirmPassword;
    notifyListeners();
  }

  void setIsShowPassword(bool isShowPassword) {
    _isShowPassword = isShowPassword;
    notifyListeners();
  }

  void setIsShowConfirmPassword(bool isShowConfirmPassword) {
    _isShowConfirmPassword = isShowConfirmPassword;
    notifyListeners();
  }

  // Método para registrar al usuario
  Future<void> register() async {
    if (_password != _confirmPassword) {
      _errorMessage = 'Las contraseñas no coinciden';
      notifyListeners();
      return;
    }

    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    await Future.delayed(Duration(seconds: 2)); // Simulamos un delay

    // Aquí podrías realizar una llamada a la API para registrar al usuario
    // Por ahora simulamos un registro exitoso y guardamos los datos en local
    await _saveUserToPreferences();

    _isLoading = false;
    notifyListeners();
  }

  // Guardar el estado del usuario en SharedPreferences
  Future<void> _saveUserToPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('firstName', _firstName);
    prefs.setString('lastName', _lastName);
    prefs.setString('phoneNumber', _phoneNumber);
    prefs.setString('email', _email);
    prefs.setString('password', _password);
  }

  // Cargar el estado del usuario desde SharedPreferences
  Future<void> loadUserFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _firstName = prefs.getString('firstName') ?? '';
    _lastName = prefs.getString('lastName') ?? '';
    _phoneNumber = prefs.getString('phoneNumber') ?? '';
    _email = prefs.getString('email') ?? '';
    _password = prefs.getString('password') ?? '';
    notifyListeners();
  }

  // Limpiar los datos de usuario almacenados
  Future<void> clearPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    notifyListeners();
  }
}
