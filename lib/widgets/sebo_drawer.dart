import 'package:flutter/material.dart';

class SeboDrawer extends StatelessWidget {
  final String telaAtual;

  const SeboDrawer({super.key, required this.telaAtual});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color(0xFF1A1A2E),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // ── Header do Drawer ──────────────────────────────────────────
            DrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF6B35),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.menu_book, color: Colors.white, size: 35),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'SeboLinhas',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'Sistema de Gerenciamento',
                    style: TextStyle(color: Color(0xFFFF6B35), fontSize: 12),
                  ),
                ],
              ),
            ),

            // ── Itens de Navegação ────────────────────────────────────────
            _DrawerItem(
              icon: Icons.dashboard_rounded,
              label: 'Menu Principal',
              route: '/menu',
              ativo: telaAtual == '/menu',
            ),
            const Divider(color: Colors.white12, indent: 16, endIndent: 16),
            _DrawerItem(
              icon: Icons.library_books_rounded,
              label: 'Acervo de Livros',
              sublabel: 'Tela 1',
              route: '/acervo',
              ativo: telaAtual == '/acervo',
            ),
            _DrawerItem(
              icon: Icons.people_alt_rounded,
              label: 'Clientes',
              sublabel: 'Tela 2',
              route: '/clientes',
              ativo: telaAtual == '/clientes',
            ),
            _DrawerItem(
              icon: Icons.badge_rounded,
              label: 'Funcionários',
              sublabel: 'Tela 3',
              route: '/funcionarios',
              ativo: telaAtual == '/funcionarios',
            ),
            const Divider(color: Colors.white12, indent: 16, endIndent: 16),

            // ── Rodapé ────────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'SeboLinhas v1.0',
                    style: TextStyle(color: Colors.white38, fontSize: 11),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'Projeto Acadêmico Flutter',
                    style: TextStyle(color: Colors.white24, fontSize: 10),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Item do Drawer ──────────────────────────────────────────────────────────
class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? sublabel;
  final String route;
  final bool ativo;

  const _DrawerItem({
    required this.icon,
    required this.label,
    this.sublabel,
    required this.route,
    required this.ativo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: ativo ? const Color(0xFFFF6B35).withOpacity(0.15) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: ativo
            ? Border.all(color: const Color(0xFFFF6B35).withOpacity(0.4))
            : null,
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: ativo ? const Color(0xFFFF6B35) : Colors.white60,
          size: 22,
        ),
        title: Text(
          label,
          style: TextStyle(
            color: ativo ? const Color(0xFFFF6B35) : Colors.white,
            fontWeight: ativo ? FontWeight.bold : FontWeight.normal,
            fontSize: 14,
          ),
        ),
        subtitle: sublabel != null
            ? Text(
                sublabel!,
                style: const TextStyle(color: Colors.white38, fontSize: 11),
              )
            : null,
        trailing: ativo
            ? const Icon(Icons.arrow_forward_ios, color: Color(0xFFFF6B35), size: 14)
            : null,
        onTap: () {
          Navigator.pop(context); // fecha o drawer
          if (ModalRoute.of(context)?.settings.name != route) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              route,
              (route) => false,
            );
          }
        },
      ),
    );
  }
}
