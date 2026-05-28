import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CancellationScreen extends StatefulWidget {
  const CancellationScreen({super.key});

  @override
  State<CancellationScreen> createState() => _CancellationScreenState();
}

class _CancellationScreenState extends State<CancellationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _pnrController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();

  @override
  void dispose() {
    _pnrController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      // TODO: Add cancellation API call here
      debugPrint(
        'Cancel Ticket | PNR: ${_pnrController.text} | '
        'Email: ${_emailController.text} | Mobile: ${_mobileController.text}',
      );
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Row(
            children: [
              Icon(Icons.check_circle_rounded, color: Color(0xFF0D47A1)),
              SizedBox(width: 8),
              Text('Request Submitted',
                  style: TextStyle(
                      color: Color(0xFF0D47A1),
                      fontWeight: FontWeight.w700,
                      fontSize: 16)),
            ],
          ),
          content: const Text(
            'Your cancellation request has been submitted.\nYou will receive a confirmation on your email and mobile.',
            style: TextStyle(fontSize: 13, color: Colors.black54),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('OK',
                  style: TextStyle(
                      color: Color(0xFF0D47A1), fontWeight: FontWeight.w700)),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4FF),
      appBar: _buildAppBar(context),
      drawer: _buildDrawer(context),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Title ──
                Center(
                  child: Column(
                    children: [
                      const Text(
                        'CANCEL TICKET',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF0D47A1),
                          letterSpacing: 3,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        width: 50,
                        height: 3,
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // ── Input Card ──
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF0D47A1).withValues(alpha: 0.10),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // PNR No.
                      _InputField(
                        label: 'PNR No.',
                        hint: 'Enter your PNR number',
                        icon: Icons.confirmation_number_rounded,
                        controller: _pnrController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(15),
                        ],
                        validator: (val) {
                          if (val == null || val.isEmpty) return 'PNR number is required';
                          if (val.length < 6) return 'Enter a valid PNR number';
                          return null;
                        },
                      ),

                      const SizedBox(height: 20),

                      // Email ID
                      _InputField(
                        label: 'Email ID',
                        hint: 'Enter your email address',
                        icon: Icons.email_rounded,
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (val) {
                          if (val == null || val.isEmpty) return 'Email is required';
                          final emailRegex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
                          if (!emailRegex.hasMatch(val)) return 'Enter a valid email address';
                          return null;
                        },
                      ),

                      const SizedBox(height: 20),

                      // Mobile No.
                      _InputField(
                        label: 'Mobile No.',
                        hint: 'Enter 10-digit mobile number',
                        icon: Icons.phone_rounded,
                        controller: _mobileController,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10),
                        ],
                        validator: (val) {
                          if (val == null || val.isEmpty) return 'Mobile number is required';
                          if (val.length != 10) return 'Enter a valid 10-digit mobile number';
                          return null;
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // ── Submit Button ──
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _onSubmit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0D47A1),
                      foregroundColor: Colors.white,
                      elevation: 6,
                      shadowColor: const Color(0xFF0D47A1).withValues(alpha: 0.4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.cancel_rounded, size: 22),
                        SizedBox(width: 8),
                        Text(
                          'SUBMIT',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // ── Note ──
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.orange.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: Colors.orange.withValues(alpha: 0.3), width: 1),
                  ),
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.info_outline_rounded,
                          color: Colors.orange, size: 18),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Refund will be processed within 5–7 working days to your original payment method.',
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
                              height: 1.4),
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

  // ── Drawer ──────────────────────────────────────────────────────────────
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

// ── Reusable Input Field ────────────────────────────────────────────────
class _InputField extends StatelessWidget {
  final String label;
  final String hint;
  final IconData icon;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;

  const _InputField({
    required this.label,
    required this.hint,
    required this.icon,
    required this.controller,
    required this.keyboardType,
    this.inputFormatters,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: const Color(0xFF0D47A1)),
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(
                color: Color(0xFF0D47A1),
                fontWeight: FontWeight.w700,
                fontSize: 14,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          validator: validator,
          style: const TextStyle(
            color: Color(0xFF1A237E),
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
            filled: true,
            fillColor: const Color(0xFFF0F4FF),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFFBBCEF0), width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFFBBCEF0), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFF0D47A1), width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}