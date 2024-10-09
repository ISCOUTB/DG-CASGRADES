import '../models/usuario.dart';

class AutenticacionService {
  Usuario? usuarioActual;

  bool iniciarSesion(String email, String password) {
    // Lógica para iniciar sesión (simulación)
    if (email == 'admin@example.com' && password == 'admin') {
      usuarioActual = Usuario(id: '1', nombre: 'Admin', email: email, rol: 'administrador');
      return true;
    } else if (email == 'prof@example.com' && password == 'prof') {
      usuarioActual = Usuario(id: '2', nombre: 'Profesor', email: email, rol: 'profesor');
      return true;
    } else if (email == 'estudiante@example.com' && password == 'est') {
      usuarioActual = Usuario(id: '3', nombre: 'Estudiante', email: email, rol: 'estudiante');
      return true;
    }
    return false;
  }

  void cerrarSesion() {
    usuarioActual = null;
  }

  bool estaAutenticado() {
    return usuarioActual != null;
  }

  String obtenerRol() {
    return usuarioActual?.rol ?? 'invitado';
  }
}
