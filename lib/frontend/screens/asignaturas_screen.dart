import 'package:flutter/material.dart';
import '/backend/models/asignatura.dart';
import '/backend/services/database.dart';
import '/frontend/widgets/formulario_asignatura.dart';

class AsignaturasScreen extends StatefulWidget {
  @override
  _AsignaturasScreenState createState() => _AsignaturasScreenState();
}

class _AsignaturasScreenState extends State<AsignaturasScreen> {
  final DatabaseService _databaseService = DatabaseService();

  void agregarAsignatura(String nombre) {
    final nuevaAsignatura = Asignatura(id: DateTime.now().toString(), nombre: nombre);
    setState(() {
      _databaseService.agregarAsignatura(nuevaAsignatura);
    });
  }

  void editarAsignatura(String id, String nuevoNombre) {
    setState(() {
      _databaseService.editarAsignatura(id, nuevoNombre);
    });
  }

  void eliminarAsignatura(String id) {
    setState(() {
      _databaseService.eliminarAsignatura(id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestionar Asignaturas'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _databaseService.obtenerAsignaturas().length,
              itemBuilder: (context, index) {
                final asignatura = _databaseService.obtenerAsignaturas()[index];
                return ListTile(
                  title: Text(asignatura.nombre),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => mostrarFormularioEditar(context, asignatura),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => eliminarAsignatura(asignatura.id),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          FormularioAsignatura(
            onSubmit: (nombre) => agregarAsignatura(nombre),
          ),
        ],
      ),
    );
  }

  void mostrarFormularioEditar(BuildContext context, Asignatura asignatura) {
    showDialog(
      context: context,
      builder: (context) {
        return FormularioAsignatura(
          asignatura: asignatura,
          onSubmit: (nuevoNombre) => editarAsignatura(asignatura.id, nuevoNombre),
        );
      },
    );
  }
}
