import 'package:flutter/material.dart';
import '../modelos/nota.dart';
import '../servicios/serv_database.dart';
import '../widgets/formulario_notas.dart';

class NotasScreen extends StatefulWidget {
  final String asignaturaId;

  NotasScreen({required this.asignaturaId});

  @override
  _NotasScreenState createState() => _NotasScreenState();
}

class _NotasScreenState extends State<NotasScreen> {
  List<Nota> _notas = [];

  @override
  void initState() {
    super.initState();
    _cargarNotas();
  }

  // Cargar las notas de la asignatura desde la base de datos
  void _cargarNotas() async {
    List<Nota> notas = await DatabaseService().obtenerNotas(widget.asignaturaId);
    setState(() {
      _notas = notas;
    });
  }

  // Función para agregar una nueva nota
  void _agregarNota(Nota nota) async {
    await DatabaseService().agregarNota(widget.asignaturaId, nota);
    _cargarNotas();
  }

  // Función para eliminar una nota
  void _eliminarNota(String notaId) async {
    await DatabaseService().eliminarNota(widget.asignaturaId, notaId);
    _cargarNotas();
  }

  // Crear formulario para agregar una nota
  Future<void> _mostrarFormularioAgregarNota() async {
    Nota? nuevaNota = await showDialog<Nota>(
      context: context,
      builder: (context) {
        return FormularioNotas();
      },
    );
    if (nuevaNota != null) {
      _agregarNota(nuevaNota);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestión de Notas'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _mostrarFormularioAgregarNota,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _notas.length,
        itemBuilder: (context, index) {
          final nota = _notas[index];
          return ListTile(
            title: Text('Nota: ${nota.valor}'),
            subtitle: Text(nota.descripcion),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _eliminarNota(nota.id),
            ),
          );
        },
      ),
    );
  }
}
