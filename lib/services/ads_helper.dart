import 'dart:io';

class AdHelper {
  // static String get bannerAdUnitId {
  //   if (Platform.isAndroid) {
  //     return 'ca-app-pub-8921243494709334/4497643977';
  //   } else if (Platform.isIOS) {
  //     return '<Your_IOS_BANNER_AD_ID>';
  //   } else {
  //     throw UnsupportedError('Unsupported platform');
  //   }
  // }

  static String get getInterstatialAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-8921243494709334/7236601340';
    } else if (Platform.isIOS) {
      return '<Your_IOS_BANNER_AD_ID>';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get getRewardedInterstitialUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-8921243494709334/3122930660';
    } else if (Platform.isIOS) {
      return '<Your_IOS_BANNER_AD_ID>';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}
