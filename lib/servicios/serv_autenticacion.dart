import 'package:firebase_auth/firebase_auth.dart';
import '../modelos/usuario.dart';

class Autenticacion {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Método para iniciar sesión
  Future<bool> login(String email, String password) async {
    // Lógica de autenticación con base de datos
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user != null;
    } catch (e) {
      print('Error en el inicio de sesión: $e');
    }
    // Retorna verdadero si el login es exitoso
    return false;
  }

  // Método para registrar usuarios
  Future<bool> registrarUsuario(String email, String password, String nombre, Rol rol) async {
    // Aquí se implementaría la lógica de registro con Firebase u otro servicio
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;

      if (user != null) {
        // Aquí deberías guardar el usuario en tu base de datos (Firestore, por ejemplo) con más detalles.
        // Suponemos que tienes un método para registrar usuarios en tu base de datos
        await DatabaseService().agregarUsuario(Usuario(
          id: user.uid,
          nombre: nombre,
          email: email,
          rol: rol,
        ));
        return true;
      }
      return false;
    } catch (e) {
      print('Error al registrar usuario: $e');
      return false;
    }
  }

  // Obtener el usuario actual desde la base de datos
  Future<Usuario?> obtenerUsuario() async {
    User? user = _auth.currentUser;

    if (user != null) {
      // Obtener el usuario de la base de datos
      Usuario? usuario = await DatabaseService().obtenerUsuario(user.uid);
      return usuario;
    }
    return null;
  }

  // Método para cerrar sesión
  Future<void> cerrarSesion() async {
    await _auth.signOut();
  }
}
