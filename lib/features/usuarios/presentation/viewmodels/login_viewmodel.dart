import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Modelo del Usuario
class User {
  final String email;
  final String role;

  User({required this.email, required this.role});
}

class LoginViewModel extends ChangeNotifier {
  String _email = '';
  String _password = '';
  bool _isLoading = false;
  bool _isShowPassword = true;
  String _errorMessage = '';
  User? _loggedInUser;

  // Usuarios simulados con sus roles
  final List<User> _users = [
    User(email: 'admin@admin.com', role: 'Admin'),
    User(email: 'user@user.com', role: 'User'),
    User(email: 'guest@guest.com', role: 'Guest'),
  ];

  String get email => _email;
  String get password => _password;
  bool get isLoading => _isLoading;
  bool get isShowPassword => _isShowPassword;
  String get errorMessage => _errorMessage;
  User? get loggedInUser => _loggedInUser; // Usuario actual autenticado

  LoginViewModel() {
    _loadUserFromPreferences(); // Intentamos cargar sesión almacenada al inicio
  }

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  void setIsShowPassword(bool isShowPassword) {
    _isShowPassword = isShowPassword;
    notifyListeners();
  }

  // Método para iniciar sesión
  Future<void> login() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2)); // Simulamos un delay

    final user = _users.firstWhere(
          (user) => user.email == _email && _password == "1234",
      orElse: () => User(email: '', role: ''),
    );

    if (user.email.isNotEmpty) {
      _errorMessage = '';
      _loggedInUser = user;
      _saveUserToPreferences(user); // Guardamos la sesión
    } else {
      _errorMessage = 'Credenciales incorrectas';
    }

    _isLoading = false;
    notifyListeners();
  }

  // Método para cerrar sesión
  void logout() {
    _loggedInUser = null;
    _email = '';
    _password = '';
    _errorMessage = '';
    _clearPreferences(); // Limpiamos la sesión guardada
    notifyListeners();
  }

  // Guardar el estado del usuario en SharedPreferences
  Future<void> _saveUserToPreferences(User user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('email', user.email);
    prefs.setString('role', user.role);
  }

  // Cargar el estado del usuario desde SharedPreferences
  Future<void> _loadUserFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email');
    final role = prefs.getString('role');

    if (email != null && role != null) {
      _loggedInUser = User(email: email, role: role);
      notifyListeners(); // Notificamos que la sesión ha sido restaurada
    }
  }

  // Limpiar los datos de sesión almacenados
  Future<void> _clearPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
