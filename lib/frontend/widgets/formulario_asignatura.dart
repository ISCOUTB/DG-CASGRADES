import 'package:flutter/material.dart';
import '/backend/models/asignatura.dart';

class FormularioAsignatura extends StatefulWidget {
  final Asignatura? asignatura;
  final Function(String) onSubmit;

  FormularioAsignatura({this.asignatura, required this.onSubmit});

  @override
  _FormularioAsignaturaState createState() => _FormularioAsignaturaState();
}

class _FormularioAsignaturaState extends State<FormularioAsignatura> {
  final _nombreController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.asignatura != null) {
      _nombreController.text = widget.asignatura!.nombre;
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
            decoration: InputDecoration(labelText: 'Nombre de la Asignatura'),
          ),
          ElevatedButton(
            onPressed: () {
              widget.onSubmit(_nombreController.text);
              Navigator.pop(context);
            },
            child: Text(widget.asignatura == null ? 'Agregar' : 'Editar'),
          ),
        ],
      ),
    );
  }
}
