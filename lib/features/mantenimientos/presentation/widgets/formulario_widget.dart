import 'package:appmuni/features/mantenimientos/presentation/viewmodels/formulario_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
 
class FormularioPage extends StatelessWidget {
  final String opcion;

  const FormularioPage({super.key, required this.opcion});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Material(  // Envolvemos el formulario en un Material
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
                  const SizedBox(height: 20),
                  _buildTextField(
                    context,
                    label: 'Nombre del Solicitante',
                    onChanged: (value) => context.read<FormularioViewModel>().setNombre(value),
                  ),
                  _buildTextField(
                    context,
                    label: 'Departamento',
                    onChanged: (value) => context.read<FormularioViewModel>().setDepartamento(value),
                  ),
                  _buildTextField(
                    context,
                    label: 'Descripción del Problema',
                    maxLines: 3,
                    onChanged: (value) => context.read<FormularioViewModel>().setDescripcionProblema(value),
                  ),
                  const SizedBox(height: 20),
                  _buildDropdown(
                    context,
                    label: 'Prioridad',
                    items: ['Alta', 'Media', 'Baja'],
                    onChanged: (value) => context.read<FormularioViewModel>().setPrioridad(value!),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<FormularioViewModel>().enviarSolicitud();
                        Navigator.pop(context); // Cerrar la pantalla después de enviar
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
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

  // Widget para construir los campos de texto
  Widget _buildTextField(BuildContext context, {required String label, int maxLines = 1, required Function(String) onChanged}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextField(
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

  // Widget para construir un DropdownButton (Selector de Prioridad)
  Widget _buildDropdown(BuildContext context, {required String label, required List<String> items, required ValueChanged<String?> onChanged}) {
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
            value: context.watch<FormularioViewModel>().prioridad,
            isExpanded: true,
            underline: Container(), // Elimina la línea de subrayado
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
}
