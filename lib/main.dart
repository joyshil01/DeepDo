// ignore_for_file: avoid_print, depend_on_referenced_packages

import 'package:deepdo/app.dart';
import 'package:deepdo/services/fcm_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Background FCM: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  RequestConfiguration configuration = RequestConfiguration(
    tagForChildDirectedTreatment: TagForChildDirectedTreatment.yes,
  );
  MobileAds.instance.updateRequestConfiguration(configuration);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp();
  }

  await FCMService.initializeFCM();

  runApp(const DeepDoApp());
}
