class Nota {
  String id;
  String asignaturaId;
  double valor;

  Nota({required this.id, required this.asignaturaId, required this.valor});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'asignaturaId': asignaturaId,
      'valor': valor,
    };
  }

  factory Nota.fromMap(Map<String, dynamic> map) {
    return Nota(
      id: map['id'],
      asignaturaId: map['asignaturaId'],
      valor: map['valor'],
    );
  }
}
