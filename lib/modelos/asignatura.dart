import 'package:flutter_app_casgrades/modelos/nota.dart';

class Asignatura {
  String id;
  String nombre;
  List<Nota> notas;

  Asignatura({required this.id, required this.nombre, required this.notas});

  // Método para calcular el promedio de la asignatura
  double calcularPromedio() {
    if (notas.isEmpty) return 0;
    double total = notas.fold(0, (sum, nota) => sum + nota.calificacion);
    return total / notas.length;
  }
}
