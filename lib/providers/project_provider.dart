import 'package:flutter/material.dart';

class ProjectProvider extends ChangeNotifier {
  List<Map<String, dynamic>> proyectos = [];

  int agregarProyecto(Map<String, dynamic> proyecto) {
    proyecto['capitulos'] = []; 
    proyectos.add(proyecto);
    notifyListeners();
    return proyectos.length - 1; 
  }

  void actualizarProyecto(int index, Map<String, dynamic> proyecto) {
    proyectos[index] = proyecto;
    notifyListeners();
  }

  void agregarCapitulo(int index, Map<String, String> capitulo) {
    if (proyectos[index]['capitulos'] == null) {
      proyectos[index]['capitulos'] = [];
    }
    proyectos[index]['capitulos'].add(capitulo);
    notifyListeners();
  }
}