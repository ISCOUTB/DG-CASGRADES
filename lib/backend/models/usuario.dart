class Usuario {
  String id;
  String nombre;
  String email;
  String rol; // estudiante, profesor, administrador

  Usuario({required this.id, required this.nombre, required this.email, required this.rol});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'email': email,
      'rol': rol,
    };
  }

  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      id: map['id'],
      nombre: map['nombre'],
      email: map['email'],
      rol: map['rol'],
    );
  }
}
