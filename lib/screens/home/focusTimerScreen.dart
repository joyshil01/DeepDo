// ignore_for_file: avoid_print, unused_field

import 'package:deepdo/services/ads_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:async';

import '../../utils/colors.dart'; // For Timer

class FocusTimerScreen extends StatefulWidget {
  const FocusTimerScreen({Key? key}) : super(key: key);

  @override
  State<FocusTimerScreen> createState() => _FocusTimerScreenState();
}

class _FocusTimerScreenState extends State<FocusTimerScreen> {
  Timer? _timer;
  int _totalSeconds = 25 * 60; // Default Pomodoro 25 minutes
  int _currentSeconds = 25 * 60;
  bool _isRunning = false;
  bool _isFocusSession = true; // True for focus, false for break

  RewardedInterstitialAd? _rewardedInterstitialAd;
  bool _isAdLoaded = false;

  @override
  void initState() {
    _loadAd();
    super.initState();
  }

  void _loadAd() {
    RewardedInterstitialAd.load(
      adUnitId: AdHelper.getRewardedInterstitialUnitId,
      request: const AdRequest(),
      rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          print('Rewarded Interstitial Ad loaded.');
          setState(() {
            _rewardedInterstitialAd = ad;
            _isAdLoaded = true;
          });

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              print('Ad dismissed.');
              ad.dispose();
              _loadAd(); // Load the next ad
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              print('Ad failed to show: $error');
              ad.dispose();
              _loadAd();
            },
          );
        },
        onAdFailedToLoad: (error) {
          print('Failed to load rewarded interstitial ad: $error');
          setState(() {
            _isAdLoaded = false;
          });
        },
      ),
    );
  }

  void _showAd() {
    if (_rewardedInterstitialAd != null) {
      _rewardedInterstitialAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
          print('User earned reward: ${reward.amount} ${reward.type}');
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Reward received: ${reward.amount} ${reward.type}"),
          ));
        },
      );
      _rewardedInterstitialAd = null;
      _isAdLoaded = false;
    } else {
      print("Ad not ready yet.");
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _rewardedInterstitialAd?.dispose();
    super.dispose();
  }

  void _startTimer() {
    _showAd();
    setState(() {
      _isRunning = true;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_currentSeconds > 0) {
        setState(() {
          _currentSeconds--;
        });
      } else {
        _timer?.cancel();
        _playCompletionSound(); // Play a sound when timer finishes
        _logSession(); // Log the session
        setState(() {
          _isRunning = false;
          _isFocusSession = !_isFocusSession; // Toggle session type
          _totalSeconds =
              _isFocusSession ? 25 * 60 : 5 * 60; // Next session duration
          _currentSeconds = _totalSeconds; // Reset current seconds
        });
        // Optionally show a notification or prompt for next session
        _showCompletionDialog();
      }
    });
  }

  void _pauseTimer() {
    _showAd();
    setState(() {
      _isRunning = false;
    });
    _timer?.cancel();
  }

  void _resetTimer() {
    _showAd();
    _timer?.cancel();
    setState(() {
      _isRunning = false;
      _currentSeconds = _totalSeconds;
    });
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  void _playCompletionSound() {
    // Implement sound playback here (e.g., using audioplayers package)
    print('Timer finished sound played!');
  }

  void _logSession() {
    // Implement logging session to Firebase/local DB here
    print(
        'Session logged: Type=${_isFocusSession ? "Focus" : "Break"}, Duration=${_totalSeconds / 60} mins');
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(_isFocusSession ? 'Break Time!' : 'Focus Time!'),
        content: Text(
            'Your ${_isFocusSession ? "focus" : "break"} session has ended. Ready for the next one?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _startTimer(); // Start next session immediately
            },
            child: const Text('Start Now'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _resetTimer(); // Go back to idle state
            },
            child: const Text('Later'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Focus Timer'),
        backgroundColor: appColor.mainColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _isFocusSession ? 'Focus Session' : 'Break Session',
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: appColor.mainColor,
              ),
            ),
            const SizedBox(height: 40),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 250,
                  height: 250,
                  child: CircularProgressIndicator(
                    value: _currentSeconds / _totalSeconds,
                    strokeWidth: 15,
                    backgroundColor: appColor.mainColor.withOpacity(0.2),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      appColor.mainColor,
                    ),
                  ),
                ),
                Text(
                  _formatTime(_currentSeconds),
                  style: const TextStyle(
                    fontSize: 80,
                    fontWeight: FontWeight.bold,
                    color: appColor.mainColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!_isRunning)
                  ElevatedButton.icon(
                    onPressed: _startTimer,
                    icon: const Icon(Icons.play_arrow),
                    label: const Text('Start'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 15),
                    ),
                  ),
                if (_isRunning)
                  ElevatedButton.icon(
                    onPressed: _pauseTimer,
                    icon: const Icon(Icons.pause),
                    label: const Text('Pause'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 15),
                    ),
                  ),
                const SizedBox(width: 20),
                ElevatedButton.icon(
                  onPressed: _resetTimer,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Reset'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 15),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            // Soundscapes & Ambient Noise Options (simplified)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Soundscape',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.audiotrack),
                ),
                value: 'Rain', // Example value
                items: <String>[
                  'None',
                  'Rain',
                  'Forest',
                  'Coffee Shop',
                  'Ocean Waves'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  // Handle soundscape change
                  print('Selected soundscape: $newValue');
                },
              ),
            ),
            const SizedBox(height: 20),
            // Session logs (can be a button to navigate to a dedicated screen)
            TextButton.icon(
              onPressed: () {
                // Navigate to session logs screen
                print('View Session Logs');
              },
              icon: const Icon(Icons.history),
              label: const Text('View Session Logs'),
              style: TextButton.styleFrom(
                foregroundColor: appColor.TextButtonColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
