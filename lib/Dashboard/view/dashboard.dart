
import 'dart:async';
import 'dart:io';
import 'dart:ui';


import 'package:any_link_preview/any_link_preview.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vlesociety/Dashboard/controller/DashboardController.dart';
import 'package:vlesociety/Dashboard/view/Artical.dart';
import 'package:vlesociety/Dashboard/view/Earning/SpinReword.dart';
import 'package:vlesociety/Dashboard/view/Home.dart';
import 'package:vlesociety/Dashboard/view/Services.dart';
import 'package:vlesociety/Dashboard/view/notification.dart';
import 'package:vlesociety/Dashboard/view/profile.dart';
import 'package:vlesociety/Dashboard/view/profile/ChaAdmin.dart';
import 'package:vlesociety/Dashboard/view/quize.dart';
import 'package:vlesociety/UtilsMethod/UtilsMethod.dart';
import 'package:vlesociety/Widget/CoustomAlertDailog.dart';
import '../../AppConstant/APIConstant.dart';
import '../../AppConstant/AppConstant.dart';
import '../../AppConstant/textStyle.dart';
import '../../CSC/CSCHome.dart';

import '../../Notification/FirebaseNotification.dart';
import '../../Widget/CircularButton.dart';
import '../../Widget/CustomIcon.dart';

import 'ArticalSearch.dart';
import 'Earning/controller/DetailsController.dart';
import 'SearchFeedArtical.dart';
import 'SearchScreen.dart';

import 'package:badges/badges.dart' as badges;
import 'package:http/http.dart' as http;

class HomeDashboard extends StatefulWidget {
  const HomeDashboard({super.key});

  @override
  State<HomeDashboard> createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard>
{
  DashboardController controller = Get.put(DashboardController());
  final DeatilsController _controller=Get.put(DeatilsController());
  DateTime? currentBackPressTime;
  NotificationServices notificationServices = NotificationServices();
  RxInt pointData=0.obs;
  int counter = 0;
  int counter1 = 0;
  int repetitions = 1;
  int repetitions1 = 1;
  TextEditingController etmessage = TextEditingController();
  String ratingvalue="";

  @override

  void openAlertDialog() {
    showDialog(
      context: context,
      builder: (context) =>
         Obx(()=>controller.snotifiaction.value.data!=null
             ?
            Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r)
            ),
            child:   Container(
              height: 410.r,
              padding: EdgeInsets.all(8.w),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(onPressed: (){
                        Get.back();
                      }, icon: Icon(Icons.clear))
                    ],
                  ),
                  Obx(
                        () => controller.snotifiaction.value.data!.isNotEmpty
                        ? Padding(
                      padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                      child: CarouselSlider(
                        options: CarouselOptions(
                          height: 340.r,
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
                          scrollDirection: Axis.horizontal,
                        ),
                        items: controller.snotifiaction.value.data!.map((i)
                        {
                          return Builder(
                            builder: (BuildContext context)
                            {
                              return InkWell(
                                  onTap: ()
                                  {

                                  },
                                  child:
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 110.r,
                                        width: MediaQuery.of(context).size.width,
                                        // margin: EdgeInsets.only(left: 10.0, right: 10),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8),
                                          color: Colors.white,
                                          image:
                                          DecorationImage
                                            (
                                            image: NetworkImage(BASE_URL + i.image.toString()),
                                            fit: BoxFit.fill,
                                          ),),),
                                      SizedBox(height: 5.h,),
                                      Text(i.title.toString(),
                                        style:TextStyle(
                                            fontSize: 16.sp,
                                            letterSpacing:1,
                                          fontWeight: FontWeight.bold
                                        ),
                                        maxLines: 2,
                                      ),
                                      SizedBox(height: 5.h,),
                                      Text(i.description.toString(),
                                        style:TextStyle(
                                            fontSize: 12.sp,
                                            letterSpacing:1
                                        ),
                                        maxLines: 8,
                                      ),
                                    SizedBox(height: 10.h,),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: ()async{

                                              if(i.rediretType.toString()=="1")
                                              {
                                                controller.selectedIndex.value = 4;
                                              }
                                              else if(i.rediretType.toString()=="2")
                                              {
                                                controller.selectedIndex.value = 3;
                                              }
                                              else if(i.rediretType.toString()=="3")
                                              {
                                                controller.selectedIndex.value = 0;
                                                //Get.to(QuizPage());
                                              }
                                              else if(i.rediretType.toString()=="4")
                                              {
                                                controller.selectedIndex.value = 1;
                                                //Get.to(QuizPage());
                                              }
                                              else if(i.rediretType.toString()=="5")
                                              {
                                                controller.selectedIndex.value = 2;
                                              }
                                              else if(i.rediretType.toString()=="6")
                                              {
                                                controller.selectedIndex.value = 4;
                                              }
                                              else if(i.rediretType.toString()=="7")
                                              {
                                                controller.gettransactionPointsDetails();

                                              }
                                              else if(i.rediretType.toString()=="8")
                                              {

                                                controller.getReferalPointsDetailNetworkApi();
                                              }
                                              else if(i.rediretType.toString()=="0")
                                              {
                                                await launch(i.url!=null?i.url.toString():"");
                                              }

                                          },
                                          child: Card(
                                            color: Colors.orange,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(20.r),
                                            ),
                                            child: Container(
                                              height: 40.h,
                                              width: 110.w,
                                              child: Center(
                                                child: Text("Go"),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                    ],
                                  ));
                            },
                          );
                        }).toList(),
                      ),
                    )
                        : Container(
                      height: 130.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ):Container()
        ),
         );
  }


  void initState()
  {

    if (controller.isDob == true) {
      Future.delayed(
          Duration.zero,
          () =>
              UtilsMethod.dateOfBirth(context, controller.userName.toString()));
    }
    // if(controller.snotifiaction.value==true){
    //   Future.delayed(Duration.zero,()=>openAlertDialog());
    // }
    super.initState();
    controller.getgetUserDetailsNetworkApi();
    controller.getSpeccallyNetworkApi();
    _controller.getFollowingApi();
    notificationServices.requestNotificationPermission();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    notificationServices.isTokenRefresh();
    notificationServices.getDeviceToken().then((value) {
      if (kDebugMode) {
        print(value);
      }
    });
    Timer.periodic(Duration(seconds: 10), (timer) {
      setState(() {
        if (counter < repetitions) {
          if(controller.snotifiaction.value.data!=null){
            openAlertDialog();
          }
          counter++;
        } else {
          timer.cancel();
        }
      });
    });
    Timer.periodic(Duration(seconds: 10), (timer) {
      setState(() {
        if (counter1 < repetitions1) {
          if(controller.userDetails.value.data!.dob!.isEmpty){
            openFeedBack();
          }
          counter1++;
        } else {
          timer.cancel();
        }
      });
    });
  }

  void openFeedBack() {
    showDialog(
      context: context,
      builder: (context) =>
          Dialog(
            child:   Container(
              height: 370.h,
              width: Get.width,
              padding: EdgeInsets.all(8.w),
              child: Column(
                children: [
                  SizedBox(height: 10.h,),
                  Row(
                    children: [
                      Container(
                        height: 30.h,
                        width: 30.w,
                        child: Image.asset("assets/images/icons.png"),
                      ),
                      Text("Enjoying Our App ??",style: bodyText2Style.copyWith(fontSize: 22.sp,fontWeight: FontWeight.bold),),
                      Container(
                        height: 30.h,
                        width: 30.w,
                        child: Image.asset("assets/images/icons.png"),
                      ),
                    ],
                  ),
                  Text("Tap a Star to rate us on Play Store.",style:bodyText2Style.copyWith(fontSize: 12.sp,fontWeight: FontWeight.bold,color: Colors.grey),),
                  SizedBox(height: 10.h,),
                  RatingBar.builder(
                    initialRating: 0,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 5.w),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating)
                    {
                      ratingvalue=rating.toString();
                      print("safsffg"+rating.toString());
                    },
                  ),

                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.only(top: 30.h,),
                          child: Container(
                              padding: EdgeInsets.all(5),
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12))),
                                  padding: EdgeInsets.all(10.w),
                                  child: Container(
                                    padding: EdgeInsets.zero,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.white,
                                              blurRadius: 10,
                                              spreadRadius: 10)
                                        ]),
                                    width: double.infinity,
                                    child: Column(
                                      children: [
                                        TextFormField(
                                          minLines: 3,
                                          maxLines: null,
                                          controller: etmessage,
                                          keyboardType:
                                          TextInputType.multiline,
                                          decoration: InputDecoration(
                                            alignLabelWithHint: true,
                                            border: InputBorder.none,
                                            hintText: "Write Here.....",
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.end,
                                          children: [
                                            CircularButton(
                                              onPress: ()
                                              async {
                                                if(etmessage.text.isEmpty)
                                                {
                                                  Fluttertoast.showToast(msg: "Please Enter your comments",

                                                      toastLength: Toast.LENGTH_SHORT,
                                                      gravity: ToastGravity.CENTER,
                                                      timeInSecForIosWeb: 1,
                                                      backgroundColor: Colors.red,
                                                      textColor: Colors.yellow  );
                                                }
                                                else if (ratingvalue.isEmpty)
                                                {
                                                  Fluttertoast.showToast(msg: "please select rating",

                                                      toastLength: Toast.LENGTH_SHORT,
                                                      gravity: ToastGravity.BOTTOM,
                                                      timeInSecForIosWeb: 1,
                                                      backgroundColor: Colors.red,
                                                      textColor: Colors.yellow  );
                                                }
                                                else {
                                                  if (controller.userType ==
                                                      "Guest") {
                                                    UtilsMethod.PopupBox(
                                                        context, "rating");
                                                  }
                                                  else
                                                  {
                                                    if(double.parse(ratingvalue) < 4.0)
                                                    {

                                                    }
                                                    else
                                                    {
                                                      await launch("https://play.google.com/store/apps/details?id=com.vlesociety&pcampaignid=web_share");
                                                      // await launch("https://play.google.com/store/search?q=vle+society+mobile+app&c=apps");
                                                    }
                                                    controller.postAppFeedbackNetworkApi(etmessage.text, ratingvalue);
                                                    Get.back();
                                                  }
                                                }

                                              },
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                              )
                          )
                      ),
                    ],
                  ),
                  Spacer(),
                  Padding(
                    padding:  EdgeInsets.only(left: 25.w,right:25.w),
                    child: Row(
                      children: [
                        InkWell(onTap:(){
                          Get.back();
                        },child: Text("Never",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),)),
                        Spacer(),
                        InkWell(onTap:(){
                          Get.back();
                        },child: Text("Maybe Later",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red),)),
                        SizedBox()
                      ],
                    ),
                  ),
                  SizedBox(height: 10.h,)
                ],
              ),
            ),
          )

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
  Widget build(BuildContext context) {


    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent)
    );
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar:
        PreferredSize(
          child: Stack(
            children: [
              Positioned(
                  top: -80.h,
                  right: 60.w,
                  child: Container(
                    height: 150.h,
                    width: 150.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xffcdf55a),
                    ),
                  )),

          Obx(() =>
              ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: AppBar(
                    backgroundColor: Colors.white.withOpacity(0.5),
                    leading: InkWell(
                      onTap: () {
                        Get.to(Profile());
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.r),
                        child: CircleAvatar(
                          radius: 10.r,
                          backgroundColor: Colors.amber.withOpacity(0.1),
                          backgroundImage: NetworkImage(BASE_URL +
                              GetStorage()
                                  .read(AppConstant.profileImg)
                                  .toString()),
                        ),
                      ),
                    ),
                    leadingWidth: 60.r,
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                      [
                        Text(
                          GetStorage().read(AppConstant.userName).toString(),
                          style: TextStyle(color: Colors.black, fontSize: 14.r),
                        ),
                        Obx(()=>
                           Text(
                      //    "${GetStorage().read(AppConstant.points)==null?"0":GetStorage().read(AppConstant.points).toString()} Points",
                            "${controller.pointData.value==null?"0":controller.pointData.value} Points",
                            style: smallTextStyle.copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: 11,
                                color: Colors.green),
                          ),
                        ),
                      ],
                    ),
                    elevation: 0.0,
                    actions:
                    [

                      controller.selectedIndex.value <= 1 ?
                      RawMaterialButton(
                              constraints: BoxConstraints(
                                  maxHeight: 30.h, minWidth: 30.w),
                              onPressed: ()
                              {
                                if (controller.selectedIndex.value == 0)
                                {
                                  print("sdfdfgdgfgh");
                                  Get.to(SearchScreen());
                                } else if (controller.selectedIndex.value == 1)
                                {
                                  if (controller.selectedIndexOfArtical.value == 1)
                                  {
                                    Get.to(ArticalSearch());
                                  }
                                  else
                                  {
                                    Get.to(FeedArticalSearch());
                                  }
                                }
                              },
                              shape: CircleBorder(),
                              child: Image.asset(
                                "assets/images/search.png",
                                height: 23.r,
                                width: 23.r,
                                fit: BoxFit.fill,
                              ),
                            ) : RawMaterialButton(
                        constraints: BoxConstraints(
                            maxHeight: 30.r, minWidth: 30.r),
                        onPressed: ()
                        {
                          _launchURL();
                        },
                        shape: CircleBorder(),
                        child: Image.asset
                          (
                          "assets/images/shoppingcart.png",
                          height: 25.r,
                          width: 25.r,
                          fit: BoxFit.fill,
                        ),
                      ),
                      RawMaterialButton(
                        constraints:
                            BoxConstraints(maxHeight: 40.r, minWidth: 40.r),
                        onPressed: () {
                          if(int.parse(controller.pointData.value)>=100){
                            Get.to(() => chats());
                          }else{
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Points must be 100 or more to proceed.')),
                            );
                          }
                          //controllerNotification.getNotificationListNetworkApi();
                          // Get.to(() => chats());
                        },
                        shape: CircleBorder(),
                        child: Image.asset(
                          "assets/images/chat.png",
                          height: 35.r,
                          width: 35.r,
                          fit: BoxFit.fill,
                        ),
                      ),

                      Obx(() => InkWell(
                        onTap: () async {
                          controller.countvalue.value = 0;
                          controller.countervalue.value = 0;
                          final SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          await prefs.setInt("count", controller.countervalue.value,);
                          Get.to(() => notification());
                        },
                        child: Padding(
                              padding:  EdgeInsets.only(top: 10.h, right: 15.w),
                              child: badges.Badge(
                                position:
                                    badges.BadgePosition.topEnd(top: -8.h, end: -5.w),
                                badgeContent:
                                    Text(controller.countvalue.value.toString(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 10.sp),),
                                child: Icon(Icons.notifications,
                                    size: 20.r, color: Colors.orange[300]),
                                showBadge: controller.countvalue.value != 0
                                    ? true
                                    : false,
                                ignorePointer: false,
                                badgeStyle: badges.BadgeStyle(
                                  shape: badges.BadgeShape.circle,
                                  badgeColor: Colors.red,
                                  padding: EdgeInsets.all(5),
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 1),
                                ),
                                badgeAnimation: badges.BadgeAnimation.rotation(
                                  animationDuration: Duration(seconds: 1),
                                  colorChangeAnimationDuration:
                                      Duration(seconds: 1),
                                  loopAnimation: false,
                                  curve: Curves.fastOutSlowIn,
                                  colorChangeAnimationCurve: Curves.easeInCubic,
                                ),
                              ),
                            ),
                      )),

                      /*   RawMaterialButton(
                        constraints:
                                   BoxConstraints(maxHeight: 40.h, minWidth: 40.w),
                        onPressed: ()
                        {
                          //controllerNotification.getNotificationListNetworkApi();
                          Get.to(()=>notification());
                        },
                        shape: CircleBorder(),
                        child: Image.asset(
                          "assets/images/Notification.png",
                          height: 45,
                          width: 45,
                          fit: BoxFit.fill,
                        ),
                      ),*/

                      RawMaterialButton(
                        constraints:
                            BoxConstraints(maxHeight: 40.h, minWidth: 40.w),
                        onPressed: () {
                          Get.to(() => Profile());
                          //  controller.logout();
                        },
                        shape: CircleBorder(
                            side: BorderSide(width: 0.5, color: Colors.black)),
                        child: Image.asset(
                          "assets/images/menu.png",
                          height: 15,
                          width: 20,
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      )
                    ],
                  ),
                ),
              )),
            ],
          ),
          preferredSize: Size(
            double.infinity,
            60.0,
          ),
        ),
        body: RefreshIndicator(
            color: Color(0xff049486),
            onRefresh: (){
              return Future.delayed(Duration.zero, () {
                controller.getBannerNetworkApi();
                controller.getCommunityNetworkApi();
                controller.getSiteLinkNetworkApi();
                controller.getAskApi();
                _controller.getFollowingApi();
                controller.getgetUserDetailsNetworkApi();
                controller.getServicesCSCNetworkApi();
                controller.getArticleByCategoryNetworkApi( "7");
                print("dlkfhfu"+GetStorage().read(AppConstant.id));
              });
            },
          child: SingleChildScrollView(
              controller: controller.scrollController,
              // physics: const BouncingScrollPhysics(),
              child: SafeArea(
                child: Obx(() =>
                    _widgetOptions.elementAt(controller.selectedIndex.value)),
              )),
        ),


        // RefreshIndicator(
        //   onRefresh: ()
        //   {
        //     if (controller.selectedIndex.value == 0)
        //     {
        //       return controller.getCommunityNetworkApi();
        //     } else
        //     {
        //       return Future(() => true);
        //     }
        //   },
        //   child: SingleChildScrollView(
        //       controller: controller.scrollController,
        //       // physics: const BouncingScrollPhysics(),
        //       child: SafeArea(
        //         child: Obx(() =>
        //             _widgetOptions.elementAt(controller.selectedIndex.value)),
        //       )),
        // ),


        bottomNavigationBar:

        PreferredSize(
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Obx(
                () => BottomNavigationBar(
                  elevation: 0,
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Colors.white54,
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Image.asset(
                        "assets/images/community.png",
                        height: 35.h,
                        width: 35.w,
                        fit: BoxFit.fill,
                      ),
                      label: 'Community',
                    ),
                    BottomNavigationBarItem(
                      icon: Image.asset(
                        "assets/images/article.png",
                        height: 36.h,
                        width: 35.w,
                        fit: BoxFit.fill,
                      ),
                      label: 'Articles',
                    ),
                    BottomNavigationBarItem(
                      icon: CustomIcon(),
                      label: "",
                    ),
                    BottomNavigationBarItem(
                      icon: Image.asset(
                        "assets/images/quiz.png",
                        height: 36.h,
                        width: 35.w,
                        fit: BoxFit.fill,
                      ),
                      label: 'Quiz',
                    ),
                    BottomNavigationBarItem(
                      icon: Image.asset(
                        "assets/images/services.png",
                        height: 36.h,
                        width: 35.w,
                        fit: BoxFit.fill,
                      ),
                      label: 'Services',
                    ),
                  ],
                  currentIndex: controller.selectedIndex.value,
                  selectedLabelStyle: bodyText1Style.copyWith(fontSize: 12),
                  unselectedLabelStyle: bodyText1Style.copyWith(fontSize: 12),
                  selectedItemColor: Colors.red[800],
                  unselectedItemColor: Colors.black,
                  showUnselectedLabels: true,
                  onTap: (int index) {
                    /* setState(()
                    {

                    });*/
                    switch (index)
                    {
                      case 0:
                        controller.selectedIndex.value = 0;
                        break;
                      case 1:
                        controller.selectedIndex.value = 1;
                        break;
                      case 2:
                        controller.selectedIndex.value = 2;
                        break;
                      case 3:
                        controller.selectedIndex.value = 3;
                        break;
                      case 4:
                        controller.selectedIndex.value = 4;
                        break;
                    }
                  },
                ),
              ),
            ),
          ),
          preferredSize: Size(
            double.infinity,
            55.0,
          ),
        ),
        floatingActionButton: controller.selectedIndex.value <= 2
            ? Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Stack(
                  children:[
                   /* Expanded(
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        height:70.h,
                        width: 60.w,
                        child: FloatingActionButton(
                          elevation: 0,
                          backgroundColor: Colors.white.withOpacity(0),
                          onPressed: () {
                           Get.to(()=>MyFortuneWheel());
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage("assets/images/spin2.gif",),fit: BoxFit.cover,
                                )
                              ),
                          )
                        ),
                      ),
                    ),
                  ),*/
                    // Positioned(
                    //     right: 5.w,
                    //     bottom: 0.h,
                    //     child:
                    // Text("72:25:05",style: bodyText2Style.copyWith(color: Colors.green,fontSize: 10.sp,fontWeight: FontWeight.bold),)
                    // )
                  ]
                ),
                SizedBox(height: 8.h,),
                FloatingActionButton(
                    onPressed: () {
                      if (controller.userType == "Guest") {
                        UtilsMethod.PopupBox(context, "Post");
                      } else {
                        controller.getCommmunityCategoryNetworkApi();
                        controller.urlvalue.value="";
                        _showBottomSheet();
                      }
                    },
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    tooltip: 'Go Live Modal',
                    child: Container(
                      alignment: Alignment.center,
                      height: 55,
                      width: 55,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xff1200FF).withOpacity(0.1),
                        border: Border.all(
                            width: 1, color: Color(0xff1200FF).withOpacity(0.1)),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(255, 255, 255, 0.7),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.edit,
                        size: 28,
                        color: Color(0xff1200FF),
                      ),
                    ),
                  ),
              ],
            )
            : Container(),
      ),
    );
  }
  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert Dialog Title'),
          content: Text('This is the content of the alert dialog.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
  void showAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Text("hi"),
            ));
  }

  Future<void> _loadData() async {
    controller.getCommunityNetworkApi();
  }

  final List<Widget> _widgetOptions = [
    HomePage(),
    ArticalPage(),
    CSCHome(),
    QuizPage(),
    ServicePage(),
  ];

  void _showBottomSheet() {
    TextEditingController etmessage = TextEditingController();
    String catId = "";
    controller.imagesList!.clear();
    controller.fileLength.value = 0;
    controller.isCategorySelected.value = false;
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;
    showModalBottomSheet(
      context: context,
      barrierColor: Colors.black.withOpacity(0.1),
      isScrollControlled: true,
      isDismissible: false,
      backgroundColor: Colors.white70,
      builder: (context) 
      {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(
                  padding: EdgeInsets.all(10),
                  height: h * 0.45,
                  width: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 40,
                        height: 7,
                        decoration: BoxDecoration(
                            border: Border.all(width: 0.5, color: Colors.blue),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Obx(
                            () => controller.isCategorySelected.value == false
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: h * 0.04,
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 15),
                                        child: Text(
                                          "Category",
                                          style: titleStyle,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Center(
                                        child: Text(
                                          "Select a category",
                                          style: smallTextStyle,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Obx(
                                        () => controller.communityCategoryModel
                                                    .value.data !=
                                                null
                                            ? GridView.count(
                                                shrinkWrap: true,
                                                primary: false,
                                                padding: const EdgeInsets.all(8),
                                                crossAxisSpacing: 10,
                                                mainAxisSpacing: 10,
                                                crossAxisCount: 4,
                                                childAspectRatio: (1 / 1.35),
                                                children: List.generate(
                                                  controller.communityCategoryModel
                                                      .value.data!.length,
                                                  (index) => GestureDetector(
                                                    onTap: () {
                                                      catId = controller
                                                          .communityCategoryModel
                                                          .value
                                                          .data![index]
                                                          .id
                                                          .toString();
                                                      controller.isCategorySelected
                                                          .value = true;
                                                    },
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          height: 55.h,
                                                          width: 55.w,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          100),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: Colors
                                                                      .white
                                                                      .withOpacity(
                                                                          0.8),
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
                                                                      controller
                                                                          .communityCategoryModel
                                                                          .value
                                                                          .data![
                                                                              index]
                                                                          .image
                                                                          .toString()))),
                                                        ),
                                                        SizedBox(
                                                          height: 8,
                                                        ),
                                                        Text(
                                                          controller
                                                              .communityCategoryModel
                                                              .value
                                                              .data![index]
                                                              .title
                                                              .toString(),
                                                          style: smallTextStyle
                                                              .copyWith(
                                                                  fontSize: 11),
                                                          maxLines: 2,
                                                          overflow:
                                                              TextOverflow.ellipsis,
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ))
                                            : const Center(
                                                child: CupertinoActivityIndicator(),
                                              ),
                                      ),
                                    ],
                                  )
                                : Container(
                                    padding: EdgeInsets.only(
                                        top: 30, left: 10, right: 10),
                                    child: Container(
                                        padding: EdgeInsets.all(10),
                                        child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.grey,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(12))),
                                            padding: EdgeInsets.all(10),
                                            child: Container(
                                              padding: EdgeInsets.zero,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(8)),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.white,
                                                        blurRadius: 10,
                                                        spreadRadius: 10)
                                                  ]),
                                              width: double.infinity,
                                              child:
                                            Obx(() =>   SingleChildScrollView(
                                              child: Column(
                                                children:
                                                [
                                                  TextFormField(
                                                    onChanged: (value)
                                                    {

                                                      print("kjdfh"+value);
                                                      value.toString().contains("https") || value.toString().contains("Https")?
                                                         controller.urlvalue.value=value
                                                          :controller.urlvalue.value="" ;
                                                    },
                                                    minLines: null,
                                                    maxLines:8,
                                                    controller: etmessage,
                                                    keyboardType:
                                                    TextInputType.multiline,
                                                    decoration: InputDecoration(
                                                      alignLabelWithHint: true,
                                                      border: InputBorder.none,
                                                      hintText: "Write Here.....",
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                    children: [
                                                      Expanded(
                                                          child:
                                                              Column(

                                                                mainAxisAlignment:
                                                                MainAxisAlignment.start,
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children:
                                                                [
                                                                  Obx(() => controller.urlvalue.value.toString().contains("https") || controller.urlvalue.value.toString().contains("Https")?
                                                                  Container(
                                                                    height: 100.h,
                                                                    width: Get.width.w,
                                                                    child:AnyLinkPreview(
                                                                      link: controller.urlvalue.value.toString(),

                                                                      bodyStyle: TextStyle(color: Colors.grey, fontSize: 12.sp),

                                                                      errorWidget: Center(
                                                                        child: Container(
                                                                          color: Colors.grey[300],
                                                                          child: Text('This Url Wrong, Please Enter valid url'),
                                                                        ),
                                                                      ),



                                                                      borderRadius: 12,
                                                                      removeElevation: false,


                                                                      onTap: (){}, // This disables tap event
                                                                    ) ,
                                                                  ):Container()),
                                                                  SizedBox(height: 10.h,),


                                                                  Text(controller.fileLength != 0 ? "${controller.fileLength}  Upload file" : "",style: subtitleStyle),
                                                                  controller.imagesList!=null?
                                                                  Container(
                                                                    height:50.h,
                                                                    width: MediaQuery.of(context).size.width,
                                                                    child: ListView.builder(
                                                                        scrollDirection: Axis.horizontal,
                                                                        itemCount: controller.imagesList!.length,
                                                                        shrinkWrap: true,
                                                                        physics: BouncingScrollPhysics(),
                                                                        itemBuilder: (context,int index)
                                                                        {
                                                                          final data=controller.imagesList![index].path;
                                                                          print("jkgh"+data);
                                                                          return Padding(
                                                                            padding: const EdgeInsets.all(5.0),
                                                                            child: Container(
                                                                                height: 50.h,
                                                                                width: 50.w,
                                                                                child:Container(
                                                                                  decoration: BoxDecoration(
                                                                                    borderRadius: BorderRadius.circular(60),
                                                                                    border: Border.all(),
                                                                                    image: DecorationImage(
                                                                                        image: FileImage(File(data)),
                                                                                        fit: BoxFit.fill),
                                                                                  ),
                                                                                )


                                                                            ),
                                                                          );
                                                                        }),
                                                                  ):Center()
                                                                ],
                                                              )

                                                      ),
                                                      IconButton(
                                                          onPressed: ()
                                                          {
                                                            controller
                                                                .selectMultipleImage();
                                                          },
                                                          icon: Icon(
                                                              Icons.attach_file)),
                                                      CircularButton(
                                                        onPress: () {
                                                          if (etmessage
                                                              .text.isEmpty) {
                                                            Fluttertoast.showToast(
                                                                msg: "Thank You");
                                                          }
                                                          controller.urlvalue.value="";
                                                          controller
                                                              .postCommunityNetworkApi(
                                                              catId,
                                                              etmessage.text);
                                                          Get.back();
                                                        },
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            )),
                                            )))),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ),
        );
      },
    );
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2))
    {
      controller.urlvalue.value="";
      currentBackPressTime = now;
      final snackBar = const SnackBar(
        content: const Text('Press again to exit'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return Future.value(false);
    }
    return Future.value(true);
  }
}

// Settings Tab
