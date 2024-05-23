import 'dart:io';
import 'package:flutter_config/flutter_config.dart';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return FlutterConfig.get('AD_MOB_GOOGLE_BANNER_AD_ID').toString();
    } else if (Platform.isIOS) {
      return '<YOUR_IOS_BANNER_AD_UNIT_ID>';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return FlutterConfig.get('AD_MOB_GOOGLE_INTERSTITIAL_AD_ID').toString();
    } else if (Platform.isIOS) {
      return '<YOUR_IOS_INTERSTITIAL_AD_UNIT_ID>';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get nativeAdUnitId {
    if (Platform.isAndroid) {
      return FlutterConfig.get('AD_MOB_GOOGLE_NATIVE_AD_ID').toString();
    } else if (Platform.isIOS) {
      return '<YOUR_IOS_REWARDED_AD_UNIT_ID>';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}
