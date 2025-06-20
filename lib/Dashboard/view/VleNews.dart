
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vlesociety/Dashboard/view/profile.dart';
import 'package:vlesociety/Widget/AppBarWidget2.dart';

import '../../Ads/AdHelper.dart';
import '../../AppConstant/APIConstant.dart';
import '../../AppConstant/AppConstant.dart';
import '../../AppConstant/textStyle.dart';
import '../../Widget/CustomAppBarWidget.dart';
import '../../Widget/loading_widget.dart';
import '../controller/DashboardController.dart';
import '../model/FeedArticalModel.dart';

class VleNews extends StatefulWidget
{  VleNews({Key? key}) : super(key: key);
  @override
  State<VleNews> createState() => _VleNewsState();
}

class _VleNewsState extends State<VleNews>
{
  DashboardController controller = Get.find();

  Widget getAd()
  {
    BannerAdListener bannerAdListener=BannerAdListener(onAdWillDismissScreen: (ad)
    {
      ad.dispose();
    },onAdClicked: (ad){
      print("Ad got closed");
    });
    BannerAd bannerAd=BannerAd(
        size:  AdSize.banner,
        adUnitId: AdHelper.bannerAdUnitId,
        request:  const AdRequest(),

        listener: BannerAdListener(
          // Called when an ad is successfully received.
          onAdLoaded: (ad)
          {
            debugPrint('$ad loaded.');

          },
          // Called when an ad request failed.
          onAdFailedToLoad: (ad, err)
          {
            debugPrint('BannerAd failed to load: $err');
            // Dispose the ad here to free resources.
            ad.dispose();
          },

          onAdOpened: (Ad ad) {},
          // Called when an ad removes an overlay that covers the screen.
          onAdClosed: (Ad ad) {

          },
          // Called when an impression occurs on the ad.
          onAdImpression: (Ad ad) {},

        )
    );

    bannerAd.load();
    return SizedBox(
      height: 100,

      child: AdWidget(ad: bannerAd),

    );
  }
  _launchURL() async
  {
    const url = 'https://hellokart.com/';
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }
  @override
  Widget build(BuildContext context)
  {
    controller.getFeedArticalNetworkApi("");
    return
      Scaffold
      (
        bottomNavigationBar: getAd() ,
        appBar:
      PreferredSize(
          preferredSize: Size(
            double.infinity,
            60.0,
          ),
          child: CustomAppBar2(
              title: GetStorage().read(AppConstant.userName).toString().trim(),
              Points: controller.points.toString().trim(),
              image:BASE_URL+GetStorage().read(AppConstant.profileImg),
            onPress: _launchURL,
          )
      ),
      body:
      SingleChildScrollView(
        controller: controller.scrollController2,
        child: Column(
          children: [
            Obx(
                    () =>Column(
                  children:
                  [
                    Obx(() =>controller.feedArticalModel.value.data != null
                        ? ListView.separated(

                      padding: EdgeInsets.all(15),
                      shrinkWrap: true,
                      reverse: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: controller.feedArticalModel.value.data!.length,
                      separatorBuilder: (BuildContext context, int index) =>
                          Divider(
                            height: 15,
                            thickness: 1.9,
                            color: Colors.grey.withOpacity(0.2),
                          ),
                      itemBuilder: (BuildContext context, int index)
                      {
                        final datas = controller.feedArticalModel.value.data![index];
                        print(""+datas.url.toString());
                        return Padding
                          (
                          padding: const EdgeInsets.only(top: 6.0,bottom: 6.0),
                          child: InkWell
                            (
                            onTap: ()
                            {
                              if(controller.settingModel.value.data!.adsStatus.toString()=="1")
                              {
                                InterstitialAd? interstitialAd;
                                InterstitialAd.load(
                                    adUnitId:  AdHelper.interstitialAdUnitId,
                                    request: const AdRequest(),
                                    adLoadCallback: InterstitialAdLoadCallback(
                                      onAdLoaded: (ad)
                                      {

                                        interstitialAd = ad;
                                        interstitialAd!.show();
                                        interstitialAd!.fullScreenContentCallback =
                                            FullScreenContentCallback(
                                                onAdFailedToShowFullScreenContent: ((ad, error) {
                                                  ad.dispose();
                                                  interstitialAd!.dispose();
                                                  debugPrint(error.message);
                                                }),
                                                onAdDismissedFullScreenContent: (ad) {
                                                  ad.dispose();
                                                  interstitialAd!.dispose();
                                                  _showBottomSheetFeedArtcal(context, datas);
                                                }

                                            );
                                      },
                                      onAdFailedToLoad: (err) {
                                        debugPrint(err.message);
                                      },
                                    ));
                              }else
                              {
                                _showBottomSheetFeedArtcal(context, datas);
                              }




                            },
                            child: Row
                              (
                              children:
                              [
                                Expanded(child:
                                Text(
                                  datas.title.toString(),
                                  style: bodyText1Style,overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                ),),

                                SizedBox(width: 10,),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl:  datas.url.toString(),
                                    height: 75,
                                    width: 75,
                                    placeholder: (context, url) =>
                                        Center(child: const CircularProgressIndicator()),
                                    errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                  ),
                                )

                              ],
                            ),
                          ),
                        );
                      },
                    )
                        :Container()),
                    controller.isLoadingVleNewsPage.value?const LoadingWidget():Container()
                  ],
                )
            )
          ],
        ),
      ),

    );
  }

void _showBottomSheetFeedArtcal(BuildContext context, Datum1 datum)
{
  String value= datum.description.toString();
  String result = value.replaceAll("[fusion_button", "");
  String result1 = result.replaceAll("/]", "");
  print("sdfh"+value);
  showModalBottomSheet(
    context: context,
    barrierColor: Colors.black.withOpacity(0.12),
    isScrollControlled: true,
    backgroundColor: Colors.white70,
    builder: (context) {
      return
        ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
                padding: EdgeInsets.only(right: 10,top: 10,left: 10),

                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 40,
                      height: 6,
                      decoration: BoxDecoration(
                          border: Border.all(width: 0.5, color: Colors.black26),
                          borderRadius: BorderRadius.circular(10)),
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        //imageUrl: BASE_URL + datum.image.toString(),
                        imageUrl: datum.url.toString(),
                        height: 200,
                        width: double.infinity,
                        placeholder: (context, url) => Center(child: const CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>Image.asset("assets/images/vleSociety.jpg"),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height:Get.height/1.5,
                      width: double.infinity,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Text(
                              datum.title.toString(),
                              style: bodyText1Style,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Divider(
                              height: 3,
                              thickness: 2,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Html(
                                data: result1.toString(),
                                style: {
                                  "body": Style(
                                      fontSize: FontSize(16.0),
                                      //  letterSpacing: 1.2,
                                      lineHeight: LineHeight(1.8),
                                      textAlign: TextAlign.justify



                                  ),
                                },
                                onLinkTap:
                                    (String? url, Map<String,
                                    String> attributes,
                                    element)
                                async
                                {
                                  await launch(url!);
                                }),


                          ],
                        ),
                      ),
                    ),

                    // ListView.separated(itemBuilder: itemBuilder, separatorBuilder: separatorBuilder, itemCount: itemCount)
                  ],
                )),
          ),
        );
    },
  );
}
}
