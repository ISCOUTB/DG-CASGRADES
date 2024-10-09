class Asignatura {
  String id;
  String nombre;

  Asignatura({required this.id, required this.nombre});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
    };
  }

  factory Asignatura.fromMap(Map<String, dynamic> map) {
    return Asignatura(
      id: map['id'],
      nombre: map['nombre'],
    );
  }
}
