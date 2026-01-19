import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nxl_test/pages/onboarding/get_started.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _imagesLoaded = false;

  @override
  void initState() {
    super.initState();
    // Wait for first frame, then start loading
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeApp();
    });
  }

  Future<void> _initializeApp() async {
    try {
      // Precache all images from GetStartedPage
      await Future.wait([
        precacheImage(const AssetImage('assets/get1.jpg'), context),
        precacheImage(const AssetImage('assets/get2.jpg'), context),
        precacheImage(const AssetImage('assets/get3.jpg'), context),
      ]);

      if (mounted) {
        setState(() {
          _imagesLoaded = true;
        });
      }

      // Wait at least 3 seconds total (or until images load)
      await Future.delayed(const Duration(seconds: 3));

      // Navigate to GetStartedPage
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const GetStartedPage()),
        );
      }
    } catch (e) {
      print('Error loading images: $e');
      // Navigate anyway after 3 seconds even if images fail
      await Future.delayed(const Duration(seconds: 3));
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const GetStartedPage()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0D2847),
              Color(0xFF1A4B7F),
              Color(0xFF0D2847),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.table_chart,
                size: 95,
                color: Colors.white,
              ),
              const SizedBox(height: 24),
              Text(
                'NXL Techno',
                style: GoogleFonts.poppins(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Find Your Dream Career',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 50),
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
              const SizedBox(height: 16),
              // Optional: Show loading status
              if (!_imagesLoaded)
                Text(
                  'Loading resources...',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.white60,
                  ),
                )
              else
                Text(
                  'Ready!',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.greenAccent,
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}