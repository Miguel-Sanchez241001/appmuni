import 'package:appmuni/core/utils/snackbar_util.dart';
import 'package:appmuni/features/usuarios/presentation/pages/login_page.dart';
import 'package:appmuni/features/usuarios/presentation/viewmodels/register_viewmodel.dart';
import 'package:appmuni/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final registerViewModel = Provider.of<RegisterViewModel>(context);

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 180,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(100),
                  bottomRight: Radius.circular(100),
                ),
              ),
            ),
          ),
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
                        boxShadow: const [
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
                          const Center(
                            child: Text(
                              'REGISTRO DE DATOS',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          _buildTextField(
                            controller: _firstNameController,
                            label: 'Nombres',
                            onChanged: registerViewModel.setFirstName,
                          ),
                          _buildTextField(
                            controller: _lastNameController,
                            label: 'Apellidos',
                            onChanged: registerViewModel.setLastName,
                          ),
                          _buildTextField(
                            controller: _phoneNumberController,
                            label: 'Celular',
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            onChanged: registerViewModel.setPhoneNumber,
                          ),
                          _buildTextField(
                            controller: _emailController,
                            label: 'Correo',
                            keyboardType: TextInputType.emailAddress,
                            onChanged: registerViewModel.setEmail,
                          ),
                          _buildPasswordField(
                            controller: _passwordController,
                            label: 'Contraseña',
                            onChanged: registerViewModel.setPassword,
                            isPasswordVisible: registerViewModel.isShowPassword,
                            togglePasswordVisibility:
                                registerViewModel.togglePasswordVisibility,
                          ),
                          _buildPasswordField(
                            controller: _confirmPasswordController,
                            label: 'Confirmar Contraseña',
                            onChanged: registerViewModel.setConfirmPassword,
                            isPasswordVisible:
                                registerViewModel.isShowConfirmPassword,
                            togglePasswordVisibility: registerViewModel
                                .toggleConfirmPasswordVisibility,
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: Consumer<RegisterViewModel>(
                              builder: (context, viewModel, child) {
                                return ElevatedButton(
                                  onPressed: viewModel.isLoading
                                      ? null
                                      : () async {
                                          if (_validateInputs(viewModel)) {
                                            _showConfirmationDialog(
                                                context, viewModel);
                                          } else {
                                            showCustomSnackBar(context,
                                                viewModel.errorMessage);
                                          }
                                        },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primary,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 40, vertical: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: viewModel.isLoading
                                      ? const CircularProgressIndicator(
                                          color: Colors.white,
                                        )
                                      : const Text(
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required Function(String) onChanged,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
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

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required Function(String) onChanged,
    required bool isPasswordVisible,
    required VoidCallback togglePasswordVisibility,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextField(
        controller: controller,
        obscureText: !isPasswordVisible,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: AppColors.primary),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.primary),
          ),
          suffixIcon: IconButton(
            icon: Icon(
              isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              color: AppColors.primary,
            ),
            onPressed: togglePasswordVisibility,
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }

  bool _validateInputs(RegisterViewModel viewModel) {
    if (viewModel.firstName.isEmpty ||
        viewModel.lastName.isEmpty ||
        viewModel.phoneNumber.isEmpty ||
        viewModel.email.isEmpty ||
        viewModel.password.isEmpty ||
        viewModel.confirmPassword.isEmpty) {
      viewModel.setErrorMessage('Por favor, complete todos los campos.');
      return false;
    } else if (!viewModel.isValidEmail(viewModel.email)) {
      viewModel.setErrorMessage('Por favor, ingrese un correo válido.');
      return false;
    } else if (!viewModel.isValidPhone(viewModel.phoneNumber)) {
      viewModel
          .setErrorMessage('Por favor, ingrese un número de celular válido.');
      return false;
    } else if (viewModel.password != viewModel.confirmPassword) {
      viewModel.setErrorMessage('Las contraseñas no coinciden.');
      return false;
    }
    viewModel.setErrorMessage('');
    return true;
  }

  void _showConfirmationDialog(
      BuildContext context, RegisterViewModel viewModel) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirmar Registro'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                ListTile(
                  title: const Text('Nombres:'),
                  subtitle: Text(viewModel.firstName),
                ),
                ListTile(
                  title: const Text('Apellidos:'),
                  subtitle: Text(viewModel.lastName),
                ),
                ListTile(
                  title: const Text('Celular:'),
                  subtitle: Text(viewModel.phoneNumber),
                ),
                ListTile(
                  title: const Text('Correo:'),
                  subtitle: Text(viewModel.email),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await viewModel.register();
                if (viewModel.errorMessage.isEmpty) {
                  showCustomSnackBar(
                    context,
                    'Registro exitoso. Por favor, inicia sesión.',
                  );

                  // Redirigir usando Navigator.pushReplacement
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  );
                } else {
                  showCustomSnackBar(context, viewModel.errorMessage);
                }
              },
              child: const Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }
}
