import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    // Simulate some loading time or animation
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context)
          .pushReplacementNamed('/auth'); // Navigate to Auth screen
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Light theme background
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // DeepDo Logo (replace with your actual asset)
            Image.asset(
              'assets/logo/DeepDoLogo.png', // Make sure you have this asset
              width: 150,
              height: 150,
            ),
            const SizedBox(height: 24),
            Text(
              'DeepDo',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.blue[800], // Deep blue from your logo
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Stay focused. Get things done. Together.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[700],
              ),
            ),
            // Optional: Loading indicator
            const SizedBox(height: 48),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
            ),
          ],
        ),
      ),
    );
  }
}
