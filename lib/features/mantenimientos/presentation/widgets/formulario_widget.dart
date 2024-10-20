import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FormularioPage extends StatelessWidget {
  final String opcion;

  FormularioPage({required this.opcion});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulario - $opcion'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Formulario para $opcion', style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(labelText: 'Ingrese su respuesta'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Regresar a la pantalla anterior
              },
              child: Text('Enviar'),
            ),
          ],
        ),
      ),
    );
  }
}
