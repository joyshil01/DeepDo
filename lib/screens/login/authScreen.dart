// ignore_for_file: deprecated_member_use, dead_code, file_names, use_build_context_synchronously, avoid_print

import 'dart:io';
import 'package:deepdo/services/ads_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import '../../providers/authService.dart';
import '../../utils/colors.dart'; // Assuming this file defines appColor.mainColor

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  // Create an instance of your AuthService
  // final _authService = AuthService();

  InterstitialAd? _interstitialAd;

  @override
  void initState() {
    super.initState();
    _checkIfLoggedIn();
    checkLoginStatus();

    InterstitialAd.load(
      adUnitId: AdHelper.getInterstatialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
              onAdDismissedFullScreenContent: (ad) {});
          setState(() {
            _interstitialAd = ad;
          });
        },
        onAdFailedToLoad: (err) {
          print('Failed to load an interstatial ad: ${err.message}');
        },
      ),
    );
  }

  Future<void> _checkIfLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString('user_email');

    if (savedEmail != null && savedEmail.isNotEmpty) {
      Navigator.pushReplacementNamed(context, '/main_wrapper');
    }
  }

  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString('user_name');

    if (name != null) {
      Navigator.pushReplacementNamed(context, '/main_wrapper');
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  Future<void> handleGuestLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('user_name') == null) {
      int guestCounter = prefs.getInt('guest_counter') ?? 1;
      String guestName = 'guest${guestCounter.toString().padLeft(4, '0')}';
      await prefs.setString('user_name', guestName);
      await prefs.setString('user_email', '');
      await prefs.setInt('guest_counter', guestCounter + 1);
    }

    Navigator.pushReplacementNamed(context, '/main_wrapper');
  }

  // bool _isLoading = false;
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

                  // _isLoading
                  //     ? const CircularProgressIndicator() // 👈 Show this while signing in
                  //     : ElevatedButton.icon(
                  //         style: OutlinedButton.styleFrom(
                  //           foregroundColor: appColor.mainColor,
                  //           side: const BorderSide(color: appColor.mainColor),
                  //           padding: const EdgeInsets.symmetric(
                  //               horizontal: 70, vertical: 5),
                  //         ),
                  //         icon: const Icon(
                  //           Icons
                  //               .g_mobiledata, // You can use a real Google icon here
                  //           color: appColor.mainColor,
                  //         ),
                  //         label: const Text("Sign in with Google"),
                  //         onPressed: () async {
                  //           setState(() {
                  //             _isLoading = true; // 🔄 Start loading
                  //           });

                  //           final user = await _authService.signInWithGoogle();

                  //           if (user != null) {
                  //             final prefs =
                  //                 await SharedPreferences.getInstance();
                  //             await prefs.setString(
                  //                 'user_name', user.displayName ?? '');
                  //             await prefs.setString(
                  //                 'user_email', user.email ?? '');

                  //             if (!mounted) return;
                  //             Navigator.pushReplacementNamed(
                  //                 context, '/main_wrapper');
                  //           } else {
                  //             if (mounted) {
                  //               ScaffoldMessenger.of(context).showSnackBar(
                  //                 const SnackBar(content: Text("Login failed")),
                  //               );
                  //             }
                  //           }

                  //           if (mounted) {
                  //             setState(() {
                  //               _isLoading = false; // ✅ Stop loading
                  //             });
                  //           }
                  //         },
                  //       ),

                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: appColor.mainColor,
                      side: const BorderSide(color: appColor.mainColor),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 70, vertical: 5),
                    ),
                    icon: const Icon(
                      Icons.person_outline,
                      color: appColor.mainColor,
                    ),
                    label: const Text("Start"),
                    onPressed: () async {
                      _interstitialAd?.show();
                      await handleGuestLogin();
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
