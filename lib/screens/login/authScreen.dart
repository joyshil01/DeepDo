// ignore_for_file: deprecated_member_use, dead_code, file_names, use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../providers/authService.dart';
import '../../utils/colors.dart'; // Assuming this file defines appColor.mainColor

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  // Create an instance of your AuthService
  final _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _checkIfLoggedIn();
  }

  Future<void> _checkIfLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString('user_email');

    if (savedEmail != null && savedEmail.isNotEmpty) {
      Navigator.pushReplacementNamed(context, '/main_wrapper');
    }
  }

  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        exit(0);
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/efg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Lottie.asset(
                    'assets/json/loginDo.json',
                    height: height * 0.4,
                  ),
                  const Text(
                    "Welcome to DeepDo",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const Spacer(),
                  // Inside your AuthScreen.dart's build method

                  _isLoading
                      ? const CircularProgressIndicator() // 👈 Show this while signing in
                      : ElevatedButton.icon(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: appColor.mainColor,
                            side: const BorderSide(color: appColor.mainColor),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 70, vertical: 5),
                          ),
                          icon: const Icon(
                            Icons
                                .g_mobiledata, // You can use a real Google icon here
                            color: appColor.mainColor,
                          ),
                          label: const Text("Sign in with Google"),
                          onPressed: () async {
                            setState(() {
                              _isLoading = true; // 🔄 Start loading
                            });

                            final user = await _authService.signInWithGoogle();

                            if (user != null) {
                              final prefs =
                                  await SharedPreferences.getInstance();
                              await prefs.setString(
                                  'user_name', user.displayName ?? '');
                              await prefs.setString(
                                  'user_email', user.email ?? '');

                              if (!mounted) return;
                              Navigator.pushReplacementNamed(
                                  context, '/main_wrapper');
                            } else {
                              if (mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Login failed")),
                                );
                              }
                            }

                            if (mounted) {
                              setState(() {
                                _isLoading = false; // ✅ Stop loading
                              });
                            }
                          },
                        ),
                  const Spacer(flex: 2),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
