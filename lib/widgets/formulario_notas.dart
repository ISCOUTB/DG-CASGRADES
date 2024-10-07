import 'package:flutter/material.dart';
import '../modelos/nota.dart';

class FormularioNotas extends StatefulWidget {
  final Function(Nota) onSubmit;

  FormularioNotas({required this.onSubmit});

  @override
  _FormularioNotasState createState() => _FormularioNotasState();
}

class _FormularioNotasState extends State<FormularioNotas> {
  final _descripcionController = TextEditingController();
  final _valorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: _descripcionController,
          decoration: InputDecoration(labelText: 'Descripción de la nota'),
        ),
        TextFormField(
          controller: _valorController,
          decoration: InputDecoration(labelText: 'Valor'),
          keyboardType: TextInputType.number,
        ),
        ElevatedButton(
          onPressed: () {
            final nota = Nota(
              id: DateTime.now().toString(),
              calificacion: double.parse(_valorController.text),
              descripcion: _descripcionController.text,
            );
            widget.onSubmit(nota);
          },
          child: Text('Agregar Nota'),
        ),
      ],
    );
  }
}
