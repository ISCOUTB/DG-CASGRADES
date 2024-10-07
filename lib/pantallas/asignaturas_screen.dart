import 'package:flutter/material.dart';
import '../modelos/asignatura.dart';
import '../servicios/serv_database.dart';
import '../widgets/formulario_notas.dart';

class AsignaturasScreen extends StatefulWidget {
  @override
  _AsignaturasScreenState createState() => _AsignaturasScreenState();
}

class _AsignaturasScreenState extends State<AsignaturasScreen> {
  List<Asignatura> _asignaturas = [];

  @override
  void initState() {
    super.initState();
    _cargarAsignaturas();
  }

  // Cargar las asignaturas desde la base de datos
  void _cargarAsignaturas() async {
    String userId = "example_user_id";  // Este ID debe ser dinámico
    List<Asignatura> asignaturas = await DatabaseService().obtenerAsignaturas(userId);
    setState(() {
      _asignaturas = asignaturas;
    });
  }

  // Función para agregar una nueva asignatura
  void _agregarAsignatura(String nombre) async {
    String userId = "example_user_id";  // Reemplazar por el ID real del usuario
    Asignatura nuevaAsignatura = Asignatura(id: DateTime.now().toString(), nombre: nombre, notas: []);
    await DatabaseService().agregarAsignatura(nuevaAsignatura, userId);
    _cargarAsignaturas();
  }

  // Función para eliminar una asignatura
  void _eliminarAsignatura(String asignaturaId) async {
    await DatabaseService().eliminarAsignatura(asignaturaId);
    _cargarAsignaturas();
  }

  // Crear formulario para agregar una asignatura
  Future<void> _mostrarFormularioAgregar() async {
    String? nombreAsignatura = await showDialog<String>(
      context: context,
      builder: (context) {
        TextEditingController _nombreController = TextEditingController();
        return AlertDialog(
          title: Text('Agregar Asignatura'),
          content: TextFormField(
            controller: _nombreController,
            decoration: InputDecoration(labelText: 'Nombre de la asignatura'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(_nombreController.text),
              child: Text('Agregar'),
            ),
          ],
        );
      },
    );
    if (nombreAsignatura != null && nombreAsignatura.isNotEmpty) {
      _agregarAsignatura(nombreAsignatura);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestión de Asignaturas'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _mostrarFormularioAgregar,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _asignaturas.length,
        itemBuilder: (context, index) {
          final asignatura = _asignaturas[index];
          return ListTile(
            title: Text(asignatura.nombre),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _eliminarAsignatura(asignatura.id),
            ),
            onTap: () {
              // Aquí puedes implementar la navegación a la pantalla de detalles de la asignatura
            },
          );
        },
      ),
    );
  }
}
