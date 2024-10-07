import 'package:flutter/material.dart';
import 'package:flutter_app_casgrades/modelos/asignatura.dart';

class SubjectList extends StatelessWidget {
  final List<Asignatura> subjects;

  SubjectList({required this.subjects});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: subjects.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(subjects[index].nombre),
          subtitle: Text('Créditos: ${subjects[index].credits}'),
          onTap: () {
            Navigator.pushNamed(context, '/grades', arguments: subjects[index]);
          },
        );
      },
    );
  }
}
