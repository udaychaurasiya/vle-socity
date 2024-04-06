import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vlesociety/Dashboard/controller/DashboardController.dart';
import 'package:vlesociety/Dashboard/view/profile/PointRedeem.dart';
import 'package:vlesociety/Dashboard/view/quize.dart';
import '../../AppConstant/APIConstant.dart';
import '../../AppConstant/textStyle.dart';
import '../../Widget/CircularButton.dart';
import 'Community.dart';
import 'MyAsk.dart';
import 'Services.dart';


class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  List<String> name= ['Abhishek','Shivangi','Muskan','Soni','Santosh','Uday Chaurasiya','Priya pandey','Niharika Singh',
    'Shiva','Satya','Akshay Arya','Ritesh','Ankit Kumar',
  ];
  List<String> tempArray = [];
  DashboardController controller = Get.find();

  late TabController tabController;
  AnimationController? _controller;
  Animation<double>? _animation;


  @override
  void initState()
  {
    super.initState();

    controller.getBannerNetworkApi();
    controller.getgetUserDetailsNetworkApi();

    controller.getCommunityNetworkApi();
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
  void dispose() {

    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    controller.getCommunityNetworkApi();
    controller.selectedComunityIndex.value = 0;
    return
      Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 8,
          ),

          Container(
            child: Obx(
              () => controller.bannerModel.value.data != null
                  ? Padding(
                    padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                    child: CarouselSlider(
                        options: CarouselOptions(
                          height: 170.r,
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
                        items: controller.bannerModel.value.data!.map((i)
                        {
                          return Builder(
                            builder: (BuildContext context)
                            {
                              return InkWell(
                                onTap: ()
                                async
                                {

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
                                child:
                                Column(
                                  children: [
                                    Container(
                                      height: 110.0.h,
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
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5.0,left: 30,right: 30),
                                      child: Text(i.title.toString(),
                                        style: bodyText1Style.copyWith(
                                              color: Colors.black54,
                                              fontSize: 12,
                                             letterSpacing:1
                                          ),
                                          maxLines: 2,


                                      ),
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
          ),
          Container(
            height: 140.r,
            width: Get.width,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: ScrollPhysics(),
              itemCount: name.length,
              itemBuilder: (context, index) {
                if (index == name.length-1) {
                  // Last item
                  return Padding(
                    padding: EdgeInsets.only(left: 3.w),
                    child:Center(
                      child: Row(
                        children: [
                          InkWell(
                            onTap:(){

                            },
                            child: Container(
                                height:35.h,
                                width: 35.w,
                                child: Image.asset("assets/images/next.png")),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  // Other items
                  return Padding(
                    padding: EdgeInsets.only(left: 3.w),
                    child: Container(
                      width: Get.width / 3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.r),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 45.h,
                            width: 45.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage("assets/images/king.png"),fit: BoxFit.fill
                              )
                            ),
                          ),
                          Text(name[index].toString(),style: bodyText2Style.copyWith(fontSize: 12.sp,fontWeight: FontWeight.bold),textAlign: TextAlign.center,maxLines: 1,overflow: TextOverflow.ellipsis,),
                          Text("Delhi",style:smallTextStyle.copyWith(color: Colors.grey,fontSize: 12.sp),),
                          SizedBox(height: 10.h,),
                          InkWell(
                            onTap: (){
                              setState(() {
                                if(tempArray.contains(name[index].toString())){
                                  (tempArray.remove(name[index].toString()));
                                }else{
                                  (tempArray.add(name[index].toString()));
                                }
                              });
                              print('myvalue');
                              print(tempArray.toString());
                            },
                            child: Container(
                              height: 30.h,
                              width: 80.w,
                              decoration: BoxDecoration(
                                  color:tempArray.contains(name[index].toString()) ? Colors.blue :Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(18.r)
                              ),
                              child: Center(
                                child: Text(tempArray.contains(name[index].toString()) ?'follow' :
                                'unfollow',style: bodyText2Style.copyWith(fontSize: 12.sp
                                    ,fontWeight: FontWeight.bold,color: tempArray.contains(name[index].toString()) ? Colors.white :Colors.black,),),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        SizedBox(height: 5.h,),
          Container(
            height: 35,
            child: TabBar(
                onTap: (value)
                {
                  controller.selectedComunityIndex.value = value;
                  if (value == 1)
                  {
                    controller.getAskApi();
                  }
                },
                labelColor: Colors.black,
                unselectedLabelColor: Colors.black.withOpacity(0.56),
                isScrollable: true,
                controller: tabController,
                labelStyle: bodyText1Style.copyWith(fontSize: 12),
                unselectedLabelStyle: bodyText2Style.copyWith(fontSize: 12),
                indicatorPadding: EdgeInsets.zero,
                indicatorColor: Colors.transparent,
                padding: EdgeInsets.zero,
                tabs: [
                  const Tab(
                    child: Text("COMMUNITY"),
                  ),
                  const Tab(
                    child: Text("MY ASK"),
                  ),
                ]),
          ),
          Obx(
            () => Container(
              child: controller.selectedComunityIndex.value == 0
                  ? FadeTransition(opacity: _animation!, child: CommunityPage())
                  : controller.selectedComunityIndex.value == 1
                      ? MyAsk()
                      : Container(),
            ),
          )

        ],
      ),
    );




  }


  void showAlertBox()
  {
    Get.defaultDialog
      (

        title: 'Are you sure!',
        titleStyle: TextStyle(fontSize: 20),
        middleText: 'if you want to logout please press Yes otherwise No',
        backgroundColor: Colors.white,
        radius:5,
        textCancel: 'No',

        textConfirm: 'yes',
        onCancel: (){},
        onConfirm: ()
        {  controller.logout();

        }
    );




  }

}

