import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vlesociety/AppConstant/APIConstant.dart';
import 'package:vlesociety/Dashboard/controller/DashboardController.dart';
import 'package:vlesociety/Dashboard/view/profile.dart';
import 'package:vlesociety/Dashboard/view/profile/ChaAdmin.dart';

import '../../../AppConstant/textStyle.dart';
import 'TestimonialsDetails.dart';
class Tesimonials extends StatefulWidget {
  const Tesimonials({Key? key}) : super(key: key);
  @override
  State<Tesimonials> createState() => _TesimonialsState();
  }

final _controller = PageController();


class _TesimonialsState extends State<Tesimonials> {
  DashboardController controller = Get.find();
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
    return Scaffold(
      appBar: PreferredSize(
        child: Stack(
          children: [
            Positioned(
                top: -80,
                right: 60,
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:   Color(0xffcdf55a),
                  ),
                )
            ),
            ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: AppBar(
                  backgroundColor: Colors.white.withOpacity(0.5),
                  leading: Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.amber.withOpacity(0.1),
                      backgroundImage: NetworkImage(BASE_URL+controller.image),
                    ),
                  ),
                  leadingWidth: 60,
                  title:  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.userName.toString(),
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      Text(
                        controller.points.toString()+" Points",
                        style: smallTextStyle.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 11,
                            color: Colors.green),
                      ),
                    ],
                  )
                  ,
                  elevation: 0.0,
                  actions: [
                    RawMaterialButton(
                      constraints: BoxConstraints(
                          maxHeight: 30.h, minWidth: 30.w),
                      onPressed:_launchURL,
                      shape: CircleBorder(),
                      child: Image.asset
                        (
                        "assets/images/shoppingcart.png",
                        height: 25.h,
                        width: 25.w,
                        fit: BoxFit.fill,
                      ),
                    ),
                    RawMaterialButton(
                      constraints:
                      BoxConstraints(maxHeight: 40.h, minWidth: 40.w),
                      onPressed: () {
                        if(int.parse(controller.points.toString())>=100){
                          Get.to(() => chats());
                        }else{
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Points must be 100 or more to proceed.')),
                          );
                        }
                      },
                      shape: CircleBorder(),
                      child: Image.asset(
                        "assets/images/chat.png",
                        height: 35,
                        width: 35,
                        fit: BoxFit.fill,
                      ),
                    ),
                    RawMaterialButton (
                      constraints: BoxConstraints(maxHeight: 40, minWidth: 40),
                      onPressed: () {
                        Get.to(()=>Profile());
                        //  controller.logout();
                      },
                      shape: CircleBorder(
                          side: BorderSide(width: 0.5, color: Colors.black)),
                      child: Image.asset("assets/images/menu.png",
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
            ),
          ],
        ),
        preferredSize: Size(
          double.infinity,
          60.0,
        ),
      ),
      body: SingleChildScrollView(
        child:Obx(() => controller.testimonialModel.value.data!.length!=null?
        Column(
          children: [
            Stack(
                children:[
                  Container(
                    height: 130.h,
                    child: PageView.builder
                      (
                        controller: _controller,
                        itemCount:controller.testimonialModel.value.data!.length ,

                        itemBuilder: (context,int index)
                        {
                          final data=controller.testimonialModel.value.data![index];

                          return InkWell(
                              onTap: ()
                              {
                                data.toString().isNotEmpty?
                                Navigator.push(context, PageTransition(type: PageTransitionType.bottomToTop,
                                    duration: Duration(milliseconds: 700), child:TestimonialsDetails(data.description.toString(),
                                        data.profile.toString(),
                                        data.name.toString(),
                                        data.location.toString()

                                    ))):Container();
                              },
                            child: Container(
                              margin: EdgeInsets.all(5),
                              padding: EdgeInsets.all(5),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(top: 5),
                                    alignment: Alignment.topLeft,
                                    child: CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Colors.blue,
                                      backgroundImage: NetworkImage(BASE_URL+data.profile.toString()),



                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),

                                  /*CachedNetworkImage(
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
                                                  )*/
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Column(

                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children:
                                        [
                                          Text(data.description.toString(),
                                            style: TextStyle(
                                              fontSize: 16,overflow: TextOverflow.ellipsis,
                                            ),maxLines: 3,softWrap: false,textAlign: TextAlign.justify,
                                          ),
                                          SizedBox(height: 10,),
                                          Container(
                                            height: 3.h,
                                            width: 200.w,
                                            color: Colors.blue.shade300,
                                          ),
                                          SizedBox(height: 10,),
                                          Text(
                                            data.location.toString(),
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  )


                ]
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 20),
              child: SmoothPageIndicator(
                controller: _controller,
                count: controller.testimonialModel.value.data!.length,
                effect: ExpandingDotsEffect(
                  activeDotColor: Colors.black,
                  dotColor: Colors.black,
                  paintStyle: PaintingStyle.stroke,
                  dotHeight: 7,
                  dotWidth: 8,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.all(8),
              shrinkWrap: true,
              itemCount: controller.testimonialModel.value.data!.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing:15.0,
                  childAspectRatio: 1.6,
                  mainAxisSpacing: 10.0),
              itemBuilder: (BuildContext context, int index)
              {
                final value1=controller.testimonialModel.value.data![index];
                return InkWell(
                  onTap: ()
                  {  value1.toString().isNotEmpty?
                       Navigator.push(context, PageTransition(type: PageTransitionType.bottomToTop,
                        duration: Duration(milliseconds: 700), child:TestimonialsDetails(
                               value1.description.toString(),
                               value1.profile.toString(),
                               value1.name.toString(),
                               value1.location.toString()
                           ))):Container();
                  },
                  child: Container(
                    height: 100,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image:
                          NetworkImage(BASE_URL+value1.profile.toString()),
                          fit: BoxFit.fill,


                        ),

                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Stack(
                        children:[
                          Positioned(
                            top:70.w,
                            left: 0.w,
                            right: 0.w,
                            child: ClipRRect(
                              child: Container(
                                height:MediaQuery.of(context).size.width/12,
                                width: MediaQuery.of(context).size.width,
                                color: Colors.grey.withOpacity(.5),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                    sigmaX: 10.0,
                                    sigmaY: 10.0,
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 20.0,
                                    height: 0.0,
                                    child:  Text(value1.description.toString(),
                                      style: smallTextStyle.copyWith(fontSize: 11.sp,height: 1.h),
                                      overflow: TextOverflow.ellipsis ,maxLines: 2,),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ]
                    ),
                  ),
                );
              },
            ),
          ],
        ):Container())

      ),
    );
  }
}