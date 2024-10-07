import 'package:flutter/material.dart';
import '../modelos/usuario.dart';

class MenuScreen extends StatelessWidget {
  final Usuario usuario;

  MenuScreen({required this.usuario});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Menú Principal')),
      body: ListView(
        children: [
          if (usuario.rol == Rol.estudiante || usuario.rol == Rol.profesor || usuario.rol == Rol.administrador)
            ListTile(
              title: Text('Gestionar Asignaturas'),
              onTap: () => Navigator.pushNamed(context, '/asignaturas'),
            ),
          if (usuario.rol == Rol.profesor || usuario.rol == Rol.administrador)
            ListTile(
              title: Text('Gestionar Notas'),
              onTap: () => Navigator.pushNamed(context, '/notas'),
            ),
          if (usuario.rol == Rol.administrador)
            ListTile(
              title: Text('Gestionar Usuarios'),
              onTap: () => Navigator.pushNamed(context, '/usuarios'),
            ),
        ],
      ),
    );
  }
}
