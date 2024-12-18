import 'package:google_mobile_ads/google_mobile_ads.dart';

class AddManger{
  static bool isTest = false;
  static String bannerOne = isTest ? '/6499/example/banner':"ca-app-pub-9717945207816583/4283013876";

  static String bannerTwo = isTest ? '/6499/example/banner':"ca-app-pub-9717945207816583/4663972033";

  static String adsOne = isTest ? 'ca-app-pub-3940256099942544/1033173712':"ca-app-pub-9717945207816583/5275180271";
  static String adsTwo = isTest ? 'ca-app-pub-3940256099942544/1033173712':"ca-app-pub-9717945207816583/1335935263";


}



class Ads {
  InterstitialAd? interstitialAd;

  void showAdsOne()
  {
    InterstitialAd.load(
        adUnitId: AddManger.adsOne,
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            interstitialAd = ad;
            if(interstitialAd != null)
            {
              interstitialAd!.show();
            }
            ad.fullScreenContentCallback  = FullScreenContentCallback(
              onAdWillDismissFullScreenContent: (ad) {

                ad.dispose();

              },
              onAdFailedToShowFullScreenContent: (ad, error) {
                ad.dispose();
              },
            );
          },
          onAdFailedToLoad: (error) {
            print(error);
          },
        )
    );
  }


  void showAdsTwo()
  {
    InterstitialAd.load(
        adUnitId: AddManger.adsTwo,
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            interstitialAd = ad;
            if(interstitialAd != null)
            {
              interstitialAd!.show();
            }
            ad.fullScreenContentCallback  = FullScreenContentCallback(
              onAdWillDismissFullScreenContent: (ad) {

                ad.dispose();

              },
              onAdFailedToShowFullScreenContent: (ad, error) {
                ad.dispose();
              },
            );
          },
          onAdFailedToLoad: (error) {
            print(error);
          },
        )
    );
  }
}