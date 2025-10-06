import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(const InviteApp());

class InviteApp extends StatelessWidget {
  const InviteApp({super.key});

  @override
  Widget build(BuildContext context) {
    const kBlue = Color(0xFF53A9FF);   // azul das abas ativas
    const kOrange = Color(0xFFFF7A3D); // laranja dos botões
    const kText = Color(0xFF2F2F2F);
    const kSubText = Color(0xFF8A8A8A);

    final textTheme = GoogleFonts.baloo2TextTheme().copyWith(
      titleLarge: GoogleFonts.baloo2(
        fontSize: 22, fontWeight: FontWeight.w700, color: kText),
      titleMedium: GoogleFonts.baloo2(
        fontSize: 16, fontWeight: FontWeight.w700, color: kText),
      bodyMedium: GoogleFonts.baloo2(
        fontSize: 14, fontWeight: FontWeight.w600, color: kText),
      bodySmall: GoogleFonts.baloo2(
        fontSize: 12, fontWeight: FontWeight.w600, color: kSubText),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Central de Convites',
      theme: ThemeData(
        useMaterial3: false,
        scaffoldBackgroundColor: Colors.white,
        textTheme: textTheme,
        colorScheme: ColorScheme.fromSeed(
          seedColor: kBlue, primary: kBlue, secondary: kOrange),
      ),
      home: const InviteCenterScreen(),
    );
  }
}

class InviteCenterScreen extends StatefulWidget {
  const InviteCenterScreen({super.key});

  @override
  State<InviteCenterScreen> createState() => _InviteCenterScreenState();
}

class _InviteCenterScreenState extends State<InviteCenterScreen> {
  int _currentTab = 0;

  static const kBlue = Color(0xFF53A9FF);
  static const kOrange = Color(0xFFFF7A3D);
  static const kChipBg = Color(0xFFF1F3F5);
  static const kCardShadow = Color(0x1A000000);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final horizontal = 16.0;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cabeçalho com avatar e cumprimento
              Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: const BoxDecoration(
                      color: Color(0xFFEAF5FF),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.person, color: kBlue),
                  ),
                  const SizedBox(width: 12),
                  Text('Olá, Iago ...',
                      style: Theme.of(context).textTheme.titleMedium),
                ],
              ),
              const SizedBox(height: 14),
              Text('Central de Convites',
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 12),

              // Abas segmentadas
              _SegmentedTabs(
                tabs: const ['Pendentes', 'Concluídos', 'Rascunhos'],
                selected: _currentTab,
                onChanged: (i) => setState(() => _currentTab = i),
              ),
              const SizedBox(height: 14),

              // Botão "Criar Convite"
              _PrimaryButton(
                label: 'Criar Convite',
                onTap: () {},
                color: kOrange,
                leading: const _CircleIcon(
                  icon: Icons.add, bg: Colors.white, fg: kOrange),
              ),
              const SizedBox(height: 14),

              // CARD 1 - Proprietário + engrenagem
              _InviteCard(
                title: 'Festa de Aniversário ANA',
                date: '25 de Maio de 2024',
                time: '6:30 PM',
                roleLabel: 'Proprietário',
                showSettings: true,
              ),
              const SizedBox(height: 8),

              // Botão "Entrar Evento"
              _PrimaryButton(
                label: 'Entrar Evento',
                onTap: () {},
                color: kOrange,
                leading: const _CircleIcon(
                  icon: Icons.add, bg: Colors.white, fg: kOrange),
              ),
              const SizedBox(height: 12),

              // CARD 2 - Convidado
              _InviteCard(
                title: 'Casamento José Carlos',
                date: '31 de Agosto de 2024',
                time: '8:00 PM',
                roleLabel: 'Convidado',
                showSettings: false,
              ),
              const SizedBox(height: 12),

              // CARD 3 - Convidado
              _InviteCard(
                title: 'Show do DJ Música',
                date: '02 de Novembro de 2024',
                time: '22:00 PM',
                roleLabel: 'Convidado',
                showSettings: false,
              ),

              // respiro inferior em telas altas
              SizedBox(height: w * 0.08),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------- Widgets de UI ----------------------------

class _SegmentedTabs extends StatelessWidget {
  const _SegmentedTabs({
    required this.tabs,
    required this.selected,
    required this.onChanged,
  });

  final List<String> tabs;
  final int selected;
  final ValueChanged<int> onChanged;

  static const kBlue = Color(0xFF53A9FF);
  static const kBg = Color(0xFFF1F3F5);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kBg,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets(4),
      child: Row(
        children: List.generate(tabs.length, (i) {
          final active = i == selected;
          return Expanded(
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () => onChanged(i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: active ? kBlue : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: Text(
                  tabs[i],
                  style: GoogleFonts.baloo2(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: active ? Colors.white : const Color(0xFF6B6B6B),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton({
    required this.label,
    required this.onTap,
    required this.color,
    this.leading,
  });

  final String label;
  final VoidCallback onTap;
  final Color color;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(10),
      elevation: 1.5,
      shadowColor: const Color(0x26000000),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Container(
          height: 42,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (leading != null) ...[
                leading!,
                const SizedBox(width: 10),
              ],
              Text(
                label,
                style: GoogleFonts.baloo2(
                  fontSize: 14, color: Colors.white, fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CircleIcon extends StatelessWidget {
  const _CircleIcon({
    required this.icon,
    required this.bg,
    required this.fg,
  });

  final IconData icon;
  final Color bg;
  final Color fg;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 26,
      height: 26,
      decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
      child: Icon(icon, size: 18, color: fg),
    );
  }
}

class _InviteCard extends StatelessWidget {
  const _InviteCard({
    required this.title,
    required this.date,
    required this.time,
    required this.roleLabel,
    required this.showSettings,
  });

  final String title;
  final String date;
  final String time;
  final String roleLabel;
  final bool showSettings;

  static const kShadow = Color(0x1A000000);
  static const kText = Color(0xFF2F2F2F);
  static const kSubText = Color(0xFF8A8A8A);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1.5,
      shadowColor: kShadow,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // conteúdo à esquerda
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: GoogleFonts.baloo2(
                        fontSize: 14, fontWeight: FontWeight.w800, color: kText)),
                  const SizedBox(height: 4),
                  Text(date,
                      style: GoogleFonts.baloo2(
                        fontSize: 12, fontWeight: FontWeight.w600, color: kSubText)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.access_time, size: 15, color: kSubText),
                      const SizedBox(width: 4),
                      Text(time,
                          style: GoogleFonts.baloo2(
                            fontSize: 12, fontWeight: FontWeight.w700, color: kSubText)),
                    ],
                  ),
                ],
              ),
            ),

            // ícones à direita (engrenagem + papel de usuário)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (showSettings) ...[
                  const Icon(Icons.settings, size: 18, color: Colors.black87),
                  const SizedBox(width: 10),
                ],
                Column(
                  children: [
                    const Icon(Icons.person, size: 18, color: Colors.black87),
                    const SizedBox(height: 4),
                    Text(roleLabel,
                        style: GoogleFonts.baloo2(
                          fontSize: 10, fontWeight: FontWeight.w700,
                          color: kSubText)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
