import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:vlesociety/Dashboard/controller/DashboardController.dart';
import 'package:vlesociety/Dashboard/view/Artical.dart';
import 'package:vlesociety/Dashboard/view/dashboard.dart';

import '../../AppConstant/APIConstant.dart';
import '../../AppConstant/textStyle.dart';
import '../Ads/AdHelper.dart';
import '../Dashboard/model/ArticalModel.dart';
import '../Dashboard/view/MyAsk.dart';
import '../Dashboard/view/Services.dart';
import '../Dashboard/view/ServicesDescription.dart';
import '../Dashboard/view/quize.dart';
import '../Widget/loading_widget.dart';
import 'LatestNews.dart';
import 'View/CscDetails.dart';

class CSCHome extends StatefulWidget {
  CSCHome({super.key});

  @override
  State<CSCHome> createState() => _CSCHomeState();
}

class _CSCHomeState extends State<CSCHome> with TickerProviderStateMixin {
  DashboardController controller = Get.find();

  late TabController tabController;
  AnimationController? _controller;
  Animation<double>? _animation;
  ScrollController _scrollController = ScrollController();

  void _scrollBy100() {
    _scrollController.animateTo(
      _scrollController.offset + 100,
      duration: Duration(milliseconds: 500), // You can adjust the duration as needed
      curve: Curves.easeInOut,
    );
  }

  @override
  void initState()
  {
    super.initState();
    controller.getBannerNetworkApi();
    controller.getServicesCSCNetworkApi();
    controller.getArticleByCategoryNetworkApi( "7");
    tabController = TabController(length: 2, vsync: this);
    _controller = AnimationController(
        duration: const Duration(seconds: 1),
        vsync: this,
        value: 0,
        lowerBound: 0,
        upperBound: 1);
    _animation =
        CurvedAnimation(parent: _controller!, curve: Curves.fastOutSlowIn);
    _controller!.forward();
  }

  @override
  void dispose()
  {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    controller.getServicesCSCNetworkApi();
    controller.getArticleByCategoryNetworkApi( "7");
    print(controller.articleModelByCategory.value.data);
    return Container(
      margin: EdgeInsets.only(left: 10.w, right: 10.w),
      child:Obx(() =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children:
        [
          SizedBox(
            height: 8.h,
          ),
          Container(
            child:controller.bannerModel.value.data!= null ?
            Container(child: CarouselSlider(
              options: CarouselOptions(
                height: 140.h,
                viewportFraction: 1,
                aspectRatio: 16/9,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                enlargeFactor: 0.3,



              ),
              items: controller.bannerModel.value.data!.map((i)
              {
                return Builder(
                  builder: (BuildContext context)
                  {
                    return InkWell(
                      onTap: ()
                      async{
                        if(i.rediret_type.toString()=="1")
                        {
                          //Get.to(ServicePage());
                          controller.selectedIndex.value = 2;
                        }
                        else if(i.rediret_type.toString()=="2")
                        {
                          controller.selectedIndex.value = 3;
                          //Get.to(QuizPage());
                        }
                        else if(i.rediret_type.toString()=="3")
                        {
                          controller.selectedIndex.value = 0;
                          //Get.to(QuizPage());
                        }
                        else if(i.rediret_type.toString()=="4")
                        {
                          controller.selectedIndex.value = 1;
                          //Get.to(QuizPage());
                        }
                        else if(i.rediret_type.toString()=="5")
                        {
                          controller.selectedIndex.value = 2;
                          //Get.to(QuizPage());
                        }
                        else if(i.rediret_type.toString()=="6")
                        {
                          controller.selectedIndex.value = 4;
                          //Get.to(QuizPage());
                        }
                        else if(i.rediret_type.toString()=="7")
                        {
                          controller.gettransactionPointsDetails();

                        }
                        else if(i.rediret_type.toString()=="8")
                        {

                          controller.getReferalPointsDetailNetworkApi();
                        }
                        else if(i.rediret_type.toString()=="0")
                        {
                          await launch(i.url!=null?i.url.toString():"");
                        }

                      },
                      child: Column(
                        children: [
                          Container(
                            height: 100.h,
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.only(left: 10.0.w, right: 10.w),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                                image: DecorationImage(
                                    image: NetworkImage(BASE_URL + i.image.toString()), fit: BoxFit.fill)),

                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5,left: 20,right: 20),
                            child: Text(i.title.toString(),
                                style: bodyText1Style.copyWith(
                                    color: Colors.black,
                                    fontSize: 15),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                textAlign: TextAlign.center

                            ),
                          )
                        ],
                      ),
                    );
                  },
                );
              }).toList(),
            ),) :
            Container(
              height: 130.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
            ),
          ),
         Container(
           height: 40.h,
           width: Get.width,
           decoration: BoxDecoration(
               gradient: LinearGradient(
                   begin: Alignment.topLeft,
                   end: Alignment.bottomRight,
                   colors: [
                     Colors.white,
                     Colors.orange,
                     Colors.orange,
                     Colors.orange,
                     Colors.white
                   ])),

           child: Row(
             children: [
               InkWell(
                 onTap:(){
                   controller.selectedIndex.value=4;
                 },
                 child: Container(
                   width: Get.width/2.4,
                   child: Text("Quick Link",style: TextStyle(),textAlign: TextAlign.end,),
                 ),
               ),
               Text("   |",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 25.sp),),
               InkWell(
                 onTap: (){
                     showModalBottomSheet(
                         context: context,
                         barrierColor: Colors.black.withOpacity(0.1),
                         isScrollControlled: true,
                         backgroundColor: Colors.white70,
                         builder: (context) {
                           return Card(
                             elevation: 10,
                             child: Padding(
                                 padding: EdgeInsets.only(
                                     bottom: MediaQuery.of(context).viewInsets.bottom),
                                 child: ClipRRect(
                                   child: BackdropFilter(
                                       filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                                       child: Container(
                                         height: Get.height /1.5,
                                         padding: EdgeInsets.all(10.w),
                                         // height: h * 0.45,
                                         width: double.infinity,
                                         color: Colors.white70,
                                         child: Column(
                                           children: [
                                             SizedBox(
                                               height: 10,
                                             ),
                                             Container(
                                               width: 40,
                                               height: 6,
                                               decoration: BoxDecoration(
                                                   border: Border.all(
                                                       width: 0.5, color: Colors.black12),
                                                   color: Colors.transparent,
                                                   borderRadius: BorderRadius.circular(10)),
                                             ),
                                             const SizedBox(
                                               height: 10,
                                             ),
                                             Expanded(
                                                 child: RefreshIndicator(
                                                   color: Color(0xf9ff840a),
                                                   onRefresh: (){
                                                     return Future.delayed(Duration.zero, () {
                                                       controller.getServicesCSCNetworkApi();
                                                       controller.getArticleByCategoryNetworkApi("7");
                                                     });
                                                   },
                                                   child: SingleChildScrollView(
                                                     child: Column(
                                                       children: [
                                                         controller.articleModelByCategory.value.data!=null && controller.articleModelByCategory.value.data!.isNotEmpty?
                                                         // Container(
                                                         //   height:130.h,
                                                         //   width: MediaQuery.of(context).size.width,
                                                         //   child: ListView.builder(
                                                         //       scrollDirection: Axis.horizontal,
                                                         //       itemCount: controller.articleModelByCategory.value.data!.length,
                                                         //       shrinkWrap: true,
                                                         //       physics: BouncingScrollPhysics(),
                                                         //       itemBuilder: (context,int index)
                                                         //       {
                                                         //         final data=controller.articleModelByCategory.value.data![index];
                                                         //         return Container(
                                                         //           // height: 130.h,
                                                         //           // width: 130.w,
                                                         //           child:
                                                         //           GestureDetector(
                                                         //             onTap: (){
                                                         //               Get.to(()=>CscDetails(data));
                                                         //             },
                                                         //             child: Card(
                                                         //               color: Colors.white,
                                                         //               shadowColor: Colors.white,
                                                         //               shape: RoundedRectangleBorder(
                                                         //                 borderRadius: BorderRadius.circular(10.r), //<-- SEE HERE
                                                         //               ),
                                                         //               elevation: 2,
                                                         //               child: Padding(
                                                         //                 padding:  EdgeInsets.only(left: 18.w,right: 18.w),
                                                         //                 child: Column(
                                                         //                   crossAxisAlignment: CrossAxisAlignment.center,
                                                         //                   mainAxisAlignment: MainAxisAlignment.center,
                                                         //                   children: [
                                                         //
                                                         //                     ClipRRect(
                                                         //                       borderRadius: BorderRadius.circular(5.r),
                                                         //                       child: CachedNetworkImage(
                                                         //                         fit: BoxFit.fill,
                                                         //                         imageUrl: BASE_URL + data.image.toString(),
                                                         //                         height: 80.h,
                                                         //                         width: 80.w,
                                                         //                         placeholder: (context, url) =>
                                                         //                             Center(child: const CircularProgressIndicator()),
                                                         //                         errorWidget: (context, url, error) =>
                                                         //                         const Icon(Icons.error),
                                                         //                       ),
                                                         //                     ),
                                                         //                     SizedBox(height:5.h),
                                                         //                     Text(data.title.toString(),
                                                         //                       style: bodyText1Style.copyWith(fontSize: 12.sp),overflow: TextOverflow.ellipsis,
                                                         //                       //   textAlign: TextAlign.justify,
                                                         //                       maxLines: 3,)],
                                                         //
                                                         //                 ),
                                                         //               ),
                                                         //             ),
                                                         //           ),
                                                         //         );
                                                         //       }),
                                                         // )
                                                     Container(
                                                     padding: EdgeInsets.only(left:6.w,right: 6.w),
                                                       child: ListView.builder(
                                                         shrinkWrap: true,
                                                         physics: ScrollPhysics(),
                                                         itemCount: controller.articleModelByCategory.value.data!.length,
                                                         // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                         //     crossAxisCount: 1,
                                                         //     crossAxisSpacing: 4.0,
                                                         //     mainAxisSpacing: 4.0
                                                         // ),
                                                         itemBuilder: (context, index){
                                                           final data=controller.articleModelByCategory.value.data![index];
                                                           return Container(
                                                                     // height: 130.h,
                                                                     // width: 130.w,
                                                                     child:
                                                                     GestureDetector(
                                                                       onTap: (){
                                                                         Get.to(()=>CscDetails(data));
                                                                       },
                                                                       child: Card(
                                                                         color: Colors.white,
                                                                         shadowColor: Colors.orangeAccent,
                                                                         shape: RoundedRectangleBorder(
                                                                           borderRadius: BorderRadius.circular(10.r), //<-- SEE HERE
                                                                         ),
                                                                         elevation: 2,
                                                                         child: Padding(
                                                                           padding:  EdgeInsets.only(left: 10.w,right: 10.w,top: 10.h,bottom: 10.h),
                                                                           child: Row(
                                                                             crossAxisAlignment: CrossAxisAlignment.start,
                                                                             mainAxisAlignment: MainAxisAlignment.start,
                                                                             children: [

                                                                               ClipRRect(
                                                                                 borderRadius: BorderRadius.circular(5.r),
                                                                                 child: CachedNetworkImage(
                                                                                   fit: BoxFit.fill,
                                                                                   imageUrl: BASE_URL + data.image.toString(),
                                                                                   height: 55.h,
                                                                                   width: 55.w,
                                                                                   placeholder: (context, url) =>
                                                                                       Center(child: const CircularProgressIndicator()),
                                                                                   errorWidget: (context, url, error) =>
                                                                                   const Icon(Icons.error),
                                                                                 ),
                                                                               ),
                                                                               SizedBox(height:5.h),
                                                                               Container(
                                                                                 padding: EdgeInsets.only(left: 5.w),
                                                                                 width: Get.width/1.6,
                                                                                 child: Column(
                                                                                   children: [
                                                                                     Text(data.title.toString(),textAlign: TextAlign.start,
                                                                                       style:TextStyle(fontSize: 13.sp),overflow: TextOverflow.ellipsis,
                                                                                       //   textAlign: TextAlign.justify,
                                                                                       maxLines: 4,),
                                                                                   ],
                                                                                 ),
                                                                               )],

                                                                           ),
                                                                         ),
                                                                       ),
                                                                     ),
                                                                   );
                                                         },
                                                       ))
                                                     :Center(),
                                                       ],
                                                     ),
                                                   ),
                                                 )),

                                           ],
                                         ),
                                       )),
                                 )),
                           );
                         });
                 },
                 child: Container(
                   width: Get.width/2.2,
                   child: Text("    Latest News"),
                 ),
               ),
             ],
           ),
         ),
          SizedBox(height: 10.h,),
        Obx(()=>controller.siteLink.value.data!=null
            ?
          Container(
            child: GridView.builder(
                   shrinkWrap: true,
                physics: ScrollPhysics(),
                gridDelegate:  SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 100.r,
                    childAspectRatio: 4 /3.r,
                    crossAxisSpacing: 0.r,
                    mainAxisSpacing: 5.r),
                itemCount: controller.siteLink.value.data!.length,
                itemBuilder: (BuildContext ctx, index) {
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
                    onTap:_luncherMail ,
                    child: Card(
                      shadowColor: Color(0xff0067d5),
                      elevation: 1,
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 40.h,
                              width: 40.w,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage("assets/images/whatsapp.png"),fit: BoxFit.fill
                                )
                              ),
                            ),
                            SizedBox(height: 4.h,),
                            Text(site.title.toString(),maxLines: 2,textAlign: TextAlign.center,style: TextStyle(
                              fontSize: 11.sp,fontWeight: FontWeight.bold
                            ),),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ):SizedBox()),
          SizedBox(height: 25,),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text("CSC SERVICES", style: titleStyle.copyWith(fontWeight: FontWeight.w800,fontSize: 19,height:.3)),
          ),
          SizedBox(height: 10,),
          FadeTransition(opacity: _animation!, child:  controller.serviceCSCModel.value.data != null && controller.serviceCSCModel.value.data!.isNotEmpty
                ? GridView.count(
                controller: _scrollController,
                shrinkWrap: true,
                primary: false,
                padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
                crossAxisSpacing: 1.5,
                mainAxisSpacing: 18,
                crossAxisCount: 3,

                children: List.generate(
                  controller.serviceCSCModel.value.data!.length,
                      (index) =>
                        GestureDetector(
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
                                              controller.serviceCSCModel.value.data![index].is_gosite=='0'?
                                              controller.getServicesCSCSubCategoryNetworkApi(controller.serviceCSCModel.value.data![index].id.toString(),
                                                  controller.serviceCSCModel.value.data![index].title.toString())
                                                  :Get.to(ServicesDescription( controller.serviceCSCModel.value.data![index].description.toString(),
                                                  controller.serviceCSCModel.value.data![index].url.toString(),
                                                  controller.serviceCSCModel.value.data![index].title.toString(),
                                                  controller.serviceCSCModel.value.data![index].image.toString()));
                                            }

                                        );
                                  },
                                  onAdFailedToLoad: (err) {
                                    debugPrint(err.message);
                                  },
                                ));
                          }else
                          {
                            controller.serviceCSCModel.value.data![index].is_gosite=='0'?
                            controller.getServicesCSCSubCategoryNetworkApi(controller.serviceCSCModel.value.data![index].id.toString(),
                                controller.serviceCSCModel.value.data![index].title.toString())
                                :Get.to(ServicesDescription( controller.serviceCSCModel.value.data![index].description.toString(),
                                controller.serviceCSCModel.value.data![index].url.toString(),
                                controller.serviceCSCModel.value.data![index].title.toString(),
                                controller.serviceCSCModel.value.data![index].image.toString()));
                          }




                        // Get.to(SubCategoryOfServices( controller.serviceModel.value.data![index].id.toString()))
                        //  UtilsMethod.launchUrls(controller.serviceModel.value.data![index].url.toString());
                    },
                    child: Column(
                        children: [
                          Container(
                            height: 55.h,
                            width: 55.w,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors
                                        .white
                                        .withOpacity(
                                        1),
                                    offset: Offset(
                                        -3.0, -3.0),
                                    blurRadius: 10.0,
                                  ),
                                  BoxShadow(
                                    color: Colors
                                        .black
                                        .withOpacity(
                                        0.1),
                                    offset: Offset(
                                        3.0, 3.0),
                                    blurRadius: 10.0,
                                  ),
                                ],
                                color: Colors.white,
                                image: DecorationImage(
                                    image: NetworkImage(BASE_URL +
                                        controller.serviceCSCModel.value.data![index].image.toString()),fit: BoxFit.fill)),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            controller.serviceCSCModel.value.data![index].title.toString(),
                            style: smallTextStyle.copyWith(fontSize: 13.sp),
                            maxLines: 2,
                            overflow:
                            TextOverflow.ellipsis,
                            textAlign:
                            TextAlign.center,
                          ),
                        ],
                    ),
                  ),
                      ),
                )
                : Center(
              child: CupertinoActivityIndicator(),
            ),
          )

        ],
      ),
    ));
  }




}
