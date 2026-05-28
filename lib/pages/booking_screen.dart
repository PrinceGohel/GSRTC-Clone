import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  // --- Predefined city list (add/remove as needed) ---
  static const List<String> _cities = [
    'Ahmedabad',
    'Surat',
    'Vadodara',
    'Rajkot',
    'Bhavnagar',
    'Jamnagar',
    'Gandhinagar',
    'Anand',
    'Mehsana',
    'Bharuch',
    'Junagadh',
    'Nadiad',
    'Morbi',
    'Surendranagar',
    'Palanpur',
    'Amreli',
    'Botad',
    'Dwarka',
    'Porbandar',
    'Veraval',
  ];

  String? _fromCity;
  String? _toCity;
  DateTime? _selectedDate;

  final TextEditingController _adultController = TextEditingController(text: '1');
  final TextEditingController _childController = TextEditingController(text: '0');

  @override
  void dispose() {
    _adultController.dispose();
    _childController.dispose();
    super.dispose();
  }

  // Swap FROM and TO
  void _swapCities() {
    setState(() {
      final temp = _fromCity;
      _fromCity = _toCity;
      _toCity = temp;
    });
  }

  // Date picker
  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: now,
      lastDate: now.add(const Duration(days: 90)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF0D47A1),
              onPrimary: Colors.white,
              onSurface: Color(0xFF0D47A1),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  String get _formattedDate {
    if (_selectedDate == null) return 'dd/mm/yy';
    final d = _selectedDate!;
    return '${d.day.toString().padLeft(2, '0')}/'
        '${d.month.toString().padLeft(2, '0')}/'
        '${d.year.toString().substring(2)}';
  }

  void _onSearch() {
    if (_fromCity == null || _toCity == null || _selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all fields before searching.'),
          backgroundColor: Color(0xFF0D47A1),
        ),
      );
      return;
    }
    if (_fromCity == _toCity) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('From and To cities cannot be the same.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    // TODrO: Navigate to search results screen
    debugPrint(
      'Search: $_fromCity → $_toCity | Date: $_formattedDate | '
      'Adults: ${_adultController.text} | Children: ${_childController.text}',
    );
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Title ──
              Center(
                child: Column(
                  children: [
                    const Text(
                      'BOOKING',
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

              const SizedBox(height: 28),

              // ── FROM / TO card ──
              Container(
                padding: const EdgeInsets.all(20),
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
                child: Stack(
                  children: [
                    Column(
                      children: [
                        // FROM
                        _CityDropdown(
                          label: 'FROM',
                          value: _fromCity,
                          cities: _cities,
                          onChanged: (val) => setState(() => _fromCity = val),
                        ),
                        const SizedBox(height: 16),
                        // TO
                        _CityDropdown(
                          label: 'TO',
                          value: _toCity,
                          cities: _cities,
                          onChanged: (val) => setState(() => _toCity = val),
                        ),
                      ],
                    ),

                    // Swap button (right side, vertically centered)
                    Positioned(
                      right: 0,
                      top: 0,
                      bottom: 0,
                      child: Center(
                        child: GestureDetector(
                          onTap: _swapCities,
                          child: Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xFF0D47A1),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF0D47A1).withValues(alpha: 0.35),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.swap_vert_rounded,
                              color: Colors.white,
                              size: 22,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // ── DATE ──
              GestureDetector(
                onTap: _pickDate,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF0D47A1).withValues(alpha: 0.08),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_today_rounded,
                          color: Color(0xFF0D47A1), size: 20),
                      const SizedBox(width: 12),
                      const Text(
                        'DATE :',
                        style: TextStyle(
                          color: Color(0xFF0D47A1),
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        _formattedDate,
                        style: TextStyle(
                          color: _selectedDate == null
                              ? Colors.grey
                              : const Color(0xFF1A237E),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      const Icon(Icons.arrow_drop_down_rounded,
                          color: Color(0xFF0D47A1)),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // ── ADULT / CHILD ──
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF0D47A1).withValues(alpha: 0.08),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Adult
                    Expanded(
                      child: _PassengerField(
                        label: 'Adult(s)',
                        controller: _adultController,
                        icon: Icons.person_rounded,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Container(width: 1, height: 40, color: Colors.grey.shade200),
                    const SizedBox(width: 16),
                    // Child
                    Expanded(
                      child: _PassengerField(
                        label: 'Child',
                        controller: _childController,
                        icon: Icons.child_care_rounded,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // ── SEARCH BUTTON ──
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _onSearch,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    elevation: 6,
                    shadowColor: Colors.orange.withValues(alpha: 0.4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.search_rounded, size: 22),
                      SizedBox(width: 8),
                      Text(
                        'SEARCH BUSES',
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
            ],
          ),
        ),
      ),
    );
  }

  // ── AppBar (same as HomeScreen) ─────────────────────────────────────────
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

  // ── Drawer (same as HomeScreen) ─────────────────────────────────────────
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

// ── City Dropdown Widget ────────────────────────────────────────────────
class _CityDropdown extends StatelessWidget {
  final String label;
  final String? value;
  final List<String> cities;
  final ValueChanged<String?> onChanged;

  const _CityDropdown({
    required this.label,
    required this.value,
    required this.cities,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 60,
          child: Text(
            '$label :',
            style: const TextStyle(
              color: Color(0xFF0D47A1),
              fontWeight: FontWeight.w700,
              fontSize: 14,
              letterSpacing: 0.5,
            ),
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F4FF),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFBBCEF0), width: 1),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: value,
                hint: const Text('Select city',
                    style: TextStyle(color: Colors.grey, fontSize: 13)),
                icon: const Icon(Icons.arrow_drop_down_rounded,
                    color: Color(0xFF0D47A1)),
                isExpanded: true,
                style: const TextStyle(
                  color: Color(0xFF1A237E),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                dropdownColor: Colors.white,
                borderRadius: BorderRadius.circular(12),
                items: cities
                    .map((city) => DropdownMenuItem(
                          value: city,
                          child: Text(city),
                        ))
                    .toList(),
                onChanged: onChanged,
              ),
            ),
          ),
        ),
        const SizedBox(width: 52), // space for swap button
      ],
    );
  }
}

// ── Passenger Number Field ──────────────────────────────────────────────
class _PassengerField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final IconData icon;

  const _PassengerField({
    required this.label,
    required this.controller,
    required this.icon,
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
                fontSize: 13,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(2),
          ],
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xFF1A237E),
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            filled: true,
            fillColor: const Color(0xFFF0F4FF),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  const BorderSide(color: Color(0xFFBBCEF0), width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  const BorderSide(color: Color(0xFFBBCEF0), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  const BorderSide(color: Color(0xFF0D47A1), width: 2),
            ),
          ),
        ),
      ],
    );
  }
}