import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../models/livro.dart';
import '../widgets/sebo_drawer.dart';

class AcervoScreen extends StatefulWidget {
  const AcervoScreen({super.key});

  @override
  State<AcervoScreen> createState() => _AcervoScreenState();
}

class _AcervoScreenState extends State<AcervoScreen> {
  final TextEditingController _buscaCtrl = TextEditingController();
  List<Livro> _livrosFiltrados = [];
  String _filtroEstado = 'Todos';

  final List<String> _estados = ['Todos', 'Ótimo', 'Bom', 'Regular', 'Ruim'];

  @override
  void initState() {
    super.initState();
    _livrosFiltrados = List.from(MockData.livros);
  }

  void _filtrar() {
    final busca = _buscaCtrl.text.toLowerCase();
    setState(() {
      _livrosFiltrados = MockData.livros.where((l) {
        final matchBusca = busca.isEmpty ||
            l.titulo.toLowerCase().contains(busca) ||
            l.autor.toLowerCase().contains(busca);
        final matchEstado = _filtroEstado == 'Todos' ||
            l.estadoLabel.toLowerCase() == _filtroEstado.toLowerCase();
        return matchBusca && matchEstado;
      }).toList();
    });
  }

  void _mostrarCadastro() {
    final tituloCtrl = TextEditingController();
    final autorCtrl = TextEditingController();
    final anoCtrl = TextEditingController();
    final precoCtrl = TextEditingController();
    String estadoSel = 'bom';

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.add_circle, color: Color(0xFFFF6B35)),
              SizedBox(width: 8),
              Text('Cadastrar Livro', style: TextStyle(fontSize: 18)),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: tituloCtrl,
                  decoration: _inputDec('Título', Icons.title),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: autorCtrl,
                  decoration: _inputDec('Autor', Icons.person),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: anoCtrl,
                        keyboardType: TextInputType.number,
                        decoration: _inputDec('Ano', Icons.calendar_today),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: precoCtrl,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        decoration: _inputDec('Preço (R\$)', Icons.attach_money),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: estadoSel,
                  decoration: _inputDec('Estado de Conservação', Icons.star),
                  items: const [
                    DropdownMenuItem(value: 'ótimo', child: Text('Ótimo')),
                    DropdownMenuItem(value: 'bom', child: Text('Bom')),
                    DropdownMenuItem(value: 'regular', child: Text('Regular')),
                    DropdownMenuItem(value: 'ruim', child: Text('Ruim')),
                  ],
                  onChanged: (v) => setDialogState(() => estadoSel = v!),
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
              onPressed: () {
                if (tituloCtrl.text.isEmpty || autorCtrl.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Preencha todos os campos obrigatórios!')),
                  );
                  return;
                }
                final novoId = MockData.livros.isEmpty ? 1 : MockData.livros.last.id + 1;
                setState(() {
                  MockData.livros.add(Livro(
                    id: novoId,
                    titulo: tituloCtrl.text,
                    autor: autorCtrl.text,
                    ano: int.tryParse(anoCtrl.text) ?? DateTime.now().year,
                    preco: double.tryParse(precoCtrl.text.replaceAll(',', '.')) ?? 0.0,
                    estado: estadoSel,
                    responsavel: 'João Victor',
                  ));
                  _filtrar();
                });
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Livro "${tituloCtrl.text}" cadastrado!'),
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

  InputDecoration _inputDec(String label, IconData icon) => InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, size: 20),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ── AppBar ──────────────────────────────────────────────────────────
      appBar: AppBar(
        title: const Text('Acervo de Livros'),
        actions: [
          Center(
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFFF6B35).withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${_livrosFiltrados.length} livros',
                style: const TextStyle(color: Color(0xFFFF6B35), fontWeight: FontWeight.bold, fontSize: 13),
              ),
            ),
          ),
        ],
      ),

      drawer: const SeboDrawer(telaAtual: '/acervo'),

      // ── FAB ─────────────────────────────────────────────────────────────
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _mostrarCadastro,
        backgroundColor: const Color(0xFFFF6B35),
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Novo Livro', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),

      // ── Corpo ────────────────────────────────────────────────────────────
      body: Column(
        children: [
          // Barra de busca e filtros
          Container(
            color: const Color(0xFF1A1A2E),
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: Column(
              children: [
                // Campo de busca
                TextField(
                  controller: _buscaCtrl,
                  onChanged: (_) => _filtrar(),
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Buscar por título ou autor...',
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
                const SizedBox(height: 10),
                // Filtro de estado
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _estados.map((e) {
                      final sel = _filtroEstado == e;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: GestureDetector(
                          onTap: () {
                            setState(() => _filtroEstado = e);
                            _filtrar();
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                            decoration: BoxDecoration(
                              color: sel ? const Color(0xFFFF6B35) : Colors.white12,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: sel ? const Color(0xFFFF6B35) : Colors.white24,
                              ),
                            ),
                            child: Text(
                              e,
                              style: TextStyle(
                                color: sel ? Colors.white : Colors.white60,
                                fontSize: 12,
                                fontWeight: sel ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),

          // Lista de livros
          Expanded(
            child: _livrosFiltrados.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_off, size: 64, color: Colors.black26),
                        SizedBox(height: 12),
                        Text('Nenhum livro encontrado', style: TextStyle(color: Colors.black45)),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(12, 12, 12, 90),
                    itemCount: _livrosFiltrados.length,
                    itemBuilder: (context, index) {
                      final livro = _livrosFiltrados[index];
                      return _LivroCard(livro: livro, onExcluir: () {
                        setState(() {
                          MockData.livros.removeWhere((l) => l.id == livro.id);
                          _filtrar();
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Livro "${livro.titulo}" removido.'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      });
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

// ── Widget: Card de Livro ───────────────────────────────────────────────────
class _LivroCard extends StatelessWidget {
  final Livro livro;
  final VoidCallback onExcluir;

  const _LivroCard({required this.livro, required this.onExcluir});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            // Thumbnail do livro
            Container(
              width: 50,
              height: 65,
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A2E),
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 4, offset: const Offset(2, 2)),
                ],
              ),
              child: const Icon(Icons.menu_book, color: Color(0xFFFF6B35), size: 28),
            ),
            const SizedBox(width: 14),

            // Informações
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    livro.titulo,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    livro.autor,
                    style: const TextStyle(color: Colors.black54, fontSize: 12),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: livro.estadoColor.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          livro.estadoLabel,
                          style: TextStyle(color: livro.estadoColor, fontSize: 11, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        livro.ano.toString(),
                        style: const TextStyle(color: Colors.black38, fontSize: 11),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Preço e ações
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'R\$ ${livro.preco.toStringAsFixed(2).replaceAll('.', ',')}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFF6B35),
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text('Confirmar exclusão'),
                        content: Text('Remover "${livro.titulo}"?'),
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
    );
  }
}
