import 'package:flutter/material.dart';
import 'days_list_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Gradient background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFB2FEFA),
                  Color(0xFF6DD5FA),
                  Color(0xFFB993D6),
                ],
              ),
            ),
          ),
          // Top right icons
          SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.search, color: Colors.black54),
                    SizedBox(width: 12),
                    Icon(Icons.menu, color: Colors.black54),
                  ],
                ),
              ),
            ),
          ),
          // Centered FIT/NESS text with overlapping image
          Center(
            child: SizedBox(
              width: 340,
              height: 320,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // FIT text (top)
                  Positioned(
                    top: 60,
                    left: 0,
                    right: 0,
                    child: Text(
                      'FIT',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 64,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 2,
                        shadows: [Shadow(blurRadius: 8, color: Colors.black26)],
                      ),
                    ),
                  ),
                  // NESS text (bottom)
                  Positioned(
                    top: 170,
                    left: 0,
                    right: 0,
                    child: Text(
                      'NESS',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 64,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 2,
                        shadows: [Shadow(blurRadius: 8, color: Colors.black26)],
                      ),
                    ),
                  ),
                  // Main image (overlapping the split)
                  Positioned(
                    top: 80,
                    left: 0,
                    right: 0,
                    child: Image.asset(
                      'assets/main.png',
                      width: 320,
                      height: 140,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Find Your Strength card at the bottom
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(32),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'FIND YOUR STRENGTH',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const DaysListScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        shape: StadiumBorder(),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 12),
                      ),
                      child: const Text('Start Now'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
