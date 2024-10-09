import 'package:flutter/material.dart';
import '/backend/services/autenticacion.dart';

class MenuScreen extends StatelessWidget {
  final AutenticacionService _authService = AutenticacionService();

  @override
  Widget build(BuildContext context) {
    String rol = _authService.obtenerRol();

    return Scaffold(
      appBar: AppBar(
        title: Text('CASGRADES - Menú Principal'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              _authService.cerrarSesion();
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/asignaturas'),
            child: Text('Gestionar Asignaturas'),
          ),
          if (rol != 'estudiante') ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/notas'),
            child: Text('Gestionar Notas'),
          ),
          if (rol == 'administrador') ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/usuarios'),
            child: Text('Gestionar Usuarios'),
          ),
        ],
      ),
    );
  }
}
