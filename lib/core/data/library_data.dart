import 'package:flutter/material.dart';

class LibraryData {

  static ValueNotifier<List<Map<String, dynamic>>> favoritos = ValueNotifier([]);

  static void addBook(Map<String, dynamic> novela) {
    favoritos.value = [...favoritos.value, novela];
  }

  static void removeBook(Map<String, dynamic> novela) {
    favoritos.value = favoritos.value.where((n) => n != novela).toList();
  }

  static List<Map<String, dynamic>> getBooks() => favoritos.value;
}