import 'package:appmuni/features/mantenimientos/presentation/viewmodels/formulario_viewmodel.dart';
import 'package:appmuni/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormularioPage extends StatefulWidget {
  final String opcion;

  const FormularioPage({super.key, required this.opcion});

  @override
  _FormularioPageState createState() => _FormularioPageState();
}

class _FormularioPageState extends State<FormularioPage> {
  late TextEditingController nombreController;
  late TextEditingController departamentoController;
  late TextEditingController descripcionController;

  @override
  void initState() {
    super.initState();
    final viewModel = Provider.of<FormularioViewModel>(context, listen: false);
    nombreController = TextEditingController(text: viewModel.nombre);
    departamentoController =
        TextEditingController(text: viewModel.departamento);
    descripcionController =
        TextEditingController(text: viewModel.descripcionProblema);
  }

  @override
  void dispose() {
    nombreController.dispose();
    departamentoController.dispose();
    descripcionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<FormularioViewModel>(context);

    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Material(
            color: Colors.transparent,
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
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.opcion,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildTextField(
                    label: 'Nombre del equipo o Usuario',
                    controller: nombreController,
                    onChanged: (value) => viewModel.setNombre(value),
                  ),
                  _buildTextField(
                    label: 'Sede',
                    controller: departamentoController,
                    onChanged: (value) => viewModel.setDepartamento(value),
                  ),
                  _buildTextField(
                    label: 'Descripción del Problema',
                    maxLines: 3,
                    controller: descripcionController,
                    onChanged: (value) =>
                        viewModel.setDescripcionProblema(value),
                  ),
                  const SizedBox(height: 10),
                  _buildDropdown(
                    label: 'Prioridad',
                    items: ['Alta', 'Media', 'Baja'],
                    value: viewModel.prioridad,
                    onChanged: (value) => viewModel.setPrioridad(value!),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        _confirmarEnvio(context, viewModel);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        'Enviar',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    int maxLines = 1,
    required Function(String) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
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
            items: items
                .map((item) => DropdownMenuItem(
                      value: item,
                      child: Text(item),
                    ))
                .toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  void _confirmarEnvio(BuildContext context, FormularioViewModel viewModel) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text(
            'Confirmar envío',
            style: TextStyle(color: AppColors.primary),
          ),
          content: const Text(
            '¿Está seguro de que desea enviar esta solicitud?',
            style: TextStyle(color: Colors.black),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primary,
              ),
            ),
            TextButton(
              onPressed: () {
                viewModel.enviarSolicitud();
                viewModel.limpiarFormulario();

                nombreController.clear();
                departamentoController.clear();
                descripcionController.clear();

                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Solicitud enviada correctamente'),
                    backgroundColor: AppColors.primary,
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
}
