import 'package:flutter/material.dart';
import 'package:login/core/data/novelas_data.dart';

class LibraryData {
  static ValueNotifier<List<Novela>> favoritos = ValueNotifier([]);

  static void addBook(Novela novela) {
    favoritos.value = [...favoritos.value, novela];
  }

  static void removeBook(Novela novela) {
    favoritos.value = favoritos.value.where((n) => n != novela).toList();
  }

  static List<Novela> getBooks() => favoritos.value;
}