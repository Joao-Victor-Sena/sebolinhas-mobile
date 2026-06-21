import 'package:flutter/material.dart';
import '../widgets/sebo_drawer.dart';
import '../data/mock_data.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final stats = MockData.estatisticas;

    return Scaffold(
      // ── AppBar ────────────────────────────────────────────────────────────
      appBar: AppBar(
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.menu_book, color: Color(0xFFFF6B35)),
            SizedBox(width: 8),
            Text('SeboLinhas', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: CircleAvatar(
              backgroundColor: const Color(0xFFFF6B35),
              radius: 16,
              child: const Text('UT',
                  style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),

      // ── Drawer ────────────────────────────────────────────────────────────
      drawer: const SeboDrawer(telaAtual: '/menu'),

      // ── Corpo ─────────────────────────────────────────────────────────────
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Banner com imagem da estante ───────────────────────────────
            Container(
              width: double.infinity,
              height: 140,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset('assets/images/estante_livros.png', fit: BoxFit.cover),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            const Color(0xFF1A1A2E).withOpacity(0.85),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Bem-vindo!',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                            ),
                          ),
                          const Text(
                            'Usuário Teste',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFF6B35),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              'Gerente',
                              style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // ── Cards de Estatísticas ──────────────────────────────────────
            const Text(
              'Visão Geral',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A2E),
              ),
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: _StatCard(
                    icon: Icons.library_books,
                    label: 'Livros',
                    valor: '${stats['totalLivros']}',
                    cor: const Color(0xFF3498DB),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _StatCard(
                    icon: Icons.people,
                    label: 'Clientes',
                    valor: '${stats['totalClientes']}',
                    cor: const Color(0xFF2ECC71),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _StatCard(
                    icon: Icons.point_of_sale,
                    label: 'Vendas/Mês',
                    valor: '${stats['vendasMes']}',
                    cor: const Color(0xFFFF6B35),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 28),

            // ── Menu de Navegação Principal ────────────────────────────────
            const Text(
              'Menu Principal',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A2E),
              ),
            ),
            const SizedBox(height: 12),

            // Botão Acervo (Tela 1)
            _MenuCard(
              icon: Icons.library_books_rounded,
              titulo: 'Acervo de Livros',
              subtitulo: 'Tela 1 • Gerencie o catálogo de livros',
              cor: const Color(0xFF3498DB),
              tag: 'Tela 1',
              onTap: () => Navigator.pushNamed(context, '/acervo'),
            ),
            const SizedBox(height: 12),

            // Botão Clientes (Tela 2)
            _MenuCard(
              icon: Icons.people_alt_rounded,
              titulo: 'Clientes',
              subtitulo: 'Tela 2 • Base de dados de clientes',
              cor: const Color(0xFF2ECC71),
              tag: 'Tela 2',
              onTap: () => Navigator.pushNamed(context, '/clientes'),
            ),
            const SizedBox(height: 12),

            // Botão Funcionários (Tela 3)
            _MenuCard(
              icon: Icons.badge_rounded,
              titulo: 'Funcionários',
              subtitulo: 'Tela 3 • Equipe SeboLinhas',
              cor: const Color(0xFF9B59B6),
              tag: 'Tela 3',
              onTap: () => Navigator.pushNamed(context, '/funcionarios'),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

// ── Widget: Card de Estatística ─────────────────────────────────────────────
class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String valor;
  final Color cor;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.valor,
    required this.cor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: cor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: cor, size: 22),
            ),
            const SizedBox(height: 8),
            Text(
              valor,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: cor,
              ),
            ),
            Text(
              label,
              style: const TextStyle(fontSize: 11, color: Colors.black45),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// ── Widget: Card de Menu ────────────────────────────────────────────────────
class _MenuCard extends StatelessWidget {
  final IconData icon;
  final String titulo;
  final String subtitulo;
  final Color cor;
  final String tag;
  final VoidCallback onTap;

  const _MenuCard({
    required this.icon,
    required this.titulo,
    required this.subtitulo,
    required this.cor,
    required this.tag,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Ícone
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: cor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: cor, size: 28),
              ),
              const SizedBox(width: 16),

              // Texto
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      titulo,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A1A2E),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitulo,
                      style: const TextStyle(fontSize: 12, color: Colors.black45),
                    ),
                  ],
                ),
              ),

              // Tag + Seta
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: cor.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      tag,
                      style: TextStyle(fontSize: 10, color: cor, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Icon(Icons.arrow_forward_ios, size: 14, color: cor),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
