import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFF0F1C1E),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               
                const Text(
                  'Secondary Numbers',
                  style: TextStyle(
                    color: Color(0xFFB0BEC5),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.3,
                  ),
                ),

                const SizedBox(height: 16),

                PhoneNumberCard(
                  number: '+8801870488020',
                  label: 'Home',
                  sublabel: 'Added 2mo ago',
                ),

                const SizedBox(height: 12),

                PhoneNumberCard(
                  number: '+8801521512252',
                  label: 'Work',
                  sublabel: 'Unverified',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PhoneNumberCard extends StatelessWidget {
  final String number;
  final String label;
  final String sublabel;

  const PhoneNumberCard({
    super.key,
    required this.number,
    required this.label,
    required this.sublabel,
  });

  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      decoration: BoxDecoration(
        color: const Color(0xFF1A2B2E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF2E4045),
          width: 0.8,
        ),
        boxShadow: [
          BoxShadow(
            // Fix: Replaced deprecated withOpacity with explicit ARGB hex value.
            // 0.4 opacity of black (0xFF000000) corresponds to an alpha of 0x66 (102 in decimal).
            color: const Color(0x66000000), 
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: const Color(0xFF263238),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.phone,
              color: Color(0xFF90A4AE),
              size: 24,
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  number,
                  style: const TextStyle(
                    color: Color(0xFFE0EAF0),
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.2,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      label,
                      style: const TextStyle(
                        color: Color(0xFF78909C),
                        fontSize: 13,
                      ),
                    ),
                    const Text(
                      ' • ',
                      style: TextStyle(
                        color: Color(0xFF78909C),
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      sublabel,
                      style: const TextStyle(
                        color: Color(0xFF78909C),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const Icon(
            Icons.edit,
            color: Color(0xFF607D8B),
            size: 20,
          ),

          const SizedBox(width: 20),

          const Icon(
            Icons.delete_outline,
            color: Color(0xFF607D8B),
            size: 22,
          ),
        ],
      ),
    );
  }
}
