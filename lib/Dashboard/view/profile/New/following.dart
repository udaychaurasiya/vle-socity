import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vlesociety/AppConstant/textStyle.dart';

import '../../../../AppConstant/APIConstant.dart';
import '../../../../AppConstant/AppConstant.dart';
import '../../../../Widget/AppBarWidget2.dart';
import '../../../controller/DashboardController.dart';
class Following extends StatefulWidget {
  const Following({Key? key}) : super(key: key);

  @override
  State<Following> createState() => _FollowingState();
}

class _FollowingState extends State<Following> {
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
          preferredSize: Size(
            double.infinity,
            60.0,
          ),
          child: CustomAppBar2(
            title: GetStorage().read(AppConstant.userName),
            Points: controller.points,
            image:BASE_URL+GetStorage().read(AppConstant.profileImg), onPress: _launchURL,
          )
      ),
    body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            GridView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2/3,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: 10,
              itemBuilder: (context, index) {
                return Card(
                  shadowColor: Colors.orange,
                  child: Column(
                    children: [
                      SizedBox(height: 10.h,),
                      Container(
                        height: 60.h,
                        width: 60.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage("assets/images/king.jpg"),fit: BoxFit.fill
                          )
                        ),
                      ),
                      Text("Virat Kohli",style: bodyText2Style.copyWith(),),
                      Text("(260M Followers)",style: bodyText2Style.copyWith(),),
                      Text("(Lucknow, uttar Pardesh)",style: bodyText2Style.copyWith(),textAlign: TextAlign.center,),
                      SizedBox(height: 15.h,),
                      Container(
                        height: 35.h,
                        width: 120.w,
                        decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(20.r),
                          color: Colors.blue
                        ),
                        child: Center(child: Text("+ Follow",textAlign: TextAlign.center,style:bodyText2Style.copyWith(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 14.sp)
                        ),)),
                    ],
                  )
                );
              },
            ),
          ],
        ),
      ),
    ),
    );
  }
}
