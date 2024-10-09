import 'package:flutter/material.dart';
import '/backend/models/nota.dart';

class FormularioNotas extends StatefulWidget {
  final Nota? nota;
  final Function(double) onSubmit;

  FormularioNotas({this.nota, required this.onSubmit});

  @override
  _FormularioNotasState createState() => _FormularioNotasState();
}

class _FormularioNotasState extends State<FormularioNotas> {
  final _valorController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.nota != null) {
      _valorController.text = widget.nota!.valor.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextFormField(
            controller: _valorController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Nota'),
          ),
          ElevatedButton(
            onPressed: () {
              widget.onSubmit(double.parse(_valorController.text));
              Navigator.pop(context);
            },
            child: Text(widget.nota == null ? 'Agregar' : 'Editar'),
          ),
        ],
      ),
    );
  }
}
