import '../models/livro.dart';
import '../models/cliente.dart';
import '../models/funcionario.dart';

class MockData {
  // ─── ACERVO (LIVROS) ──────────────────────────────────────────────────────
  static List<Livro> livros = [
    Livro(id: 1, titulo: 'Dom Casmurro', autor: 'Machado de Assis', ano: 1899, preco: 15.00, estado: 'bom', responsavel: 'João Victor'),
    Livro(id: 2, titulo: 'O Cortiço', autor: 'Aluísio Azevedo', ano: 1890, preco: 12.00, estado: 'regular', responsavel: 'Micael'),
    Livro(id: 3, titulo: 'Grande Sertão: Veredas', autor: 'João Guimarães Rosa', ano: 1956, preco: 22.00, estado: 'ótimo', responsavel: 'João Victor'),
    Livro(id: 4, titulo: 'Capitães da Areia', autor: 'Jorge Amado', ano: 1937, preco: 18.00, estado: 'bom', responsavel: 'Pedro'),
    Livro(id: 5, titulo: 'A Hora da Estrela', autor: 'Clarice Lispector', ano: 1977, preco: 20.00, estado: 'ótimo', responsavel: 'Micael'),
    Livro(id: 6, titulo: 'Vidas Secas', autor: 'Graciliano Ramos', ano: 1938, preco: 14.00, estado: 'regular', responsavel: 'Tiago'),
    Livro(id: 7, titulo: 'Memórias Póstumas de Brás Cubas', autor: 'Machado de Assis', ano: 1881, preco: 16.00, estado: 'bom', responsavel: 'João Victor'),
    Livro(id: 8, titulo: 'São Bernardo', autor: 'Graciliano Ramos', ano: 1934, preco: 13.00, estado: 'bom', responsavel: 'Pedro'),
    Livro(id: 9, titulo: 'Iracema', autor: 'José de Alencar', ano: 1865, preco: 10.00, estado: 'ruim', responsavel: 'Tiago'),
    Livro(id: 10, titulo: 'O Tempo e o Vento', autor: 'Erico Verissimo', ano: 1949, preco: 25.00, estado: 'ótimo', responsavel: 'Micael'),
    Livro(id: 11, titulo: 'A Pedra do Reino', autor: 'Ariano Suassuna', ano: 1971, preco: 30.00, estado: 'ótimo', responsavel: 'João Victor'),
    Livro(id: 12, titulo: 'Quincas Borba', autor: 'Machado de Assis', ano: 1891, preco: 17.00, estado: 'bom', responsavel: 'Pedro'),
    Livro(id: 13, titulo: 'O Senhor dos Anéis', autor: 'J.R.R. Tolkien', ano: 1954, preco: 35.00, estado: 'ótimo', responsavel: 'Tiago'),
    Livro(id: 14, titulo: 'Harry Potter e a Pedra Filosofal', autor: 'J.K. Rowling', ano: 1997, preco: 28.00, estado: 'bom', responsavel: 'Micael'),
    Livro(id: 15, titulo: '1984', autor: 'George Orwell', ano: 1949, preco: 19.00, estado: 'regular', responsavel: 'João Victor'),
  ];

  // ─── CLIENTES ─────────────────────────────────────────────────────────────
  static List<Cliente> clientes = [
    Cliente(id: 1, nome: 'Ana Paula Silva', cpf: '12345678901', email: 'ana.silva@email.com', telefone: '81991234567', totalCompras: 5, totalGasto: 112.50),
    Cliente(id: 2, nome: 'Carlos Eduardo Santos', cpf: '98765432100', email: 'carlos.santos@email.com', telefone: '81982345678', totalCompras: 3, totalGasto: 67.00),
    Cliente(id: 3, nome: 'Fernanda Oliveira', cpf: '11122233344', email: 'fernanda.oli@email.com', telefone: '81973456789', totalCompras: 8, totalGasto: 230.00),
    Cliente(id: 4, nome: 'Roberto Alves Costa', cpf: '55566677788', email: 'roberto.costa@email.com', telefone: '81964567890', totalCompras: 2, totalGasto: 45.00),
    Cliente(id: 5, nome: 'Juliana Mendes', cpf: '33344455566', email: 'juliana.mendes@email.com', telefone: '81955678901', totalCompras: 12, totalGasto: 340.00),
    Cliente(id: 6, nome: 'Marcos Antonio Lima', cpf: '77788899900', email: 'marcos.lima@email.com', telefone: '81946789012', totalCompras: 1, totalGasto: 18.00),
    Cliente(id: 7, nome: 'Patrícia Ferreira', cpf: '22233344455', email: 'patricia.f@email.com', telefone: '81937890123', totalCompras: 6, totalGasto: 155.00),
    Cliente(id: 8, nome: 'Lucas Rodrigues', cpf: '66677788899', email: 'lucas.rodrigues@email.com', telefone: '81928901234', totalCompras: 4, totalGasto: 88.50),
  ];

  // ─── FUNCIONÁRIOS ─────────────────────────────────────────────────────────
  static List<Funcionario> funcionarios = [
    Funcionario(id: 1, nome: 'João Victor Sena', cpf: '00000000000', funcao: 'Gerente', email: 'joao.sena@sebolinhas.com', telefone: '81991112233'),
    Funcionario(id: 2, nome: 'Micael Vasconcelos', cpf: '11111111111', funcao: 'Vendedor', email: 'micael.v@sebolinhas.com', telefone: '81982223344'),
    Funcionario(id: 3, nome: 'Samuel Carlos Correia', cpf: '22222222222', funcao: 'Vendedor', email: 'pedro.moreira@sebolinhas.com', telefone: '81973334455'),
    Funcionario(id: 4, nome: 'Tiago Kauã', cpf: '33333333333', funcao: 'Vendedor', email: 'tiago.kaua@sebolinhas.com', telefone: '81964445566'),
  ];

  // ─── ESTATÍSTICAS ─────────────────────────────────────────────────────────
  static Map<String, dynamic> get estatisticas => {
    'totalLivros': livros.length,
    'totalClientes': clientes.length,
    'totalFuncionarios': funcionarios.length,
    'faturamentoMes': 892.50,
    'vendasMes': 23,
    'livrosOtimo': livros.where((l) => l.estado == 'ótimo').length,
  };
}
