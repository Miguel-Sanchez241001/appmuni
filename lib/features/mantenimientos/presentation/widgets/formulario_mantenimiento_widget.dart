import 'package:appmuni/features/mantenimientos/presentation/viewmodels/busquedasolicitudes_viewmodel.dart';
import 'package:appmuni/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BusquedaMantenimientoWidget extends StatefulWidget {
  const BusquedaMantenimientoWidget({super.key});

  @override
  _BusquedaMantenimientoWidgetState createState() =>
      _BusquedaMantenimientoWidgetState();
}

class _BusquedaMantenimientoWidgetState
    extends State<BusquedaMantenimientoWidget> {
  final _nombreController = TextEditingController();
  final _departamentoController = TextEditingController();
  final _numeroSerieCpuController = TextEditingController();
  final _numeroSerieMonitorController = TextEditingController();
  final _numeroSerieTecladoController = TextEditingController();
  final _numeroSerieMouseController = TextEditingController();
  final _numeroPulgadasController = TextEditingController();

  @override
  void dispose() {
    _nombreController.dispose();
    _departamentoController.dispose();
    _numeroSerieCpuController.dispose();
    _numeroSerieMonitorController.dispose();
    _numeroSerieTecladoController.dispose();
    _numeroSerieMouseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<BusquedaMantenimientoViewModel>(context);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Column(
            children: [
              Text(
                'Registro de mantenimiento',
                style: TextStyle(
                    fontSize: 20,
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              _buildDropdown(
                label: 'Nombre del Área',
                items: [
                  'Seleccione',
                  'SUB GERENCIA DE PROGRAMAS SOCIALES Y SALUD',
                  'GERENCIA DE ADMINISTRACION TRIBUTARIA',
                  'SUB GERENCIA DE TESORERIA',
                  'PROCURADORIA PUBLICA MUNICIPAL',
                  'SUB GERENCIA DE REGISTRO CIVIL',
                  'GERENCIA DE DESARROLLO E INCLUSION SOCIAL',
                  'SUB GERENCIA DE LOGISTICA Y ABASTECIMIENTO-ALMACEN',
                  'SUBGERENCIA DE EJECUCION COACTIVA',
                  'SUB GERENCIA DE TESORERIA',
                  'SUB GERENCIA DE LOGISTICA Y ABASTECIMIENTO',
                  'GERENCIA DE ADMINISTRACION Y FINANZAS',
                  'SUB GERENCIA DE RECURSOS HUMANOS',
                  'GERENCIA DE PLANEAMIENTO Y PRESUPUESTO',
                  'SUB GERENCIA DE CONTABILIDAD',
                  'ASESORIA JURIDICA',
                  'GERENCIA DE DESARROLLO URBANO Y RURAL',
                  'SUB GERENCIA DE OBRAS PUBLICAS, TRANSPORTE Y SEGURIDAD VIAL',
                  'SUB GERENCIA DE DEFENSA CIVIL',
                  'SUB GERENCIA DE FISCALIZACION TRIBUTARIA',
                  'GERENCIA DE ADMINISTRACION TRIBUTARIA - PLATAFORMA',
                  'SUB GERENCIA DE TRAMITE DOCUMENTARIO',
                  'GERENCIA MUNICIPAL',
                  'SUB GERENCIA DE COMUNICACION Y IMAGEN',
                  'SECRETARIA GENERAL',
                  'GERENCIA DE SERVICIOS PUBLICOS',
                  'SUB GERENCIA DE FOMENTO DE LA INVERSION Y PROMOCION EMPRESARIAL',
                  'SUB GERENCIA DEL AREA TECNICA MUNICIPAL',
                  'SUB GERENCIA DE INFORMATICA Y ESTADISTICA',
                  'SUB GERENCIA DE DEMUNA, OMAPED Y CIAM',
                  'SUBGERENCIA DE SEGURIDAD CIUDADANA SERENAZGO',
                  'SUBGERENCIA DE EDUCACION, CULTURA, DEPORTE Y JUVENTUD',
                  'SUB GERENCIA DE PARTICIPACION VECINAL',
                  'SUB GERENCIA DE EMPADRONAMIENTO LOCAL DE SISFOH',
                  'SUB GERENCIA DE FISCALIZACION ADMINISTRATIVAS Y POLICIA MUNICIPAL',
                  'GERENCIA DE DESARROLLO ECONOMICO LOCAL',
                  'SUB GERENCIA DE LIMPIEZA PUBLICA Y ORNATO',
                  'SUB GERENCIA DE GESTION AMBIENTAL',
                  'SUB GERENCIA DE AREAS VERDES',
                  'SUBGERENCIA DE TURISMO',
                  'SUB GERENCIA DE RECURSOS HUMANOS',
                ],
                value: viewModel.nombreBuscado,
                onChanged: (value) => viewModel.setNombreBuscado(value!),
              ),
              _buildTextField(
                label: 'Sede',
                controller: _departamentoController,
                onChanged: (value) => viewModel.setDepartamentoBuscado(value),
              ),
              _buildDropdown(
                label: 'Marca - Modelo (CPU)',
                items: [
                  'Seleccione',
                  'VASTEC COMMANDER G8',
                  'HP ELITEDESK 600 G1',
                  'HP ELITEDESK 800 G1',
                  'HP PRODESK 400 G5',
                  'HP PRODESK 400 G6',
                  'HP PRODESK 400 G7',
                  'HP PRODESK 600 G4',
                  'HP PRODESK 600 G5',
                  'ANTRYX',
                  'RHINOBOX KEROS SFF 5010',
                  'ADVANCE VO1087',
                ],
                value: viewModel.marca,
                onChanged: (value) => viewModel.setMarcaCpu(value!),
              ),
              _buildTextField(
                label: 'Número de serie (CPU)',
                controller: _numeroSerieCpuController,
                onChanged: (value) => viewModel.setNumeroSerieCpu(value),
              ),
              const SizedBox(height: 10),
              _buildDropdown(
                label: 'Monitor (MARCA - MODELO)',
                items: [
                  'Seleccione',
                  'ADVANCE ADV-5023N',
                  'DELL E2216H',
                  'HP E233',
                  'LG 22MK600M',
                  'LG 24MK430H',
                  'LG 20M45A-B',
                  'LG 22MK430H-B',
                  'LG 22MK400H-B',
                  'SAMSUNG SR4C310EAL',
                  'SAMSUNG S24R35AFHN',
                  'SAMSUNG S22A33ANHL',
                  'SAMSUNG S20D300GNA',
                  'TEROS TE-3130',
                  'TEROS TE-24FHD8',
                ],
                value: viewModel.monitor,
                onChanged: (value) => viewModel.setMarcaMonitor(value!),
              ),
              _buildTextField(
                label: 'Pulgadas (Monitor)',
                controller: _numeroPulgadasController,
                onChanged: (value) => viewModel.setPulgadasMonitor(value),
              ),
              _buildTextField(
                label: 'Número de serie (Monitor)',
                controller: _numeroSerieMonitorController,
                onChanged: (value) => viewModel.setNumeroSerieMonitor(value),
              ),
              const SizedBox(height: 10),
              _buildDropdown(
                label: 'Teclado (MARCA)',
                items: [
                  'Seleccione',
                  'LOGITECH',
                  'HP',
                  'GENIUS',
                  'MICROSOFT',
                  'COMPAQ',
                  'BENQ',
                  'HALION',
                  'DELL',
                  'XTECH',
                  'MAXELL',
                  'SEISA',
                  'MICRONICS',
                ],
                value: viewModel.teclado,
                onChanged: (value) => viewModel.setMarcaTeclado(value!),
              ),
              _buildDropdown(
                label: 'Teclado (PUERTO)',
                items: [
                  'Seleccione',
                  'USB',
                  'PS2',
                ],
                value: viewModel.tecladoPuerto,
                onChanged: (value) => viewModel.setTecladoPuerto(value!),
              ),
              _buildTextField(
                label: 'Modelo - Serie (Teclado)',
                controller: _numeroSerieTecladoController,
                onChanged: (value) => viewModel.setNumeroSerieTeclado(value),
              ),
              _buildDropdown(
                label: 'Mouse (MARCA)',
                items: [
                  'Seleccione',
                  'LOGITECH',
                  'HP',
                  'DELL',
                  'MICROSOFT',
                  'GENIUS',
                  'GENERICO',
                  'ADVANCE',
                ],
                value: viewModel.mouse,
                onChanged: (value) => viewModel.setMouse(value!),
              ),
              _buildDropdown(
                label: 'Mouse (PUERTO)',
                items: [
                  'Seleccione',
                  'USB',
                  'PS2',
                ],
                value: viewModel.mousePuerto,
                onChanged: (value) => viewModel.setMousePuerto(value!),
              ),
              _buildTextField(
                label: 'Modelo - Serie (Mouse)',
                controller: _numeroSerieMouseController,
                onChanged: (value) => viewModel.setNumeroSerieMouse(value),
              ),
              _buildDropdown(
                label: 'Prioridad',
                items: ['Seleccione', 'Alta', 'Media', 'Baja'],
                value: viewModel.prioridadBuscada,
                onChanged: (value) => viewModel.setPrioridadBuscada(value!),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_validarCampos(viewModel)) {
                    _mostrarConfirmacion(context, viewModel);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Por favor, complete todos los campos.',
                            style: TextStyle(color: AppColors.primary)),
                        backgroundColor: AppColors.white,
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  'Registrar',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required ValueChanged<String> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: AppColors.primary),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.primary),
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required List<String> items,
    required String value,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: AppColors.primary)),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.primary),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButton<String>(
            value: value,
            isExpanded: true,
            underline: Container(),
            items: items.map((item) {
              return DropdownMenuItem(
                value: item,
                child: Text(item),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  bool _validarCampos(BusquedaMantenimientoViewModel viewModel) {
    return _nombreController.text.isNotEmpty &&
        _departamentoController.text.isNotEmpty &&
        viewModel.marca != 'Seleccione' &&
        _numeroSerieCpuController.text.isNotEmpty &&
        viewModel.monitor != 'Seleccione' &&
        _numeroSerieMonitorController.text.isNotEmpty &&
        viewModel.teclado != 'Seleccione' &&
        _numeroSerieTecladoController.text.isNotEmpty &&
        viewModel.prioridadBuscada != 'Seleccione';
  }

  void _mostrarConfirmacion(
      BuildContext context, BusquedaMantenimientoViewModel viewModel) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text(
            'Confirmar Registro',
            style: TextStyle(color: AppColors.primary),
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Revise los datos del mantenimiento antes de confirmar:',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 250, // Ajusta la altura según tus necesidades
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      ListTile(
                        title: const Text('Nombre del Área',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(_nombreController.text),
                      ),
                      ListTile(
                        title: const Text('Sede',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(_departamentoController.text),
                      ),
                      ListTile(
                        title: const Text('CPU'),
                        subtitle: Text(
                            '${viewModel.marca} - Serie: ${_numeroSerieCpuController.text}'),
                      ),
                      ListTile(
                        title: const Text('Monitor'),
                        subtitle: Text(
                            '${viewModel.monitor} - Serie: ${_numeroSerieMonitorController.text}'),
                      ),
                      ListTile(
                        title: const Text('Teclado'),
                        subtitle: Text(
                            '${viewModel.teclado} - Serie: ${_numeroSerieTecladoController.text}'),
                      ),
                      ListTile(
                        title: const Text('Prioridad'),
                        subtitle: Text(viewModel.prioridadBuscada),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primary,
              ),
            ),
            TextButton(
              onPressed: () {
                viewModel.registrarSolicitud();
                _limpiarFormulario(); // Limpia el formulario incluyendo los selects
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Solicitud registrada correctamente',
                        style: TextStyle(color: AppColors.primary)),
                    backgroundColor: AppColors.white,
                  ),
                );
              },
              child: const Text('Aceptar'),
              style: TextButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        );
      },
    );
  }

  void _limpiarFormulario() {
    _nombreController.clear();
    _departamentoController.clear();
    _numeroSerieCpuController.clear();
    _numeroSerieMonitorController.clear();
    _numeroSerieTecladoController.clear();
    Provider.of<BusquedaMantenimientoViewModel>(context, listen: false)
        .resetBusqueda();
  }
}
