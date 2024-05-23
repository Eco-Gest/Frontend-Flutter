import 'package:ecogest_front/helper/ad_helper.dart';
import 'package:flutter/material.dart';
import 'package:ecogest_front/assets/ecogest_theme.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class PostListAdWidget extends StatefulWidget {
  const PostListAdWidget({
    super.key,
  });

  @override
  _PostListAdWidget createState() => _PostListAdWidget();
}

class _PostListAdWidget extends State<PostListAdWidget> {
  NativeAd? nativeAd;
  bool _nativeAdIsLoaded = false;

  @override
  void initState() {
    super.initState();

    loadAd();
  }

  @override
  Widget build(BuildContext context) {
    if (_nativeAdIsLoaded && nativeAd != null) {
      return SizedBox(
          height: 300,
          width: MediaQuery.of(context).size.width,
          child: AdWidget(ad: nativeAd!));
    }
    return SizedBox.shrink();
  }

  /// Loads a native ad.
  void loadAd() {
    setState(() {
      _nativeAdIsLoaded = false;
    });

    nativeAd = NativeAd(
        adUnitId: AdHelper.nativeAdUnitId,
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            debugPrint('$NativeAd loaded.');
            setState(() {
              _nativeAdIsLoaded = true;
            });
          },
          onAdFailedToLoad: (ad, error) {
            // Dispose the ad here to free resources.
            debugPrint('$NativeAd failed to load: $error');
            ad.dispose();
          },
          onAdClicked: (ad) {},
          onAdImpression: (ad) {},
          onAdClosed: (ad) {},
          onAdOpened: (ad) {},
          onAdWillDismissScreen: (ad) {},
          onPaidEvent: (ad, valueMicros, precision, currencyCode) {},
        ),
        request: const AdRequest(),
        // Styling
        nativeTemplateStyle: NativeTemplateStyle(
            // Required: Choose a template.
            templateType: TemplateType.medium,
            // Optional: Customize the ad's style.
            mainBackgroundColor: lightColorScheme.onPrimary,
            cornerRadius: 10.0,
            callToActionTextStyle: NativeTemplateTextStyle(
                textColor: Colors.cyan,
                backgroundColor: lightColorScheme.primary,
                style: NativeTemplateFontStyle.monospace,
                size: 16.0),
            primaryTextStyle: NativeTemplateTextStyle(
                textColor: lightColorScheme.primary,
                backgroundColor: Colors.cyan,
                style: NativeTemplateFontStyle.italic,
                size: 16.0),
            secondaryTextStyle: NativeTemplateTextStyle(
                textColor: Colors.green,
                backgroundColor: Colors.black,
                style: NativeTemplateFontStyle.bold,
                size: 16.0),
            tertiaryTextStyle: NativeTemplateTextStyle(
                textColor: Colors.brown,
                backgroundColor: lightColorScheme.secondary,
                style: NativeTemplateFontStyle.normal,
                size: 16.0)))
      ..load();
  }
}
