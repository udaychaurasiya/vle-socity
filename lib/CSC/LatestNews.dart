import 'dart:async';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vlesociety/Dashboard/controller/DashboardController.dart';
import 'package:vlesociety/Dashboard/model/FeedArticalModel.dart';
import 'package:vlesociety/Dashboard/view/SingleImageView.dart';
import 'package:vlesociety/Widget/CoustomAlertDailog.dart';
import '../../Ads/AdHelper.dart';
import '../../AppConstant/APIConstant.dart';
import '../../AppConstant/AppConstant.dart';
import '../../AppConstant/textStyle.dart';
import '../../Auth/controller/login_controller.dart';
import '../../Auth/model/StateModel.dart';
import '../../CSC/Model/CscModel.dart';
import '../../Widget/loading_widget.dart';
import '../Dashboard/model/ArticalModel.dart';
class LatestNews extends StatefulWidget {
  LatestNews({super.key});

  @override
  State<LatestNews> createState() => _LatestNewsState();
}

class _LatestNewsState extends State<LatestNews> {
  static const Color primaryColor = Color(0xffcacccc);
  final DashboardController controller = Get.find();
  final LoginController loginController = Get.put(LoginController());
  int selectedSize = -1;
  int selectedSize1 = 0;
  int selectedColor = -0;
  bool? isCategory = false;
  int? status = 0;
  String? catId = "0";
  int? filter = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getCommmunityCategoryNetworkApi();
    controller.getFeedArticalNetworkApi("");
    loginController.getStateNetworkApi();
    controller.getSiteLinkNetworkApi();
  }
  @override
  Widget build(BuildContext context)
  {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  SingleChildScrollView(
                    physics: ClampingScrollPhysics(),
                    child: Container(
                      child: Row(children: [
                        SizedBox(
                            width: 120.w,
                            height: 60.h,
                            child: InkWell(
                              onTap: ()
                              {
                                print("khkfjk");
                                controller.getFeedArticalNetworkApi("");
                                controller.feedArticalModel.refresh();
                                setState(()
                                {
                                  controller.setSelectedCategoryOfArtical.value = 1;
                                  controller.selectedIndexOfArtical.value = 0;
                                  isCategory = false;
                                  status = 0;
                                  catId = "1";
                                  selectedSize = -1;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: AnimatedContainer(
                                  decoration: BoxDecoration(
                                    color: selectedSize == -1
                                        ? primaryColor
                                        : Colors.transparent,
                                    border: Border.all(
                                      color: Colors.black12,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  duration: const Duration(milliseconds: 200),
                                  child: Center(
                                    child: Padding(
                                      padding: EdgeInsets.all(10.w),
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 35.h,
                                            width: 35.w,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(100),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.transparent
                                                        .withOpacity(0.2),
                                                    offset: Offset(-3.0, -3.0),
                                                    blurRadius: 10.0,
                                                  ),
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.1),
                                                    offset: Offset(3.0, 3.0),
                                                    blurRadius: 10.0,
                                                  ),
                                                ],
                                                color: Colors.white,
                                                image: new DecorationImage(
                                                  image: new AssetImage(
                                                      "assets/images/feed.png"),
                                                )),
                                          ),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          Text(
                                            "Feed",
                                            style: bodyText1Style.copyWith(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500,
                                                color: selectedSize == -1
                                                    ? Colors.white
                                                    : Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )),
                        SizedBox(
                            width: MediaQuery.of(context).size.width / 1.5,
                            height: 60.h,
                            child: Obx(
                                  () => controller.communityCategoryModel.value.data != null
                                  ? ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: controller
                                      .communityCategoryModel
                                      .value
                                      .data!
                                      .length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    var current = controller
                                        .communityCategoryModel
                                        .value
                                        .data![index];
                                    return GestureDetector(
                                      onTap: () {
                                        controller
                                            .setSelectedCategoryOfArtical
                                            .value = 2;
                                        controller
                                            .selectedIndexOfArtical
                                            .value = 1;
                                        // Get.to(()=>ArticalDetailsPage());
                                        setState(() {
                                          controller
                                              .getArticleByCategoryNetworkApi(controller.communityCategoryModel
                                              .value
                                              .data![index]
                                              .id
                                              .toString());
                                          isCategory = true;
                                          selectedSize = index;
                                          status = 1;
                                          catId = controller
                                              .communityCategoryModel
                                              .value
                                              .data![index]
                                              .id
                                              .toString();
                                        });
                                      },
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.all(10.0),
                                        child: AnimatedContainer(
                                          decoration: BoxDecoration(
                                            color: selectedSize == index
                                                ? primaryColor
                                                : Colors.transparent,
                                            border: Border.all(
                                              color: Colors.black12,
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(
                                                10),
                                          ),
                                          duration: const Duration(
                                              milliseconds: 200),
                                          child: Center(
                                            child: Padding(
                                              padding:
                                              EdgeInsets.all(10),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    height: 35,
                                                    width: 35,
                                                    decoration:
                                                    BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors
                                                                .transparent
                                                                .withOpacity(0.2),
                                                            offset: Offset(
                                                                -3.0,
                                                                -3.0),
                                                            blurRadius:
                                                            10.0,
                                                          ),
                                                          BoxShadow(
                                                            color: Colors
                                                                .black
                                                                .withOpacity(0.1),
                                                            offset: Offset(
                                                                3.0,
                                                                3.0),
                                                            blurRadius:
                                                            10.0,
                                                          ),
                                                        ],
                                                        color: Colors
                                                            .white,
                                                        image: DecorationImage(
                                                            image: NetworkImage(BASE_URL +
                                                                controller.communityCategoryModel.value.data![index].image.toString()))),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    controller
                                                        .communityCategoryModel
                                                        .value
                                                        .data![index]
                                                        .title
                                                        .toString(),
                                                    style: bodyText1Style.copyWith(
                                                        fontSize: 15,
                                                        fontWeight:
                                                        FontWeight
                                                            .w500,
                                                        color: selectedSize ==
                                                            index
                                                            ? Colors
                                                            .white
                                                            : Colors
                                                            .black),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  })
                                  :  Container(),
                            )),
                      ]),
                    ),
                  ),
                  Obx(()=>controller.siteLink.value.data!=null
                      ? Container(
                    height: 40.h,
                    width: Get.width,
                    child: ListView.builder(
                        itemCount:controller.siteLink.value.data!.length,
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context,index){
                          final site=controller.siteLink.value.data![index];
                          _luncherMail() async {
                            final url = site.url.toString();
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          }
                          return InkWell(
                            onTap: _luncherMail,
                            child: Card(
                              elevation: 0,
                              child: Container(
                                height: 30.h,
                                padding: EdgeInsets.only(left: 5.w,right: 5.w),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    border: Border.all(),
                                    color: Colors.orange
                                ),
                                child: Center(child: Text(site.title.toString(),style: TextStyle(color: Colors.white,fontSize: 13.sp/*fontWeight: FontWeight.bold*/
                                ),)),
                              ),
                            ),
                          );
                        }),
                  )
                      : SizedBox()
                  ),
                  isCategory == false ?
                  Obx(() => Column(
                    children: [
                      Obx(() => controller.feedArticalModel.value.data != null ?
                      ListView.separated(
                        padding: EdgeInsets.all(15),
                        shrinkWrap: true,
                        reverse: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: controller.feedArticalModel.value.data!.length,
                        separatorBuilder:
                            (BuildContext context, int index) =>
                            Divider(
                              height: 15,
                              thickness: 1.9,
                              color: Colors.grey.withOpacity(0.2),
                            ),
                        itemBuilder:
                            (BuildContext context, int index)
                        {
                          final datas = controller
                              .feedArticalModel
                              .value
                              .data![index];
                          print("" + datas.url.toString());
                          return Padding(
                            padding: const EdgeInsets.only(
                                top: 6.0, bottom: 6.0),
                            child: InkWell(
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
                                                    _showBottomSheetFeedArtcal(
                                                        context, datas);
                                                  }

                                              );
                                        },
                                        onAdFailedToLoad: (err) {
                                          debugPrint(err.message);
                                        },
                                      ));
                                }else
                                {
                                  _showBottomSheetFeedArtcal(
                                      context, datas);
                                }





                              },
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      datas.title.toString(),
                                      style: bodyText1Style.copyWith(fontSize: 17,height: 1.2

                                      ),
                                      overflow:
                                      TextOverflow.ellipsis,
                                      maxLines: 3,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  ClipRRect(
                                    borderRadius:
                                    BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl:
                                      datas.url.toString(),
                                      height: 75,
                                      width: 75,
                                      placeholder: (context,
                                          url) =>
                                          Center(
                                              child:
                                              const CircularProgressIndicator()),
                                      errorWidget: (context, url,
                                          error) =>
                                      const Icon(Icons.error),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      )
                          : Container()),
                      controller.setCategoryOfArtical.value == 1
                          ? controller.isLoadingPageArtical.value ? const LoadingWidget()
                          : Container()
                          : Container()
                    ],
                  ))
                      :
                  filter == 0 ?
                  Obx(() => controller.articleModelByCategory.value.data != null ?
                  ListView.separated(
                    padding: EdgeInsets.all(10),
                    shrinkWrap: true,
                    reverse: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: controller.articleModelByCategory
                        .value.data!.length,
                    separatorBuilder:
                        (BuildContext context, int index) =>
                        Divider(
                          height: 5,
                          thickness: 1.6,
                          color: Colors.grey.withOpacity(0.2),
                        ),
                    itemBuilder:
                        (BuildContext context, int index) {
                      final datas = controller
                          .articleModelByCategory
                          .value
                          .data![index];
                      return Padding(
                        padding: const EdgeInsets.only(
                            top: 6.0, bottom: 6.0),
                        child: InkWell(
                          onTap: () {
                            _showBottomSheet(context, datas);
                          },
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  datas.title.toString(),
                                  style: bodyText1Style.copyWith(fontSize: 17,height: 1.2
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              ClipRRect(
                                borderRadius:
                                BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl: BASE_URL +
                                      datas.image.toString(),
                                  height: 75,
                                  width: 75,
                                  placeholder: (context, url) =>
                                      Center(
                                          child:
                                          const CircularProgressIndicator()),
                                  errorWidget:
                                      (context, url, error) =>
                                  const Icon(Icons.error),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  )
                      : Center(
                  )) : Obx(() => controller
                      .articleModelWithFilter.value.data !=
                      null
                      ? ListView.separated(
                    padding: EdgeInsets.all(10),
                    shrinkWrap: true,
                    reverse: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: controller.articleModelWithFilter
                        .value.data!.length,
                    separatorBuilder:
                        (BuildContext context, int index) =>
                        Divider(
                          height: 5,
                          thickness: 1.6,
                          color: Colors.grey.withOpacity(0.2),
                        ),
                    itemBuilder:
                        (BuildContext context, int index) {
                      final datas = controller
                          .articleModelWithFilter
                          .value
                          .data![index];
                      return Padding(
                        padding: const EdgeInsets.only(
                            top: 6.0, bottom: 6.0),
                        child: InkWell(
                          onTap: () {
                            _showBottomSheet(context, datas);
                          },
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  datas.title.toString(),
                                  style: bodyText1Style,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              ClipRRect(
                                borderRadius:
                                BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl: BASE_URL +
                                      datas.image.toString(),
                                  height: 75,
                                  width: 75,
                                  placeholder: (context, url) =>
                                      Center(
                                      ),
                                  errorWidget:
                                      (context, url, error) =>
                                  const Icon(Icons.error),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  )
                      : Container())
                ],
              ),
            ],
          ),
        ),
        status == 0
            ? Container()
            : Positioned(
            right: 10,
            top: Get.height / 9,
            child: Align(
                alignment: Alignment.centerRight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        _showBottomSheetFilter(context, catId!);
                      },
                      child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xff1200FF).withOpacity(0.1),
                            border: Border.all(
                                width: 1,
                                color: Colors.red.withOpacity(0.1)),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(255, 255, 255, 0.7),
                                blurRadius: 10,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: Image.asset(
                            "assets/images/filter.png",
                            height: 30,
                            width: 30,
                          )

                      ),
                    )


                  ],
                ))),
      ],
    );
  }
  void _showBottomSheet(BuildContext context, ArticleDatum datum) {
    showModalBottomSheet(
      context: context,
      barrierColor: Colors.black.withOpacity(0.12),
      isScrollControlled: true,
      backgroundColor: Colors.white70,
      builder: (context) {
        return ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
                padding: EdgeInsets.only(right: 10, top: 10, left: 10),
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
                      child: InkWell(
                        onTap: (){
                          Get.to(SingleImageView(BASE_URL +  datum.image.toString()));
                        },
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: BASE_URL + datum.image.toString(),
                          height: 200,
                          width: double.infinity,
                          placeholder: (context, url) =>
                              Center(child: const CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: Get.height / 2 + 20,
                      width: double.infinity,
                      child: SingleChildScrollView(
                        child: Column(
                          children:
                          [
                            Text(
                              datum.title.toString(),
                              style: bodyText1Style.copyWith(fontSize: 17),
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
                                data: datum.description.toString(),
                                style: {
                                  "body": Style(
                                      fontSize: FontSize(17.0),
                                      //  letterSpacing: 1.2,
                                      lineHeight: LineHeight(1.8),
                                      textAlign: TextAlign.justify



                                  ),
                                },

                                onLinkTap: (String? url,

                                    Map<String, String> attributes,
                                    element) async
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
  void _showBottomSheetFeedArtcal(BuildContext context, Datum1 datum) {
    String value = datum.description.toString();
    String result = value.replaceAll("[fusion_button", "");
    String result1 = result.replaceAll("/]", "");
    print("sdfh" + value);
    showModalBottomSheet(
      context: context,
      barrierColor: Colors.black.withOpacity(0.12),
      isScrollControlled: true,
      backgroundColor: Colors.white70,
      builder: (context) {
        return ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
                padding: EdgeInsets.only(right: 10, top: 10, left: 10),
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      width: 40.w,
                      height: 6.h,
                      decoration: BoxDecoration(
                          border: Border.all(width: 0.5, color: Colors.black26),
                          borderRadius: BorderRadius.circular(10)),
                    ),

                    SizedBox(
                      height: 20.h,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: InkWell(
                        onTap: (){
                          Get.to(SingleImageView(BASE_URL +  datum.url.toString()));
                        },
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          //imageUrl: BASE_URL + datum.image.toString(),
                          imageUrl: datum.url.toString(),
                          height: 200.h,
                          width: double.infinity,
                          placeholder: (context, url) =>
                              Center(child: const CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              Image.asset("assets/images/vleSociety.jpg"),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: Get.height / 1.6,
                      width: double.infinity,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Text(
                              datum.title.toString(),
                              style: bodyText1Style.copyWith(fontSize:17 ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Divider(
                              height: 3,
                              thickness: 2,
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Html(
                                data: result1.toString(),
                                style: {
                                  "body": Style(
                                      fontSize: FontSize(17.0),
                                      //  letterSpacing: 1.2,
                                      lineHeight: LineHeight(1.8),
                                      textAlign: TextAlign.justify



                                  ),
                                },
                                onLinkTap: (String? url,

                                    Map<String, String> attributes,
                                    element) async {
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
  void _showBottomSheetFilter(BuildContext context, String cat_Id) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        insetPadding: EdgeInsets.only(
          left: 100.w,
        ),
        backgroundColor: Colors.transparent,
        child: Card(
          child: Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(1),bottomRight: Radius.circular(1),topLeft: Radius.circular(15.r),topRight: Radius.circular(1),)
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.close,
                          color: Colors.grey,
                        )),
                  ],
                ),
                Text(
                  "Filter by State Name    ",
                  style: bodyText1Style.copyWith(
                    color: Colors.red,
                    fontSize: 20.sp,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Obx(() => loginController.stateData.value.data != null
                    ? SingleChildScrollView(
                  child: Container(
                      padding: EdgeInsets.only(
                        left: 10,
                      ),
                      height: Get.height/1.25,
                      child: GridView.count(
                        childAspectRatio: 5.5,
                        crossAxisCount: 1,
                        crossAxisSpacing: 1,
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        children: List.generate(
                          loginController.stateData.value.data!.length,
                              (index) {
                            return GestureDetector(
                              onTap: () {
                                selectedSize1 = index;
                                controller.getArticleWithFilterNetworkApi(
                                    cat_Id,
                                    loginController.stateData.value
                                        .data![index].stateId
                                        .toString());
                                setState(() {
                                  //controller.getArticleByCategoryNetworkApi( controller.communityCategoryModel.value.data![index].id.toString());
                                  filter = 1;
                                  isCategory = true;
                                });
                                Get.back();
                              },
                              child: Container(
                                child: Text(
                                  loginController.stateData.value
                                      .data![index].stateTitle
                                      .toString(),
                                  style: bodyText1Style.copyWith(
                                    color: selectedSize1 == index
                                        ? Colors.orange
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )),
                )
                    : Center())
              ],
            ),
          ),
        ),
      ),
    );
  }
}
