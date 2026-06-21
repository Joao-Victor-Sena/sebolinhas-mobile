import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../models/cliente.dart';
import '../widgets/sebo_drawer.dart';

class ClientesScreen extends StatefulWidget {
  const ClientesScreen({super.key});

  @override
  State<ClientesScreen> createState() => _ClientesScreenState();
}

class _ClientesScreenState extends State<ClientesScreen> {
  final TextEditingController _buscaCtrl = TextEditingController();
  List<Cliente> _clientesFiltrados = [];

  @override
  void initState() {
    super.initState();
    _clientesFiltrados = List.from(MockData.clientes);
  }

  void _filtrar() {
    final busca = _buscaCtrl.text.toLowerCase();
    setState(() {
      _clientesFiltrados = MockData.clientes.where((c) {
        return busca.isEmpty ||
            c.nome.toLowerCase().contains(busca) ||
            c.email.toLowerCase().contains(busca) ||
            c.cpf.contains(busca);
      }).toList();
    });
  }

  void _mostrarCadastro() {
    final nomeCtrl = TextEditingController();
    final emailCtrl = TextEditingController();
    final cpfCtrl = TextEditingController();
    final telCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.person_add, color: Color(0xFF2ECC71)),
            SizedBox(width: 8),
            Text('Novo Cliente', style: TextStyle(fontSize: 18)),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _input(nomeCtrl, 'Nome Completo', Icons.person),
              const SizedBox(height: 10),
              _input(emailCtrl, 'E-mail', Icons.email, keyboard: TextInputType.emailAddress),
              const SizedBox(height: 10),
              _input(cpfCtrl, 'CPF (somente números)', Icons.badge, keyboard: TextInputType.number),
              const SizedBox(height: 10),
              _input(telCtrl, 'Telefone (DDD + número)', Icons.phone, keyboard: TextInputType.phone),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2ECC71)),
            onPressed: () {
              if (nomeCtrl.text.isEmpty || cpfCtrl.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Nome e CPF são obrigatórios!')),
                );
                return;
              }
              final novoId = MockData.clientes.isEmpty ? 1 : MockData.clientes.last.id + 1;
              setState(() {
                MockData.clientes.add(Cliente(
                  id: novoId,
                  nome: nomeCtrl.text,
                  cpf: cpfCtrl.text,
                  email: emailCtrl.text,
                  telefone: telCtrl.text,
                ));
                _filtrar();
              });
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Cliente "${nomeCtrl.text}" cadastrado!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Cadastrar'),
          ),
        ],
      ),
    );
  }

  TextField _input(TextEditingController ctrl, String label, IconData icon,
      {TextInputType? keyboard}) {
    return TextField(
      controller: ctrl,
      keyboardType: keyboard,
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
    return Scaffold(
      // ── AppBar ──────────────────────────────────────────────────────────
      appBar: AppBar(
        title: const Text('Clientes'),
        actions: [
          Center(
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF2ECC71).withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${_clientesFiltrados.length} clientes',
                style: const TextStyle(
                  color: Color(0xFF2ECC71),
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ],
      ),

      drawer: const SeboDrawer(telaAtual: '/clientes'),

      // ── FAB ─────────────────────────────────────────────────────────────
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _mostrarCadastro,
        backgroundColor: const Color(0xFF2ECC71),
        icon: const Icon(Icons.person_add, color: Colors.white),
        label: const Text('Novo Cliente',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),

      // ── Corpo ────────────────────────────────────────────────────────────
      body: Column(
        children: [
          // Banner informativo com dica da Tela 2.1
          Container(
            color: const Color(0xFF1A1A2E),
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
            child: Column(
              children: [
                // Busca
                TextField(
                  controller: _buscaCtrl,
                  onChanged: (_) => _filtrar(),
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Buscar por nome, CPF ou e-mail...',
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
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.info_outline, color: Colors.white38, size: 14),
                    const SizedBox(width: 6),
                    const Text(
                      'Toque em um cliente para ver os detalhes (Tela 2.1)',
                      style: TextStyle(color: Colors.white38, fontSize: 11),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Lista de clientes
          Expanded(
            child: _clientesFiltrados.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.person_search, size: 64, color: Colors.black26),
                        SizedBox(height: 12),
                        Text('Nenhum cliente encontrado',
                            style: TextStyle(color: Colors.black45)),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(12, 12, 12, 90),
                    itemCount: _clientesFiltrados.length,
                    itemBuilder: (context, index) {
                      final cliente = _clientesFiltrados[index];
                      return _ClienteCard(
                        cliente: cliente,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/detalhe_cliente',
                            arguments: cliente,
                          );
                        },
                        onExcluir: () {
                          setState(() {
                            MockData.clientes.removeWhere((c) => c.id == cliente.id);
                            _filtrar();
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Cliente "${cliente.nome}" removido.'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

// ── Widget: Card de Cliente ─────────────────────────────────────────────────
class _ClienteCard extends StatelessWidget {
  final Cliente cliente;
  final VoidCallback onTap;
  final VoidCallback onExcluir;

  const _ClienteCard({
    required this.cliente,
    required this.onTap,
    required this.onExcluir,
  });

  static const List<Color> _avatarColors = [
    Color(0xFF3498DB),
    Color(0xFF2ECC71),
    Color(0xFFFF6B35),
    Color(0xFF9B59B6),
    Color(0xFFE67E22),
    Color(0xFF1ABC9C),
  ];

  @override
  Widget build(BuildContext context) {
    final cor = _avatarColors[cliente.id % _avatarColors.length];

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              // Avatar com iniciais
              CircleAvatar(
                radius: 26,
                backgroundColor: cor,
                child: Text(
                  cliente.iniciais,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(width: 14),

              // Dados do cliente
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cliente.nome,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      cliente.email,
                      style: const TextStyle(color: Colors.black45, fontSize: 12),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        _badge(Icons.shopping_bag, '${cliente.totalCompras} compras', cor),
                        const SizedBox(width: 8),
                        _badge(
                          Icons.attach_money,
                          'R\$ ${cliente.totalGasto.toStringAsFixed(2).replaceAll('.', ',')}',
                          const Color(0xFF2ECC71),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Seta e botão excluir
              Column(
                children: [
                  const Icon(Icons.arrow_forward_ios, size: 14, color: Color(0xFF2ECC71)),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text('Confirmar exclusão'),
                          content: Text('Remover "${cliente.nome}"?'),
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
                    child: const Icon(Icons.delete_outline, color: Colors.red, size: 20),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _badge(IconData icon, String text, Color cor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: cor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 11, color: cor),
          const SizedBox(width: 3),
          Text(text, style: TextStyle(color: cor, fontSize: 11, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
