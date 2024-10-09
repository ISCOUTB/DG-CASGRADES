import 'package:flutter/material.dart';
import '/backend/models/nota.dart';
import '/backend/services/database.dart';
import '/frontend/widgets/formulario_notas.dart';

class NotasScreen extends StatefulWidget {
  @override
  _NotasScreenState createState() => _NotasScreenState();
}

class _NotasScreenState extends State<NotasScreen> {
  final DatabaseService _databaseService = DatabaseService();
  String? asignaturaSeleccionada;

  void agregarNota(double valor) {
    final nuevaNota = Nota(id: DateTime.now().toString(), asignaturaId: asignaturaSeleccionada!, valor: valor);
    setState(() {
      _databaseService.agregarNota(nuevaNota);
    });
  }

  void editarNota(String id, double nuevoValor) {
    setState(() {
      _databaseService.editarNota(id, nuevoValor);
    });
  }

  void eliminarNota(String id) {
    setState(() {
      _databaseService.eliminarNota(id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestionar Notas'),
      ),
      body: Column(
        children: [
          DropdownButton<String>(
            value: asignaturaSeleccionada,
            hint: Text('Seleccionar Asignatura'),
            onChanged: (nuevoValor) {
              setState(() {
                asignaturaSeleccionada = nuevoValor!;
              });
            },
            items: _databaseService.obtenerAsignaturas().map((asignatura) {
              return DropdownMenuItem<String>(
                value: asignatura.id,
                child: Text(asignatura.nombre),
              );
            }).toList(),
          ),
          if (asignaturaSeleccionada != null) Expanded(
            child: ListView.builder(
              itemCount: _databaseService.obtenerNotas(asignaturaSeleccionada!).length,
              itemBuilder: (context, index) {
                final nota = _databaseService.obtenerNotas(asignaturaSeleccionada!)[index];
                return ListTile(
                  title: Text('Nota: ${nota.valor.toStringAsFixed(2)}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => mostrarFormularioEditar(context, nota),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => eliminarNota(nota.id),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          if (asignaturaSeleccionada != null) FormularioNotas(
            onSubmit: (valor) => agregarNota(valor),
          ),
        ],
      ),
    );
  }

  void mostrarFormularioEditar(BuildContext context, Nota nota) {
    showDialog(
      context: context,
      builder: (context) {
        return FormularioNotas(
          nota: nota,
          onSubmit: (nuevoValor) => editarNota(nota.id, nuevoValor),
        );
      },
    );
  }
}
