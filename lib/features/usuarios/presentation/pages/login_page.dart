import 'package:appmuni/features/usuarios/presentation/pages/register_page.dart';
import 'package:appmuni/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/login_viewmodel.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<LoginViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(200), // El valor aquí define el arco
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.all(60.0),
          child: Column(
            children: [
              Image.asset(
                'assets/images/logo.png',
                height: 200,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
        backgroundColor: AppColors.primary,
        toolbarHeight: 150,
      ),
      backgroundColor: Colors.grey[300],
      body: Column(
        children: [
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  // Sombra gris con opacidad
                  spreadRadius: 5,
                  // Extensión de la sombra
                  blurRadius: 7,
                  // Desenfoque de la sombra
                  offset:
                      const Offset(0, 3), // Desplazamiento de la sombra (x, y)
                ),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.black, // borde azul
              ),
            ),
            child: Column(
              children: [
                // Texto Iniciar Sesión
                const Text(
                  'INICIAR SESION',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 20),

                // Campo Usuario
                TextField(
                  onChanged: viewModel.setEmail,
                  decoration: const InputDecoration(
                    labelText: 'Usuario',
                    labelStyle: TextStyle(color: AppColors.primary),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primary),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primary),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Campo Contraseña con visibilidad
                TextField(
                  onChanged: viewModel.setPassword,
                  obscureText: viewModel.isShowPassword,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    labelStyle: const TextStyle(color: AppColors.primary),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primary),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primary),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        viewModel.isShowPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        viewModel.setIsShowPassword(!viewModel.isShowPassword);
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                viewModel.isLoading
                    ? const CircularProgressIndicator(
                        backgroundColor: AppColors.primary,
                      )
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 80,
                            vertical: 15,
                          ),
                          backgroundColor: AppColors.primary,
                          // Color de fondo rojo
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () async {
                          await viewModel.login();
                          if (viewModel.errorMessage.isEmpty) {
                            Navigator.pushReplacementNamed(context, '/home');
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(viewModel.errorMessage),
                              ),
                            );
                          }
                        },
                        child: const Text(
                          'INGRESAR',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),

                const SizedBox(height: 20),

                // Texto para registrarse
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    child: const Text(
                      'Regístrate aquí',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
