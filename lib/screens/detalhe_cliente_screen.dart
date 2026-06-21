import 'package:flutter/material.dart';
import '../models/cliente.dart';

class DetalheClienteScreen extends StatelessWidget {
  final Cliente cliente;

  const DetalheClienteScreen({super.key, required this.cliente});

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

    // Histórico de compras fictício para demonstração
    final historico = [
      {'livro': 'Dom Casmurro', 'data': '10/06/2025', 'valor': 'R\$ 15,00'},
      {'livro': 'Capitães da Areia', 'data': '28/05/2025', 'valor': 'R\$ 18,00'},
      {'livro': 'Grande Sertão: Veredas', 'data': '15/04/2025', 'valor': 'R\$ 22,00'},
    ].take(cliente.totalCompras > 3 ? 3 : cliente.totalCompras).toList();

    return Scaffold(
      // ── AppBar ──────────────────────────────────────────────────────────
      appBar: AppBar(
        title: const Text('Detalhes do Cliente'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
          tooltip: 'Voltar para Clientes (Tela 2)',
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: 'Editar cliente',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Função de edição disponível na versão completa')),
              );
            },
          ),
        ],
      ),

      // ── Corpo ────────────────────────────────────────────────────────────
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ── Header do perfil ─────────────────────────────────────────
            Container(
              width: double.infinity,
              color: const Color(0xFF1A1A2E),
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
              child: Column(
                children: [
                  // Badge "Tela 2.1"
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: cor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: cor.withOpacity(0.5)),
                    ),
                    child: Text(
                      '📋 Tela 2.1 — Detalhes do Cliente',
                      style: TextStyle(color: cor, fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Avatar grande
                  CircleAvatar(
                    radius: 48,
                    backgroundColor: cor,
                    child: Text(
                      cliente.iniciais,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  Text(
                    cliente.nome,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Cliente #${cliente.id.toString().padLeft(4, '0')}',
                    style: const TextStyle(color: Colors.white38, fontSize: 13),
                  ),

                  const SizedBox(height: 20),

                  // Cards de resumo
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _SummaryChip(
                        label: 'Total de Compras',
                        valor: '${cliente.totalCompras}',
                        icon: Icons.shopping_bag_outlined,
                        cor: cor,
                      ),
                      const SizedBox(width: 12),
                      _SummaryChip(
                        label: 'Total Gasto',
                        valor: 'R\$ ${cliente.totalGasto.toStringAsFixed(2).replaceAll('.', ',')}',
                        icon: Icons.monetization_on_outlined,
                        cor: const Color(0xFF2ECC71),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // ── Dados de Contato ─────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SectionTitle(title: 'Dados de Contato', icon: Icons.contact_page),
                  const SizedBox(height: 12),
                  Card(
                    child: Column(
                      children: [
                        _InfoRow(
                          icon: Icons.badge_outlined,
                          label: 'CPF',
                          valor: cliente.cpfFormatado,
                          iconColor: cor,
                        ),
                        const Divider(height: 1, indent: 56),
                        _InfoRow(
                          icon: Icons.email_outlined,
                          label: 'E-mail',
                          valor: cliente.email,
                          iconColor: cor,
                        ),
                        const Divider(height: 1, indent: 56),
                        _InfoRow(
                          icon: Icons.phone_outlined,
                          label: 'Telefone',
                          valor: cliente.telefoneFormatado,
                          iconColor: cor,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // ── Histórico de Compras ──────────────────────────────
                  _SectionTitle(title: 'Histórico de Compras', icon: Icons.history),
                  const SizedBox(height: 12),

                  if (historico.isEmpty)
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          children: [
                            Icon(Icons.shopping_bag_outlined, size: 40, color: Colors.black26),
                            const SizedBox(height: 8),
                            const Text('Nenhuma compra registrada.',
                                style: TextStyle(color: Colors.black45)),
                          ],
                        ),
                      ),
                    )
                  else
                    Card(
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: historico.length,
                        separatorBuilder: (_, __) => const Divider(height: 1, indent: 56),
                        itemBuilder: (context, index) {
                          final item = historico[index];
                          return ListTile(
                            leading: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: cor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(Icons.book_outlined, color: cor, size: 20),
                            ),
                            title: Text(
                              item['livro']!,
                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                            subtitle: Text(
                              item['data']!,
                              style: const TextStyle(fontSize: 12, color: Colors.black45),
                            ),
                            trailing: Text(
                              item['valor']!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2ECC71),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                  const SizedBox(height: 24),

                  // ── Botão Voltar ──────────────────────────────────────
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back),
                      label: const Text('Voltar para Clientes (Tela 2)'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: cor,
                        side: BorderSide(color: cor),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Widgets auxiliares ──────────────────────────────────────────────────────

class _SectionTitle extends StatelessWidget {
  final String title;
  final IconData icon;

  const _SectionTitle({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: const Color(0xFF1A1A2E)),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A1A2E),
          ),
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String valor;
  final Color iconColor;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.valor,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: iconColor, size: 18),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(fontSize: 11, color: Colors.black45)),
                Text(valor, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryChip extends StatelessWidget {
  final String label;
  final String valor;
  final IconData icon;
  final Color cor;

  const _SummaryChip({
    required this.label,
    required this.valor,
    required this.icon,
    required this.cor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: cor.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: cor.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: cor, size: 22),
          const SizedBox(height: 4),
          Text(
            valor,
            style: TextStyle(
              color: cor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(
            label,
            style: const TextStyle(color: Colors.white54, fontSize: 10),
          ),
        ],
      ),
    );
  }
}
