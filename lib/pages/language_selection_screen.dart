import 'package:flutter/material.dart';
import 'home_screen.dart';
class LanguageSelectionScreen extends StatelessWidget {
  const LanguageSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0D47A1), // Deep blue (top)
              Color(0xFF1565C0), // Medium blue (middle)
              Color(0xFF0A3880), // Darker blue (bottom)
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),

              // --- Logo ---
              Container(
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.25),
                      blurRadius: 20,
                      spreadRadius: 2,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.asset(
                    'assets/logo.png',
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.directions_bus_rounded,
                      size: 72,
                      color: Color(0xFF0D47A1),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // --- Welcome Text ---
              const Text(
                'WELCOME TO',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 4,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'GSRTC',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 42,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 6,
                ),
              ),
              const SizedBox(height: 8),

              // Decorative divider
              Container(
                width: 60,
                height: 3,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              const SizedBox(height: 16),

              const Text(
                'Select your preferred language',
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: 13,
                  letterSpacing: 0.5,
                ),
              ),

              const Spacer(flex: 2),

              // --- Language Buttons ---
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: [
                    _LanguageButton(
                      label: 'ENGLISH',
                      subLabel: 'English',
                      onTap: () {
                        Navigator.pushReplacement(context,MaterialPageRoute(builder: (_) => const HomeScreen()),);
                        debugPrint('English selected');
                      },
                    ),
                    const SizedBox(height: 16),
                    _LanguageButton(
                      label: 'ગુજરાતી',
                      subLabel: 'Gujarati',
                      onTap: () {
                        // TOD0O: Set locale to Gujarati and navigate
                        debugPrint('Gujarati selected');
                      },
                      isOutlined: true,
                    ),
                  ],
                ),
              ),

              const Spacer(flex: 1),

              // Footer
              const Padding(
                padding: EdgeInsets.only(bottom: 24),
                child: Text(
                  'Gujarat State Road Transport Corporation',
                  style: TextStyle(
                    color: Colors.white38,
                    fontSize: 11,
                    letterSpacing: 0.3,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- Reusable Language Button Widget ---
class _LanguageButton extends StatelessWidget {
  final String label;
  final String subLabel;
  final VoidCallback onTap;
  final bool isOutlined;

  const _LanguageButton({
    required this.label,
    required this.subLabel,
    required this.onTap,
    this.isOutlined = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 58,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              isOutlined ? Colors.transparent : Colors.orange,
          foregroundColor: Colors.white,
          elevation: isOutlined ? 0 : 6,
          shadowColor: isOutlined
              ? Colors.transparent
              : Colors.orange.withValues(alpha: 0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: isOutlined
                ? const BorderSide(color: Colors.white54, width: 1.5)
                : BorderSide.none,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '($subLabel)',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: isOutlined ? Colors.white54 : Colors.white70,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}