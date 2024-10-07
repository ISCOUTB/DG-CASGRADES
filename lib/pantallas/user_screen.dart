import 'package:flutter/material.dart';
import '../modelos/usuario.dart';
import '../servicios/serv_database.dart';

class UsuariosScreen extends StatefulWidget {
  @override
  _UsuariosScreenState createState() => _UsuariosScreenState();
}

class _UsuariosScreenState extends State<UsuariosScreen> {
  List<Usuario> _usuarios = [];

  @override
  void initState() {
    super.initState();
    _cargarUsuarios();
  }

  // Cargar los usuarios desde la base de datos
  void _cargarUsuarios() async {
    List<Usuario> usuario = await DatabaseService().obtenerUsuario();
    setState(() {
      _usuarios = usuario;
    });
  }

  // Función para agregar un nuevo usuario
  void _agregarUsuario(String nombre, String email, Rol rol) async {
    Usuario nuevoUsuario = Usuario(
      id: DateTime.now().toString(),
      nombre: nombre,
      email: email,
      rol: rol,
    );
    await DatabaseService().agregarUsuario(nuevoUsuario);
    _cargarUsuarios();
  }

  // Función para eliminar un usuario
  void _eliminarUsuario(String usuarioId) async {
    await DatabaseService().eliminarUsuario(usuarioId);
    _cargarUsuarios();
  }

  // Crear formulario para agregar un usuario
  Future<void> _mostrarFormularioAgregarUsuario() async {
    String? nombreUsuario = await showDialog<String>(
      context: context,
      builder: (context) {
        TextEditingController _nombreController = TextEditingController();
        TextEditingController _emailController = TextEditingController();
        Rol? _rolSeleccionado;

        return AlertDialog(
          title: Text('Agregar Usuario'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nombreController,
                decoration: InputDecoration(labelText: 'Nombre del usuario'),
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email del usuario'),
              ),
              DropdownButtonFormField<Rol>(
                hint: Text('Seleccionar Rol'),
                items: Rol.values.map((rol) {
                  return DropdownMenuItem<Rol>(
                    value: rol,
                    child: Text(rol.toString().split('.').last),
                  );
                }).toList(),
                onChanged: (Rol? value) {
                  _rolSeleccionado = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_rolSeleccionado != null) {
                  Navigator.of(context).pop(_nombreController.text);
                  _agregarUsuario(_nombreController.text, _emailController.text, _rolSeleccionado!);
                }
              },
              child: Text('Agregar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestión de Usuarios'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _mostrarFormularioAgregarUsuario,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _usuarios.length,
        itemBuilder: (context, index) {
          final usuario = _usuarios[index];
          return ListTile(
            title: Text(usuario.nombre),
            subtitle: Text(usuario.email),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _eliminarUsuario(usuario.id),
            ),
            onTap: () {
              // Aquí puedes implementar la edición del usuario
            },
          );
        },
      ),
    );
  }
}
