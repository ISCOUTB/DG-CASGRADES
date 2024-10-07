import 'package:flutter/material.dart';
import 'package:flutter_app_casgrades/modelos/nota.dart';

class AverageScreen extends StatelessWidget {
  final List<Nota> grades;

  AverageScreen({required this.grades});

  double _calculateAverage() {
    if (grades.isEmpty) return 0.0;
    double total = grades.fold(0, (sum, item) => sum + item.calificacion);
    return total / grades.length;
  }

  @override
  Widget build(BuildContext context) {
    double average = _calculateAverage();

    return Scaffold(
      appBar: AppBar(
        title: Text('Promedio de Notas'),
      ),
      body: Center(
        child: Text(
          'El promedio es: ${average.toStringAsFixed(2)}',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
