import '../models/asignatura.dart';
import '../models/nota.dart';
import '../models/usuario.dart';

class DatabaseService {
  // Simulaciones de la base de datos
  List<Asignatura> asignaturas = [];
  List<Nota> notas = [];
  List<Usuario> usuarios = [];

  // Métodos para gestionar Asignaturas
  void agregarAsignatura(Asignatura asignatura) {
    asignaturas.add(asignatura);
  }

  void editarAsignatura(String id, String nuevoNombre) {
    final asignatura = asignaturas.firstWhere((asig) => asig.id == id);
    asignatura.nombre = nuevoNombre;
  }

  void eliminarAsignatura(String id) {
    asignaturas.removeWhere((asig) => asig.id == id);
  }

  List<Asignatura> obtenerAsignaturas() {
    return asignaturas;
  }

  // Métodos para gestionar Notas
  void agregarNota(Nota nota) {
    notas.add(nota);
  }

  void editarNota(String id, double nuevoValor) {
    final nota = notas.firstWhere((nota) => nota.id == id);
    nota.valor = nuevoValor;
  }

  void eliminarNota(String id) {
    notas.removeWhere((nota) => nota.id == id);
  }

  List<Nota> obtenerNotas(String asignaturaId) {
    return notas.where((nota) => nota.asignaturaId == asignaturaId).toList();
  }

  // Métodos para gestionar Usuarios
  void agregarUsuario(Usuario usuario) {
    usuarios.add(usuario);
  }

  void editarUsuario(String id, String nuevoNombre, String nuevoEmail, String nuevoRol) {
    final usuario = usuarios.firstWhere((user) => user.id == id);
    usuario.nombre = nuevoNombre;
    usuario.email = nuevoEmail;
    usuario.rol = nuevoRol;
  }

  void eliminarUsuario(String id) {
    usuarios.removeWhere((user) => user.id == id);
  }

  List<Usuario> obtenerUsuarios() {
    return usuarios;
  }
}
