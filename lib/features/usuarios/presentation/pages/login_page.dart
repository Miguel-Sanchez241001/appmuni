  import 'package:flutter/material.dart';
  import 'package:flutter_bloc/flutter_bloc.dart';
  import 'package:provider/provider.dart';
  import 'package:appmuni/injection_container/blocs/login_bloc.dart';
  import 'package:appmuni/injection_container/auth_provider.dart';
  import 'package:flutter/material.dart';
  import 'package:provider/provider.dart';
  import '../viewmodels/login_viewmodel.dart';
  
  class LoginPage extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      final viewModel = Provider.of<LoginViewModel>(context);
  
      // return Container(
      //   color: Colors.grey[300],
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.spaceAround,
      //     // Distribuye el espacio verticalmente
      //     crossAxisAlignment: CrossAxisAlignment.end,
      //     // Alinea los hijos horizontalmente
      //     mainAxisSize: MainAxisSize.max,
      //     // Usa todo el espacio disponible verticalmente
      //     children: [
      //       Stack(
      //         children: [
      //           // Primer elemento: fondo rojo
      //           Container(
      //             width: MediaQuery.of(context).size.width, // Ancho completo
      //             height: 200, // Ajustamos la altura
      //             decoration: BoxDecoration(
      //               color: Colors.red, // Fondo rojo
      //               borderRadius: BorderRadius.only(
      //                 bottomLeft: Radius.circular(150),
      //                 // Redondeamos las esquinas inferiores
      //                 bottomRight: Radius.circular(150),
      //               ),
      //             ),
      //           ),
      //           // Segundo elemento: imagen encima
      //           Center(
      //             child: Image.asset(
      //               'assets/images/logo.png',
      //               // Asegúrate de que la imagen esté en la carpeta assets
      //               width: 200, // Ajusta el tamaño de la imagen si es necesario
      //               height: 200,
      //             ),
      //           ),
      //         ],
      //       ),
      //       Expanded(
      //
      //           child: Column(
      //                     children: [
      //                       // Texto Iniciar Sesión
      //                       Text(
      //                         'INICIAR SESION',
      //                         style: TextStyle(
      //                           fontSize: 22,
      //                           fontWeight: FontWeight.bold,
      //                           color: Colors.red,
      //                         ),
      //                       ),
      //                       SizedBox(height: 20),
      //
      //                       // Campo Usuario
      //                       TextField(
      //                         onChanged: viewModel.setEmail,
      //                         decoration: InputDecoration(
      //                           labelText: 'Usuario',
      //                           labelStyle: TextStyle(color: Colors.red),
      //                           enabledBorder: UnderlineInputBorder(
      //                             borderSide: BorderSide(color: Colors.red),
      //                           ),
      //                           focusedBorder: UnderlineInputBorder(
      //                             borderSide: BorderSide(color: Colors.red),
      //                           ),
      //                         ),
      //                       ),
      //                       SizedBox(height: 20),
      //
      //                       // Campo Contraseña con visibilidad
      //                       TextField(
      //                         onChanged: viewModel.setPassword,
      //                         obscureText: viewModel.isShowPassword,
      //                         decoration: InputDecoration(
      //                           labelText: 'Contraseña',
      //                           labelStyle: TextStyle(color: Colors.red),
      //                           enabledBorder: UnderlineInputBorder(
      //                             borderSide: BorderSide(color: Colors.red),
      //                           ),
      //                           focusedBorder: UnderlineInputBorder(
      //                             borderSide: BorderSide(color: Colors.red),
      //                           ),
      //                           suffixIcon: IconButton(
      //                             icon: Icon(
      //                               viewModel.isShowPassword
      //                                   ? Icons.visibility
      //                                   : Icons.visibility_off,
      //                             ),
      //                             onPressed: () {
      //                               viewModel
      //                                   .setIsShowPassword(!viewModel.isShowPassword);
      //                             },
      //                           ),
      //                         ),
      //                       ),
      //                       SizedBox(height: 20),
      //                       viewModel.isLoading
      //                           ? CircularProgressIndicator(
      //                               backgroundColor: Colors.redAccent,
      //                             )
      //                           : ElevatedButton(
      //                               style: ElevatedButton.styleFrom(
      //                                 padding: EdgeInsets.symmetric(
      //                                   horizontal: 80,
      //                                   vertical: 15,
      //                                 ),
      //                                 backgroundColor: Colors.redAccent,
      //                                 // Color de fondo rojo
      //                                 shape: RoundedRectangleBorder(
      //                                   borderRadius: BorderRadius.circular(30),
      //                                 ),
      //                               ),
      //                               onPressed: () async {
      //                                 await viewModel.login();
      //                                 if (viewModel.errorMessage.isEmpty) {
      //                                   Navigator.pushReplacementNamed(context, '/home');
      //                                 } else {
      //                                   ScaffoldMessenger.of(context).showSnackBar(
      //                                     SnackBar(
      //                                       content: Text(viewModel.errorMessage),
      //                                     ),
      //                                   );
      //                                 }
      //                               },
      //                               child: Text(
      //                                 'INGRESAR',
      //                                 style: TextStyle(
      //                                   fontSize: 18,
      //                                   fontWeight: FontWeight.bold,
      //                                   color: Colors.white,
      //                                 ),
      //                               ),
      //                             ),
      //
      //                       SizedBox(height: 20),
      //
      //                       // Texto para registrarse
      //                       GestureDetector(
      //                         onTap: () {
      //                           // Navegar a la pantalla de registro
      //                         },
      //                         child: Text(
      //                           'Registrate aqui',
      //                           style: TextStyle(
      //                             color: Colors.red,
      //                             fontWeight: FontWeight.bold,
      //                           ),
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //               ]
      //   )
      //
      //
      //
      // );
  
      return Scaffold(
  
        appBar: AppBar(
          shape: RoundedRectangleBorder(
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
                SizedBox(height: 20),
              ],
            ),
          ),
          backgroundColor: Colors.red,
          toolbarHeight: 150,
        ),
        backgroundColor: Colors.grey[300],
        body: Column(
  
          children: [
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    // Sombra gris con opacidad
                    spreadRadius: 5,
                    // Extensión de la sombra
                    blurRadius: 7,
                    // Desenfoque de la sombra
                    offset: Offset(0, 3), // Desplazamiento de la sombra (x, y)
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
                  Text(
                    'INICIAR SESION',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  SizedBox(height: 20),
  
                  // Campo Usuario
                  TextField(
                    onChanged: viewModel.setEmail,
                    decoration: InputDecoration(
                      labelText: 'Usuario',
                      labelStyle: TextStyle(color: Colors.red),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
  
                  // Campo Contraseña con visibilidad
                  TextField(
                    onChanged: viewModel.setPassword,
                    obscureText: viewModel.isShowPassword,
                    decoration: InputDecoration(
                      labelText: 'Contraseña',
                      labelStyle: TextStyle(color: Colors.red),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
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
                  SizedBox(height: 20),
                  viewModel.isLoading
                      ? CircularProgressIndicator(
                          backgroundColor: Colors.redAccent,
                        )
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              horizontal: 80,
                              vertical: 15,
                            ),
                            backgroundColor: Colors.redAccent,
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
                          child: Text(
                            'INGRESAR',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
  
                  SizedBox(height: 20),
  
                  // Texto para registrarse
                  GestureDetector(
                    onTap: () {
                      // Navegar a la pantalla de registro
                    },
                    child: Text(
                      'Registrate aqui',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
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
