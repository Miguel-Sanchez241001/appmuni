import 'package:flutter/material.dart';
import 'package:appmuni/theme/colors.dart';

import '../widgets/formulario_widget.dart';
class MantenimientoPage extends StatelessWidget {
  final List<String> opciones = ['Opción 1', 'Opción 2', 'Opción 3'];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: opciones.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(opciones[index]),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FormularioPage(opcion: opciones[index])),
            );
          },
        );
      },
    );
  }
}
