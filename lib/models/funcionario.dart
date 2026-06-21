class Funcionario {
  final int id;
  final String nome;
  final String cpf;
  final String funcao;
  final String email;
  final String telefone;

  Funcionario({
    required this.id,
    required this.nome,
    required this.cpf,
    required this.funcao,
    required this.email,
    required this.telefone,
  });

  String get cpfFormatado {
    final digits = cpf.replaceAll(RegExp(r'\D'), '');
    if (digits.length == 11) {
      return '${digits.substring(0, 3)}.${digits.substring(3, 6)}.${digits.substring(6, 9)}-${digits.substring(9, 11)}';
    }
    return cpf;
  }

  String get telefoneFormatado {
    final digits = telefone.replaceAll(RegExp(r'\D'), '');
    if (digits.length == 11) {
      return '(${digits.substring(0, 2)}) ${digits.substring(2, 7)}-${digits.substring(7, 11)}';
    }
    return telefone;
  }

  String get iniciais {
    final partes = nome.trim().split(' ');
    if (partes.length >= 2) {
      return '${partes.first[0]}${partes.last[0]}'.toUpperCase();
    }
    return nome.isNotEmpty ? nome[0].toUpperCase() : '?';
  }

  bool get isGerente => funcao.toLowerCase() == 'gerente' ||
      funcao.toLowerCase() == 'admin' ||
      funcao.toLowerCase() == 'administrador';
}
