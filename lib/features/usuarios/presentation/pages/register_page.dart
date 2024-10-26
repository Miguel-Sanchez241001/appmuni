import 'package:appmuni/features/usuarios/presentation/viewmodels/register_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
 
class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Stack(
        children: [
          // Semicírculo en la parte superior
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 180,
              decoration: const BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(100),
                  bottomRight: Radius.circular(100),
                ),
              ),
            ),
          ),
          // Formulario de registro
          Positioned.fill(
            top: 100,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
           
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow:const  [
                            BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              'REGISTRO DE DATOS',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          // Campos de texto
                          _buildTextField(
                              context, 'Nombres', false, (value) {
                            Provider.of<RegisterViewModel>(context,
                                    listen: false)
                                .setFirstName(value);
                          }),
                          _buildTextField(
                              context, 'Apellidos', false, (value) {
                            Provider.of<RegisterViewModel>(context,
                                    listen: false)
                                .setLastName(value);
                          }),
                          _buildTextField(
                              context, 'Celular', false, (value) {
                            Provider.of<RegisterViewModel>(context,
                                    listen: false)
                                .setPhoneNumber(value);
                          }),
                          _buildTextField(
                              context, 'Correo', false, (value) {
                            Provider.of<RegisterViewModel>(context,
                                    listen: false)
                                .setEmail(value);
                          }),
                          _buildPasswordField(
                              context, 'Contraseña', true, (value) {
                            Provider.of<RegisterViewModel>(context,
                                    listen: false)
                                .setPassword(value);
                          }),
                          _buildPasswordField(context, 'Confirmar Contraseña',
                              true, (value) {
                            Provider.of<RegisterViewModel>(context,
                                    listen: false)
                                .setConfirmPassword(value);
                          }),
                          const SizedBox(height: 20),
                          // Botón de registro
                          Center(
                            child: Consumer<RegisterViewModel>(
                              builder: (context, viewModel, child) {
                                return ElevatedButton(
                                  onPressed: viewModel.isLoading
                                      ? null
                                      : () => viewModel.register(),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 40, vertical: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: viewModel.isLoading
                                      ? CircularProgressIndicator(
                                          color: Colors.white,
                                        )
                                      : Text(
                                          'REGISTRAR',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Método para construir los campos de texto
  Widget _buildTextField(
      BuildContext context, String label, bool isPassword, Function(String) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.red),
          focusedBorder:  const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }

  // Método para construir los campos de contraseña con ícono de visibilidad
  Widget _buildPasswordField(
      BuildContext context, String label, bool isPassword, Function(String) onChanged) {
    return Consumer<RegisterViewModel>(
      builder: (context, viewModel, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: TextFormField(
            obscureText: label == 'Contraseña'
                ? viewModel.isShowPassword
                : viewModel.isShowConfirmPassword,
            decoration: InputDecoration(
              labelText: label,
              labelStyle: const TextStyle(color: Colors.red),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  label == 'Contraseña'
                      ? (viewModel.isShowPassword
                          ? Icons.visibility_off
                          : Icons.visibility)
                      : (viewModel.isShowConfirmPassword
                          ? Icons.visibility_off
                          : Icons.visibility),
                  color: Colors.red,
                ),
                onPressed: () {
                  if (label == 'Contraseña') {
                    viewModel.setIsShowPassword(!viewModel.isShowPassword);
                  } else {
                    viewModel.setIsShowConfirmPassword(
                        !viewModel.isShowConfirmPassword);
                  }
                },
              ),
            ),
            onChanged: onChanged,
          ),
        );
      },
    );
  }
}
