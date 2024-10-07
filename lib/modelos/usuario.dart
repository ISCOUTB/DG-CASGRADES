enum Rol { estudiante, profesor, administrador }

class Usuario {
  String id;
  String nombre;
  String email;
  Rol rol; // estudiante, profesor, administrador

  Usuario({required this.id, required this.nombre, required this.email, required this.rol});
}
