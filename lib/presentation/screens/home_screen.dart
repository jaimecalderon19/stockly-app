import 'package:flutter/material.dart';
import 'package:stockly/presentation/widgets/card/action_card_widget.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Ícono principal
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF818CF8), Color(0xFF6366F1)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.shopping_bag_outlined,
                    size: 48,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 24),

                // Título
                const Text(
                  "FakeStore Manager",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 22,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),

                // Descripción
                Text(
                  "Gestiona y guarda tus productos favoritos de\nforma simple y elegante",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 14.5,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 30),

                // Tarjetas de acción
                const ActionCardWidget(
                  icon: Icons.shopping_bag_outlined,
                  title: "Explorar Productos",
                  subtitle: "Navega por el catálogo completo",
                ),
                const ActionCardWidget(
                  icon: Icons.bookmark_border_rounded,
                  title: "Mis Guardados",
                  subtitle: "Accede a tus productos favoritos",
                ),

                const SizedBox(height: 30),

                // Footer
                RichText(
                  text: TextSpan(
                    text: "Hecha por ",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 13,
                    ),
                    children: const [
                      TextSpan(
                        text: "Jaime Calderon",
                        style: TextStyle(
                          color: Color(0xFF6366F1),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
