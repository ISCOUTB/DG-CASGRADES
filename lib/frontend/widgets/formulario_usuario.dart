import 'package:flutter/material.dart';
import '/backend/models/usuario.dart';

class FormularioUsuario extends StatefulWidget {
  final Usuario? usuario;
  final Function(String, String, String) onSubmit;

  FormularioUsuario({this.usuario, required this.onSubmit});

  @override
  _FormularioUsuarioState createState() => _FormularioUsuarioState();
}

class _FormularioUsuarioState extends State<FormularioUsuario> {
  final _nombreController = TextEditingController();
  final _emailController = TextEditingController();
  String? _rolSeleccionado;

  @override
  void initState() {
    super.initState();
    if (widget.usuario != null) {
      _nombreController.text = widget.usuario!.nombre;
      _emailController.text = widget.usuario!.email;
      _rolSeleccionado = widget.usuario!.rol;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextFormField(
            controller: _nombreController,
            decoration: InputDecoration(labelText: 'Nombre del Usuario'),
          ),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(labelText: 'Email del Usuario'),
          ),
          DropdownButton<String>(
            value: _rolSeleccionado,
            hint: Text('Seleccionar Rol'),
            onChanged: (nuevoRol) {
              setState(() {
                _rolSeleccionado = nuevoRol;
              });
            },
            items: ['Estudiante', 'Profesor', 'Administrador'].map((rol) {
              return DropdownMenuItem<String>(
                value: rol,
                child: Text(rol),
              );
            }).toList(),
          ),
          ElevatedButton(
            onPressed: () {
              widget.onSubmit(
                _nombreController.text,
                _emailController.text,
                _rolSeleccionado!,
              );
              Navigator.pop(context);
            },
            child: Text(widget.usuario == null ? 'Agregar' : 'Editar'),
          ),
        ],
      ),
    );
  }
}
