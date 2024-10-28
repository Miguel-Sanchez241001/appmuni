import 'package:appmuni/features/mantenimientos/presentation/viewmodels/formulario_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormularioPage extends StatelessWidget {
  final String opcion;

  const FormularioPage({super.key, required this.opcion});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<FormularioViewModel>(context);
    final nombreController = TextEditingController(text: viewModel.nombre);
    final departamentoController =
        TextEditingController(text: viewModel.departamento);
    final descripcionController =
        TextEditingController(text: viewModel.descripcionProblema);

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
                    'Formulario - $opcion',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildTextField(
                    context,
                    label: 'Nombre del Solicitante',
                    controller: nombreController,
                    onChanged: (value) => viewModel.setNombre(value),
                  ),
                  _buildTextField(
                    context,
                    label: 'Departamento',
                    controller: departamentoController,
                    onChanged: (value) => viewModel.setDepartamento(value),
                  ),
                  _buildTextField(
                    context,
                    label: 'Descripción del Problema',
                    maxLines: 3,
                    controller: descripcionController,
                    onChanged: (value) =>
                        viewModel.setDescripcionProblema(value),
                  ),
                  const SizedBox(height: 10),
                  _buildDropdown(
                    context,
                    label: 'Prioridad',
                    items: ['Alta', 'Media', 'Baja'],
                    value: viewModel.prioridad,
                    onChanged: (value) => viewModel.setPrioridad(value!),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        _confirmarEnvio(context, viewModel, nombreController,
                            departamentoController, descripcionController);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
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

  Widget _buildTextField(BuildContext context,
      {required String label,
      required TextEditingController controller,
      int maxLines = 1,
      required Function(String) onChanged}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.red),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildDropdown(BuildContext context,
      {required String label,
      required List<String> items,
      required String value,
      required ValueChanged<String?> onChanged}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.red)),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.red),
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

  void _confirmarEnvio(
    BuildContext context,
    FormularioViewModel viewModel,
    TextEditingController nombreController,
    TextEditingController departamentoController,
    TextEditingController descripcionController,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white, // Fondo blanco para el diálogo
          title: const Text(
            'Confirmar envío',
            style: TextStyle(color: Colors.red), // Título en color rojo
          ),
          content: const Text(
            '¿Está seguro de que desea enviar esta solicitud?',
            style: TextStyle(color: Colors.black), // Texto en color negro
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
              style: TextButton.styleFrom(
                foregroundColor:
                    Colors.red, // Texto rojo en el botón "Cancelar"
              ),
            ),
            TextButton(
              onPressed: () {
                viewModel.enviarSolicitud();
                viewModel.limpiarFormulario();

                // Limpiar controladores para que reflejen el estado del ViewModel
                nombreController.clear();
                departamentoController.clear();
                descripcionController.clear();

                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Solicitud enviada correctamente'),
                    backgroundColor: Colors.red, // Fondo rojo para el SnackBar
                  ),
                );
              },
              child: const Text('Aceptar'),
              style: TextButton.styleFrom(
                backgroundColor: Colors.red, // Fondo rojo
                foregroundColor:
                    Colors.white, // Texto blanco en el botón "Aceptar"
              ),
            ),
          ],
        );
      },
    );
  }
}
