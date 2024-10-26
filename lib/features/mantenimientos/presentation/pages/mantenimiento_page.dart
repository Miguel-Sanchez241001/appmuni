import 'package:flutter/material.dart';
import '../widgets/formulario_widget.dart';

class MantenimientoPage extends StatelessWidget {
  final List<String> opciones = [
    'REGISTRAR MANTENIMIENTO',
    'CONSULTAR MANTENIMIENTO',
    'APROBAR/RECHAZAR MANTENIMIENTO'
  ];

  MantenimientoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: opciones.asMap().entries.map((entry) {
            int index = entry.key;
            String opcion = entry.value;

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FormularioPage(opcion: opcion),
                    ),
                  );
                },
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    border: Border.all(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    opcion,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
