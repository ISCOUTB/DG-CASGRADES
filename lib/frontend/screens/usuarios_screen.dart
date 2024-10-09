import 'package:flutter/material.dart';
import '/backend/models/usuario.dart';
import '/backend/services/database.dart';
import '/frontend/widgets/formulario_usuario.dart';

class UsuariosScreen extends StatefulWidget {
  @override
  _UsuariosScreenState createState() => _UsuariosScreenState();
}

class _UsuariosScreenState extends State<UsuariosScreen> {
  final DatabaseService _databaseService = DatabaseService();

  void agregarUsuario(String nombre, String email, String rol) {
    final nuevoUsuario = Usuario(id: DateTime.now().toString(), nombre: nombre, email: email, rol: rol);
    setState(() {
      _databaseService.agregarUsuario(nuevoUsuario);
    });
  }

  void editarUsuario(String id, String nuevoNombre, String nuevoEmail, String nuevoRol) {
    setState(() {
      _databaseService.editarUsuario(id, nuevoNombre, nuevoEmail, nuevoRol);
    });
  }

  void eliminarUsuario(String id) {
    setState(() {
      _databaseService.eliminarUsuario(id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestionar Usuarios'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _databaseService.obtenerUsuarios().length,
              itemBuilder: (context, index) {
                final usuario = _databaseService.obtenerUsuarios()[index];
                return ListTile(
                  title: Text(usuario.nombre),
                  subtitle: Text('${usuario.email} - ${usuario.rol}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => mostrarFormularioEditar(context, usuario),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => eliminarUsuario(usuario.id),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          FormularioUsuario(
            onSubmit: (nombre, email, rol) => agregarUsuario(nombre, email, rol),
          ),
        ],
      ),
    );
  }

  void mostrarFormularioEditar(BuildContext context, Usuario usuario) {
    showDialog(
      context: context,
      builder: (context) {
        return FormularioUsuario(
          usuario: usuario,
          onSubmit: (nuevoNombre, nuevoEmail, nuevoRol) => editarUsuario(usuario.id, nuevoNombre, nuevoEmail, nuevoRol),
        );
      },
    );
  }
}
