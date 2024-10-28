import 'package:flutter/foundation.dart';

class FormularioViewModel extends ChangeNotifier {
  String _nombre = '';
  String _departamento = '';
  String _descripcionProblema = '';
  String _prioridad = 'Media'; // Prioridad por defecto

  String get nombre => _nombre;
  String get departamento => _departamento;
  String get descripcionProblema => _descripcionProblema;
  String get prioridad => _prioridad;

  void setNombre(String nombre) {
    _nombre = nombre;
    notifyListeners();
  }

  void setDepartamento(String departamento) {
    _departamento = departamento;
    notifyListeners();
  }

  void setDescripcionProblema(String descripcion) {
    _descripcionProblema = descripcion;
    notifyListeners();
  }

  void setPrioridad(String prioridad) {
    _prioridad = prioridad;
    notifyListeners();
  }

  // Método para enviar la solicitud
  void enviarSolicitud() {
    // Aquí podrías agregar la lógica para enviar la solicitud a un servidor
    print(
        "Solicitud enviada:\nNombre: $_nombre\nDepartamento: $_departamento\nDescripción: $_descripcionProblema\nPrioridad: $_prioridad");
  }

  void limpiarFormulario() {
    _nombre = '';
    _departamento = '';
    _descripcionProblema = '';
    _prioridad = 'Media'; // Restablecemos a prioridad por defecto
    notifyListeners(); // Notificamos a los listeners para actualizar la UI
  }
}
