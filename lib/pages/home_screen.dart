import 'package:flutter/material.dart';
import 'booking_screen.dart';
import 'cancellation_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Placeholder quick-action items (replace labels & icons as needed)
  static const List<Map<String, dynamic>> _quickActions = [
    {'icon': Icons.receipt_long_rounded, 'label': 'Refund Status'},
    {'icon': Icons.confirmation_number_rounded, 'label': 'View Ticket'},
    {'icon': Icons.route_rounded, 'label': 'Track Bus'},
    {'icon': Icons.schedule_rounded, 'label': 'Timetable'},
    {'icon': Icons.location_on_rounded, 'label': 'Bus Stops'},
    {'icon': Icons.support_agent_rounded, 'label': 'Support'},
    {'icon': Icons.history_rounded, 'label': 'History'},
    {'icon': Icons.more_horiz_rounded, 'label': 'More'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4FF),
      appBar: _buildAppBar(context),
      drawer: _buildDrawer(context),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Main action card (Booking + Cancellation) ---
              _MainActionsCard(),

              const SizedBox(height: 28),

              // --- Quick Actions heading ---
              const Text(
                'Quick Actions',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0D47A1),
                  letterSpacing: 0.5,
                ),
              ),

              const SizedBox(height: 14),

              // --- Quick Actions Grid ---
              _QuickActionsGrid(items: _quickActions),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // ── AppBar ──────────────────────────────────────────────────────────────
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF0D47A1),
      elevation: 0,
      leadingWidth: 56,
      leading: Builder(
        builder: (ctx) => IconButton(
          icon: const Icon(Icons.menu_rounded, color: Colors.white, size: 26),
          onPressed: () => Scaffold.of(ctx).openDrawer(),
        ),
      ),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 36,
            width: 36,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/logo.png',
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.directions_bus_rounded,
                  color: Color(0xFF0D47A1),
                  size: 22,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          const Text(
            'GSRTC',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 18,
              letterSpacing: 3,
            ),
          ),
        ],
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_none_rounded,
              color: Colors.white, size: 24),
          onPressed: () {},
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(3),
        child: Container(
          height: 3,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFFF6F00), Color(0xFFFFB300)],
            ),
          ),
        ),
      ),
    );
  }

  // ── Side Drawer ─────────────────────────────────────────────────────────
  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0D47A1), Color(0xFF0A3880)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 32),
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    'assets/logo.png',
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.directions_bus_rounded,
                      size: 48,
                      color: Color(0xFF0D47A1),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Text('GSRTC',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 4)),
              const SizedBox(height: 4),
              const Text('Gujarat State Road Transport',
                  style: TextStyle(color: Colors.white54, fontSize: 11)),
              const SizedBox(height: 24),
              const Divider(color: Colors.white24),
              _drawerItem(Icons.home_rounded, 'Home', () => Navigator.pop(context)),
              _drawerItem(Icons.person_rounded, 'Profile', () {}),
              _drawerItem(Icons.settings_rounded, 'Settings', () {}),
              _drawerItem(Icons.info_outline_rounded, 'About', () {}),
              const Spacer(),
              const Divider(color: Colors.white24),
              _drawerItem(Icons.logout_rounded, 'Logout', () {}),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  ListTile _drawerItem(IconData icon, String label, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.white70, size: 22),
      title: Text(label,
          style: const TextStyle(color: Colors.white, fontSize: 14)),
      onTap: onTap,
    );
  }
}

// ── Main Actions Card (Booking + Cancellation) ───────────────────────────
class _MainActionsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1565C0), Color(0xFF0D47A1)],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0D47A1).withValues(alpha: 0.35),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _MainActionButton(
            assetPath: 'assets/logo_2.png',
            fallbackIcon: Icons.confirmation_number_rounded,
            label: 'Booking',
            onTap: () => Navigator.push(
                          context,
                            MaterialPageRoute(builder: (_) => const BookingScreen()),
                              )),
          Container(width: 1, height: 80, color: Colors.white24),
          _MainActionButton(
            assetPath: 'assets/logo_3.png',
            fallbackIcon: Icons.cancel_rounded,
            label: 'Cancellation',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CancellationScreen()),
            ),
          ),
        ],
      ),
    );
  }
}

class _MainActionButton extends StatelessWidget {
  final String assetPath;
  final IconData fallbackIcon;
  final String label;
  final VoidCallback onTap;

  const _MainActionButton({
    required this.assetPath,
    required this.fallbackIcon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white38, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipOval(
              child: Image.asset(
                assetPath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Icon(
                  fallbackIcon,
                  size: 38,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Quick Actions Grid ───────────────────────────────────────────────────
class _QuickActionsGrid extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  const _QuickActionsGrid({required this.items});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 16,
        crossAxisSpacing: 8,
        childAspectRatio: 0.85,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return _QuickActionItem(
          icon: item['icon'] as IconData,
          label: item['label'] as String,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => _PlaceholderScreen(title: item['label']),
            ),
          ),
        );
      },
    );
  }
}

class _QuickActionItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _QuickActionItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF0D47A1).withValues(alpha: 0.12),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(icon, color: const Color(0xFF0D47A1), size: 24),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 2,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: Color(0xFF1A237E),
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Placeholder Screen for navigation ───────────────────────────────────
class _PlaceholderScreen extends StatelessWidget {
  final String title;
  const _PlaceholderScreen({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: const Color(0xFF0D47A1),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Text(
          '$title Screen\n(Coming Soon)',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 18, color: Colors.grey),
        ),
      ),
    );
  }
}