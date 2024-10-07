import 'package:cloud_firestore/cloud_firestore.dart';
import '../modelos/asignatura.dart';
import '../modelos/nota.dart';
import '../modelos/usuario.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  // Métodos para interactuar con la base de datos.
  
  // Obtener la lista de asignaturas desde la base de datos
  Future<List<Asignatura>> obtenerAsignaturas(String userId) async {
    // Lógica para obtener las asignaturas
    try {
      QuerySnapshot asignaturasSnapshot = await _db.collection('asignaturas').where('usuarioId', isEqualTo: userId).get();
      return asignaturasSnapshot.docs.map((doc) {
        return Asignatura(
          id: doc.id,
          nombre: doc['nombre'],
          notas: (doc['notas'] as List).map((notaData) => Nota(
            id: notaData['id'],
            calificacion: notaData['calificacion'],
            descripcion: notaData['descripcion'],
          )).toList(),
        );
      }).toList();
    } catch (e) {
      print('Error al obtener asignaturas: $e');
      return [];
    }
  }

  // Agregar una nueva asignatura
  Future<void> agregarAsignatura(Asignatura asignatura, String userId) async {
    // Lógica para agregar una asignatura
    try {
      await _db.collection('asignaturas').add({
        'usuarioId': userId,
        'nombre': asignatura.nombre,
        'notas': asignatura.notas.map((nota) => {
          'id': nota.id,
          'valor': nota.calificacion,
          'descripcion': nota.descripcion,
        }).toList(),
      });
    } catch (e) {
      print('Error al agregar asignatura: $e');
    }
  }

  // Eliminar una asignatura
  Future<void> eliminarAsignatura(String id) async {
    // Lógica para eliminar una asignatura
    try {
      await _db.collection('asignaturas').doc(asignaturaId).delete();
    } catch (e) {
      print('Error al eliminar asignatura: $e');
    }
  }

  // Obtener todas las notas de una asignatura
  Future<List<Nota>> obtenerNotas(String asignaturaId) async {
    try {
      DocumentSnapshot asignaturaDoc = await _db.collection('asignaturas').doc(asignaturaId).get();
      List<dynamic> notasData = asignaturaDoc['notas'];
      return notasData.map((nota) => Nota(
        id: nota['id'],
        calificacion: nota['valor'],
        descripcion: nota['descripcion'],
      )).toList();
    } catch (e) {
      print('Error al obtener notas: $e');
      return [];
    }
  }

  // Agregar una nota a una asignatura
  Future<void> agregarNota(String asignaturaId, Nota nota) async {
    // Lógica para agregar una nota
    try {
      DocumentReference asignaturaRef = _db.collection('asignaturas').doc(asignaturaId);
      await asignaturaRef.update({
        'notas': FieldValue.arrayUnion([{
          'id': nota.id,
          'valor': nota.calificacion,
          'descripcion': nota.descripcion,
        }])
      });
    } catch (e) {
      print('Error al agregar nota: $e');
    }
  }

  // Actualizar una nota existente
  Future<void> actualizarNota(String asignaturaId, Nota notaActualizada) async {
    try {
      DocumentReference asignaturaRef = _db.collection('asignaturas').doc(asignaturaId);
      DocumentSnapshot asignaturaDoc = await asignaturaRef.get();
      List<dynamic> notasData = asignaturaDoc['notas'];

      List<dynamic> nuevasNotas = notasData.map((nota) {
        if (nota['id'] == notaActualizada.id) {
          return {
            'id': notaActualizada.id,
            'valor': notaActualizada.calificacion,
            'descripcion': notaActualizada.descripcion,
          };
        }
        return nota;
      }).toList();

      await asignaturaRef.update({
        'notas': nuevasNotas,
      });
    } catch (e) {
      print('Error al actualizar nota: $e');
    }
  }

    // Eliminar una nota específica de una asignatura
  Future<void> eliminarNota(String asignaturaId, String notaId) async {
    try {
      // Referencia al documento de la asignatura
      DocumentReference asignaturaRef = _db.collection('asignaturas').doc(asignaturaId);

      // Obtener la asignatura
      DocumentSnapshot asignaturaDoc = await asignaturaRef.get();
      List<dynamic> notasData = asignaturaDoc['notas'];

      // Filtrar la lista de notas eliminando la nota con el ID proporcionado
      List<dynamic> nuevasNotas = notasData.where((nota) => nota['id'] != notaId).toList();

      // Actualizar la asignatura con la nueva lista de notas
      await asignaturaRef.update({
        'notas': nuevasNotas,
      });
    } catch (e) {
      print('Error al eliminar nota: $e');
    }
  }

  // Obtener los detalles de un usuario específico
  Future<Usuario?> obtenerUsuario(String id) async {
    try {
      DocumentSnapshot usuarioDoc = await _db.collection('usuarios').doc(id).get();
      if (usuarioDoc.exists) {
        String rolString = usuarioDoc['rol'];
        Rol rol = Rol.values.firstWhere((e) => e.toString() == 'Rol.$rolString');
        return Usuario(
          id: usuarioDoc.id,
          nombre: usuarioDoc['nombre'],
          email: usuarioDoc['email'],
          rol: rol,
        );
      }
      return null;
    } catch (e) {
      print('Error al obtener usuario: $e');
      return null;
    }
  }

  // Agregar un nuevo usuario (para el registro)
  Future<void> agregarUsuario(Usuario usuario) async {
    try {
      await _db.collection('usuarios').doc(usuario.id).set({
        'nombre': usuario.nombre,
        'email': usuario.email,
        'rol': usuario.rol.toString().split('.').last,
      });
    } catch (e) {
      print('Error al agregar usuario: $e');
    }
  }

  // Método para eliminar un usuario de la base de datos
  Future<void> eliminarUsuario(String usuarioId) async {
    try {
      await _db.collection('usuarios').doc(usuarioId).delete();
      print('Usuario eliminado correctamente');
    } catch (e) {
      print('Error al eliminar usuario: $e');
    }
  }

  // ... más métodos para las operaciones CRUD.
}
