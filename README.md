<div align="center">
  <h1>SeboLinhas</h1>
  <p><strong>Sistema de Gerenciamento de Sebos — Projeto Integrador (3º Ciclo Avaliativo)</strong></p>

  ![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=for-the-badge&logo=flutter)
  ![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?style=for-the-badge&logo=dart)
  ![AWS](https://img.shields.io/badge/AWS-Academy-232F3E?style=for-the-badge&logo=amazon-aws)
  ![Status](https://img.shields.io/badge/Status-Concluído-success?style=for-the-badge)
</div>

---

## Sobre o Projeto

O **SeboLinhas** é um aplicativo mobile desenvolvido em **Flutter** voltado para o gerenciamento de um sebo (livraria de usados). O projeto foi construído para atender aos requisitos do 3º Ciclo Avaliativo do Projeto Integrador, integrando conhecimentos de Desenvolvimento Mobile, Engenharia de Software e Cloud Computing.

---

## Arquitetura e Engenharia de Software

O desenvolvimento deste projeto foi pautado em boas práticas de Engenharia de Software e Qualidade (QA), visando um ciclo de vida de software rastreável e confiável.

**Levantamento e Rastreabilidade de Requisitos:** Realizamos um mapeamento detalhado dos requisitos funcionais (gestão de acervo, clientes e funcionários) e não-funcionais (usabilidade, performance), garantindo que cada funcionalidade desenvolvida esteja ligada a uma necessidade de negócio específica.

**Metodologia V-Model (Modelo em V):** Optamos por adotar o **V-Model** como modelo de ciclo de vida. Esta escolha metodológica nos permitiu ter um rigor maior na verificação e validação. Para cada fase de especificação e design (lado esquerdo do "V"), foi planejada uma fase correspondente de testes (lado direito do "V"), como testes de unidade dos widgets e testes de integração das rotas do Flutter, garantindo alta confiabilidade na entrega final.

---

## Cloud Computing e Infraestrutura

A arquitetura de backend e o provisionamento de serviços foram desenhados com foco em Cloud Computing, utilizando os recursos educacionais da AWS.

**AWS Academy:** Toda a experimentação, tutoriais e simulação de servidores foram realizados utilizando o laboratório virtual da **AWS Academy**, com o crédito educacional de $50 dólares disponibilizado pela plataforma.

**Infraestrutura Escalável:** A arquitetura planejada envolve a utilização de instâncias **Amazon EC2** para hospedar a API de backend que alimenta o aplicativo Flutter, em conjunto com serviços gerenciados como o **Amazon RDS** para o banco de dados relacional. Essa abordagem garante alta disponibilidade, segurança e escalabilidade para o sistema do sebo.

---

## Estrutura de Navegação

O aplicativo segue rigorosamente o fluxograma de navegação exigido, proporcionando uma experiência de usuário fluida através de botões intuitivos e um Drawer lateral.

```text
Tela de Abertura (Splash Screen)
        |
        v
Menu Principal  <---- Drawer de Navegação
   +------------------------------+
   |  [Botão] Acervo de Livros   | ---> Tela 1: Acervo
   |  [Botão] Clientes           | ---> Tela 2: Clientes
   |  [Botão] Funcionários       | ---> Tela 3: Funcionários
   +------------------------------+
                                           |
                              Tela 2 ------+
                                           |
                                           v
                                Tela 2.1: Detalhes do Cliente
```

---

## Requisitos Técnicos Atendidos

| Requisito Solicitado | Status | Observação |
| :--- | :---: | :--- |
| Uso de `Scaffold` | OK | Implementado como base arquitetural em todas as telas. |
| Uso de `AppBar` | OK | Presente para navegação e identificação contextual. |
| Navegação via Botões | OK | Utilização de Cards interativos, FABs e botões de ação. |
| Imagens Ilustrativas | OK | `logo_sebo.png` (Splash) e `estante_livros.png` (Menu). |
| Menu Principal | OK | Dashboard centralizado com atalhos para todas as rotas. |
| Drawer (Opcional) | OK | Menu lateral implementado para navegação global. |

---

## Estrutura do Projeto

```
sebolinhas/
├── pubspec.yaml
├── lib/
│   ├── main.dart                          # Entry point e rotas
│   ├── data/
│   │   └── mock_data.dart                 # Dados de exemplo
│   ├── models/
│   │   ├── livro.dart
│   │   ├── cliente.dart
│   │   └── funcionario.dart
│   ├── widgets/
│   │   └── sebo_drawer.dart               # Drawer reutilizável
│   └── screens/
│       ├── splash_screen.dart             # Tela de Abertura
│       ├── menu_screen.dart               # Menu Principal
│       ├── acervo_screen.dart             # Tela 1 — Acervo
│       ├── clientes_screen.dart           # Tela 2 — Clientes
│       ├── detalhe_cliente_screen.dart    # Tela 2.1 — Detalhes
│       └── funcionarios_screen.dart       # Tela 3 — Funcionários
└── assets/
    └── images/
        ├── logo_sebo.png
        └── estante_livros.png
```

---

## Como Executar o Projeto

### Pré-requisitos

- [Flutter SDK](https://flutter.dev/docs/get-started/install) >= 3.0
- Emulador Android / iOS ou dispositivo físico configurado.

### Passo a Passo

```bash
# 1. Clone o repositório
git clone https://github.com/Joao-Victor-Sena/sebolinhas.git

# 2. Acesse a pasta do projeto
cd sebolinhas

# 3. Baixe as dependências
flutter pub get

# 4. Execute a aplicação
flutter run
```

---

## Equipe de Desenvolvimento

- João Victor Sena
- Micael Vasconcelos
- Samuel Carlos Correia
- Tiago Kauã

---

<div align="center">
  <sub>Desenvolvido para avaliação acadêmica — Disciplinas de Mobile, Engenharia de Software e Cloud Computing.</sub>
</div>
