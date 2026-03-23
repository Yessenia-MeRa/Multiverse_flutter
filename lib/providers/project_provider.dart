import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProjectProvider with ChangeNotifier {
  List<Map<String, dynamic>> proyectos = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Cargar proyectos del usuario actual
  Future<void> cargarProyectosUsuario() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    final snapshot = await _firestore
        .collection('projects')
        .where('autorId', isEqualTo: userId)
        .orderBy('fecha', descending: true)
        .get();

    proyectos = snapshot.docs.map((doc) {
      final data = doc.data();
      return {
        "docId": doc.id,
        "titulo": data['titulo'] ?? "Sin título",
        "categoria": data['categoria'] ?? "Sin categoría",
        "introduccion": data['introduccion'] ?? "",
        "capitulos": List.from(data['capitulos'] ?? []),
      };
    }).toList();

    notifyListeners();
  }

  int agregarProyecto(Map<String, dynamic> proyecto) {
    proyectos.add(proyecto);
    notifyListeners();
    return proyectos.length - 1;
  }

  void agregarCapitulo(int index, Map<String, dynamic> capitulo) {
    proyectos[index]['capitulos'].add(capitulo);
    publicarProyecto(index);
    notifyListeners();
  }

  void actualizarProyecto(int index, Map<String, dynamic> datosActualizados) {
    final proyecto = proyectos[index];
    proyecto.addAll(datosActualizados);
    publicarProyecto(index);
    notifyListeners();
  }

  Future<void> publicarProyecto(int index) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    final proyecto = proyectos[index];
    final docId = proyecto['docId'] ?? _firestore.collection('projects').doc().id;

    proyecto['docId'] = docId;

    await _firestore.collection('projects').doc(docId).set({
      "titulo": proyecto['titulo'] ?? "Sin título",
      "categoria": proyecto['categoria'] ?? "Sin categoría",
      "introduccion": proyecto['introduccion'] ?? "",
      "capitulos": proyecto['capitulos'] ?? [],
      "autorId": userId,
      "fecha": FieldValue.serverTimestamp(),
    });

    notifyListeners();
  }
}