import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../models/funcionario.dart';
import '../widgets/sebo_drawer.dart';

class FuncionariosScreen extends StatefulWidget {
  const FuncionariosScreen({super.key});

  @override
  State<FuncionariosScreen> createState() => _FuncionariosScreenState();
}

class _FuncionariosScreenState extends State<FuncionariosScreen> {
  final TextEditingController _buscaCtrl = TextEditingController();
  List<Funcionario> _filtrados = [];

  @override
  void initState() {
    super.initState();
    _filtrados = List.from(MockData.funcionarios);
  }

  void _filtrar() {
    final busca = _buscaCtrl.text.toLowerCase();
    setState(() {
      _filtrados = MockData.funcionarios.where((f) {
        return busca.isEmpty ||
            f.nome.toLowerCase().contains(busca) ||
            f.funcao.toLowerCase().contains(busca) ||
            f.cpf.contains(busca);
      }).toList();
    });
  }

  void _mostrarCadastro() {
    final nomeCtrl = TextEditingController();
    final emailCtrl = TextEditingController();
    final cpfCtrl = TextEditingController();
    final telCtrl = TextEditingController();
    final senhaCtrl = TextEditingController();
    String funcaoSel = 'Vendedor';

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.person_add, color: Color(0xFF9B59B6)),
              SizedBox(width: 8),
              Text('Novo Funcionário', style: TextStyle(fontSize: 17)),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _input(nomeCtrl, 'Nome Completo', Icons.person),
                const SizedBox(height: 10),
                _input(cpfCtrl, 'CPF (11 dígitos)', Icons.badge, keyboard: TextInputType.number),
                const SizedBox(height: 10),
                _input(emailCtrl, 'E-mail', Icons.email, keyboard: TextInputType.emailAddress),
                const SizedBox(height: 10),
                _input(telCtrl, 'Telefone', Icons.phone, keyboard: TextInputType.phone),
                const SizedBox(height: 10),
                _input(senhaCtrl, 'Senha', Icons.lock, obscure: true),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: funcaoSel,
                  decoration: InputDecoration(
                    labelText: 'Função',
                    prefixIcon: const Icon(Icons.work, size: 20),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'Gerente', child: Text('Gerente')),
                    DropdownMenuItem(value: 'Vendedor', child: Text('Vendedor')),
                  ],
                  onChanged: (v) => setDialogState(() => funcaoSel = v!),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF9B59B6)),
              onPressed: () {
                if (nomeCtrl.text.isEmpty || cpfCtrl.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Nome e CPF são obrigatórios!')),
                  );
                  return;
                }
                final novoId = MockData.funcionarios.isEmpty
                    ? 1
                    : MockData.funcionarios.last.id + 1;
                setState(() {
                  MockData.funcionarios.add(Funcionario(
                    id: novoId,
                    nome: nomeCtrl.text,
                    cpf: cpfCtrl.text,
                    funcao: funcaoSel,
                    email: emailCtrl.text,
                    telefone: telCtrl.text,
                  ));
                  _filtrar();
                });
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Funcionário "${nomeCtrl.text}" cadastrado!'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              child: const Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }

  TextField _input(
    TextEditingController ctrl,
    String label,
    IconData icon, {
    TextInputType? keyboard,
    bool obscure = false,
  }) {
    return TextField(
      controller: ctrl,
      keyboardType: keyboard,
      obscureText: obscure,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, size: 20),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final gerentes = _filtrados.where((f) => f.isGerente).toList();
    final vendedores = _filtrados.where((f) => !f.isGerente).toList();

    return Scaffold(
      // ── AppBar ──────────────────────────────────────────────────────────
      appBar: AppBar(
        title: const Text('Funcionários'),
        actions: [
          Center(
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF9B59B6).withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${_filtrados.length} funcionários',
                style: const TextStyle(
                  color: Color(0xFF9B59B6),
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ],
      ),

      drawer: const SeboDrawer(telaAtual: '/funcionarios'),

      // ── FAB ─────────────────────────────────────────────────────────────
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _mostrarCadastro,
        backgroundColor: const Color(0xFF9B59B6),
        icon: const Icon(Icons.person_add, color: Colors.white),
        label: const Text('Novo Funcionário',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),

      // ── Corpo ────────────────────────────────────────────────────────────
      body: Column(
        children: [
          // Busca
          Container(
            color: const Color(0xFF1A1A2E),
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
            child: TextField(
              controller: _buscaCtrl,
              onChanged: (_) => _filtrar(),
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Buscar por nome ou função...',
                hintStyle: const TextStyle(color: Colors.white38),
                prefixIcon: const Icon(Icons.search, color: Colors.white54),
                suffixIcon: _buscaCtrl.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, color: Colors.white54),
                        onPressed: () {
                          _buscaCtrl.clear();
                          _filtrar();
                        },
                      )
                    : null,
                filled: true,
                fillColor: Colors.white12,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              ),
            ),
          ),

          // Lista de funcionários por cargo
          Expanded(
            child: _filtrados.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.person_search, size: 64, color: Colors.black26),
                        SizedBox(height: 12),
                        Text('Nenhum funcionário encontrado',
                            style: TextStyle(color: Colors.black45)),
                      ],
                    ),
                  )
                : ListView(
                    padding: const EdgeInsets.fromLTRB(12, 12, 12, 90),
                    children: [
                      // Gerentes
                      if (gerentes.isNotEmpty) ...[
                        _GrupoCargo(titulo: 'Gerência', cor: const Color(0xFFFF6B35)),
                        const SizedBox(height: 8),
                        ...gerentes.map((f) => _FuncionarioCard(
                              funcionario: f,
                              onExcluir: () {
                                setState(() {
                                  MockData.funcionarios.removeWhere((ff) => ff.id == f.id);
                                  _filtrar();
                                });
                              },
                            )),
                        const SizedBox(height: 12),
                      ],

                      // Vendedores
                      if (vendedores.isNotEmpty) ...[
                        _GrupoCargo(titulo: 'Equipe de Vendas', cor: const Color(0xFF9B59B6)),
                        const SizedBox(height: 8),
                        ...vendedores.map((f) => _FuncionarioCard(
                              funcionario: f,
                              onExcluir: () {
                                setState(() {
                                  MockData.funcionarios.removeWhere((ff) => ff.id == f.id);
                                  _filtrar();
                                });
                              },
                            )),
                      ],
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}

// ── Widget: Título de grupo ─────────────────────────────────────────────────
class _GrupoCargo extends StatelessWidget {
  final String titulo;
  final Color cor;

  const _GrupoCargo({required this.titulo, required this.cor});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 4, height: 20, color: cor, margin: const EdgeInsets.only(right: 10)),
        Text(
          titulo.toUpperCase(),
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: cor,
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }
}

// ── Widget: Card de Funcionário ─────────────────────────────────────────────
class _FuncionarioCard extends StatelessWidget {
  final Funcionario funcionario;
  final VoidCallback onExcluir;

  const _FuncionarioCard({required this.funcionario, required this.onExcluir});

  @override
  Widget build(BuildContext context) {
    final cor = funcionario.isGerente ? const Color(0xFFFF6B35) : const Color(0xFF9B59B6);

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            // Avatar
            CircleAvatar(
              radius: 26,
              backgroundColor: cor,
              child: Text(
                funcionario.iniciais,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(width: 14),

            // Dados
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          funcionario.nome,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (funcionario.isGerente)
                        const Icon(Icons.star, color: Color(0xFFFF6B35), size: 16),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    funcionario.email,
                    style: const TextStyle(color: Colors.black45, fontSize: 12),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: cor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.work, size: 11, color: cor),
                            const SizedBox(width: 4),
                            Text(
                              funcionario.funcao,
                              style: TextStyle(color: cor, fontSize: 11, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        funcionario.telefoneFormatado,
                        style: const TextStyle(color: Colors.black38, fontSize: 11),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Botão excluir
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Confirmar exclusão'),
                    content: Text('Remover "${funcionario.nome}"?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx),
                        child: const Text('Cancelar'),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                        onPressed: () {
                          Navigator.pop(ctx);
                          onExcluir();
                        },
                        child: const Text('Excluir'),
                      ),
                    ],
                  ),
                );
              },
              child: const Icon(Icons.delete_outline, color: Colors.red, size: 22),
            ),
          ],
        ),
      ),
    );
  }
}
