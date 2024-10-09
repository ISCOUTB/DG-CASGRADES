import 'package:flutter/material.dart';
import '/backend/services/autenticacion.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AutenticacionService _authService = AutenticacionService();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String error = '';

  void iniciarSesion() {
    bool exito = _authService.iniciarSesion(_emailController.text, _passwordController.text);
    if (exito) {
      Navigator.pushReplacementNamed(context, '/menu');
    } else {
      setState(() {
        error = 'Error en las credenciales';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CASGRADES - Inicio de Sesión'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Correo electrónico'),
            ),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: iniciarSesion,
              child: Text('Iniciar Sesión'),
            ),
            if (error.isNotEmpty) Text(error, style: TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }
}
