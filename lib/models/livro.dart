import 'package:flutter/material.dart';

class Livro {
  final int id;
  final String titulo;
  final String autor;
  final int ano;
  final double preco;
  final String estado;
  final String responsavel;

  Livro({
    required this.id,
    required this.titulo,
    required this.autor,
    required this.ano,
    required this.preco,
    required this.estado,
    required this.responsavel,
  });

  String get estadoLabel {
    switch (estado.toLowerCase()) {
      case 'otimo':
      case 'ótimo':
        return 'Ótimo';
      case 'bom':
        return 'Bom';
      case 'regular':
        return 'Regular';
      case 'ruim':
        return 'Ruim';
      default:
        return estado;
    }
  }

  Color get estadoColor {
    switch (estado.toLowerCase()) {
      case 'otimo':
      case 'ótimo':
        return const Color(0xFF2ECC71);
      case 'bom':
        return const Color(0xFF3498DB);
      case 'regular':
        return const Color(0xFFF39C12);
      case 'ruim':
        return const Color(0xFFE74C3C);
      default:
        return const Color(0xFF7F8C8D);
    }
  }
}
