import 'package:flutter/material.dart';

class SolicitudMantenimiento {
  final String nombreSolicitante;
  final String departamento;
  final String descripcion;
  final String prioridad;

  SolicitudMantenimiento({
    required this.nombreSolicitante,
    required this.departamento,
    required this.descripcion,
    required this.prioridad,
  });
}

class BusquedaMantenimientoViewModel extends ChangeNotifier {
  String _nombreBuscado = 'Seleccione';
  String _departamentoBuscado = '';
  String _marca = 'Seleccione';
  String _monitor = 'Seleccione';
  String _teclado = 'Seleccione';
  String _mouse = 'Seleccione';
  String _mousePuerto = 'Seleccione';
  String _tecladoPuerto = 'Seleccione';
  String _prioridadBuscada = 'Seleccione';
  String _numSerie = '';
  String _numSerieMonitor = '';
  String _numSerieTeclado = '';
  String _numSerieMouse = '';
  String _pulgadas = '';
  List<SolicitudMantenimiento> _resultadosBusqueda = [];
  List<SolicitudMantenimiento> _solicitudes = [];

  // Getters para obtener los valores actuales
  List<SolicitudMantenimiento> get resultadosBusqueda => _resultadosBusqueda;
  String get prioridadBuscada => _prioridadBuscada;
  String get marca => _marca;
  String get monitor => _monitor;
  String get teclado => _teclado;
  String get mouse => _mouse;
  String get mousePuerto => _mousePuerto;
  String get tecladoPuerto => _tecladoPuerto;
  String get numSerie => _numSerie;
  String get pulgadas => _pulgadas;
  String get numSerieMonitor => _numSerieMonitor;
  String get numSerieTeclado => _numSerieTeclado;
  String get numSerieMouse => _numSerieMouse;

  String get nombreBuscado => _nombreBuscado;
  // Métodos para actualizar los valores de los campos
  void setNombreBuscado(String nombre) {
    _nombreBuscado = nombre;
    notifyListeners();
  }

  void setDepartamentoBuscado(String departamento) {
    _departamentoBuscado = departamento;
    notifyListeners();
  }

  void setNumeroSerieCpu(String numSerie) {
    _numSerie = numSerie;
    notifyListeners();
  }

  void setNumeroSerieMonitor(String numSerie) {
    _numSerieMonitor = numSerie;
    notifyListeners();
  }

  void setNumeroSerieTeclado(String numSerie) {
    _numSerieTeclado = numSerie;
    notifyListeners();
  }

  void setNumeroSerieMouse(String numSerie) {
    _numSerieMouse = numSerie;
    notifyListeners();
  }

  void setPrioridadBuscada(String prioridad) {
    _prioridadBuscada = prioridad;
    notifyListeners();
  }

  void setMarcaCpu(String marca) {
    _marca = marca;
    notifyListeners();
  }

  void setMarcaTeclado(String teclado) {
    _teclado = teclado;
    notifyListeners();
  }

  void setPulgadasMonitor(String value) {
    _pulgadas = value;
    notifyListeners();
  }

  void setMarcaMonitor(String monitor) {
    _monitor = monitor;
    notifyListeners();
  }

  void setMouse(String mouse) {
    _mouse = mouse;
    notifyListeners();
  }

  void setMousePuerto(String mouse) {
    _mousePuerto = mouse;
    notifyListeners();
  }

  void setTecladoPuerto(String puerto) {
    _tecladoPuerto = puerto;
    notifyListeners();
  }

  /// Método para registrar una nueva solicitud
  void registrarSolicitud() {
    final nuevaSolicitud = SolicitudMantenimiento(
      nombreSolicitante: _nombreBuscado,
      departamento: _departamentoBuscado,
      descripcion: 'CPU: $_marca, Monitor: $_monitor, Teclado: $_teclado',
      prioridad: _prioridadBuscada,
    );

    _solicitudes.add(nuevaSolicitud);
    notifyListeners(); // Notifica cambios para actualizar la interfaz si es necesario
  }

  // Método opcional para resetear el formulario después del registro
  void resetBusqueda() {
    _nombreBuscado = 'Seleccione';
    _departamentoBuscado = '';
    _marca = 'Seleccione';
    _monitor = 'Seleccione';
    _teclado = 'Seleccione';
    _prioridadBuscada = 'Seleccione';
    _numSerie = '';
    _numSerieMonitor = '';
    _numSerieTeclado = '';
    notifyListeners();
  }
}
