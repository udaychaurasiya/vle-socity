import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:html/parser.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vlesociety/Widget/AppBarWidget2.dart';

import '../../../AppConstant/APIConstant.dart';
import '../../../AppConstant/AppConstant.dart';
import '../../../AppConstant/textStyle.dart';
import '../../../Widget/CustomAppBarWidget.dart';
import '../../controller/DashboardController.dart';
import '../profile.dart';

class PressMedia extends StatelessWidget {
   PressMedia({Key? key}) : super(key: key);
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
      appBar:
      PreferredSize(
          preferredSize: Size(
            double.infinity,
            60.0,
          ),
          child: CustomAppBar2(
              title: GetStorage().read(AppConstant.userName),
              Points: controller.points,
              image:BASE_URL+GetStorage().read(AppConstant.profileImg), onPress:_launchURL,
          )
      ),
       body: Obx(() =>controller.pressMediaData.value.data!=null?
           ListView.builder(itemCount:controller.pressMediaData.value.data?.length ,
               itemBuilder: (context,index)
       {
          final data = controller.pressMediaData.value.data![index];
          var desc = parse(data.description);
          String parsedString = parse(desc.body!.text).documentElement!.text;
         return Padding(
           padding:  EdgeInsets.only(left: 8.w,right: 8.w,bottom: 5.h),
           child: Card(

             shadowColor: Colors.white,
             shape:RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(10.0),
             ),
             child: Padding(
               padding: const EdgeInsets.only(right: 6.0),
               child: Container(
                // height:65.h,
                 decoration: BoxDecoration(
                 ),
                 child: InkWell(
                   onTap: (){
                     controller.getPressMediaDetailsNetWorkApi(data.id.toString(),context);
                   },
                   child: Row(
                     children: [
                       SizedBox(width: 15.w,),
                       Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Container(
                             width: Get.width/1.5,
                               child: Text(data.title.toString(),style: bodyText1Style.copyWith(fontSize: 17.sp),)),
                           SizedBox(height: 5.h,),
                           data.description!=null?
                           Container(
                               width: Get.width/1.5,
                               child:  Text(parsedString
                                 ,maxLines: 2,overflow: TextOverflow.ellipsis,
                                 textAlign: TextAlign.justify,

                                 style: bodyText2Style.copyWith(color: Colors.black.withOpacity(0.6),fontSize: 16.sp),),
                             ):Center()
                               //Text(data.description.toString(),style: bodyText1Style.copyWith(fontSize: 13,color: Colors.black87))),
                         ],
                       ),
                       Spacer(),
                       Container(
                         height: 70.h,
                         width: 70.w,
                         child: CircleAvatar(
                           radius: 10,
                           backgroundColor: Colors.amber.withOpacity(0.1),
                           backgroundImage: NetworkImage(BASE_URL+data.image.toString()),
                         ),
                       ) ,



                     ],
                   ),
                 ),
               ),
             ),
           ),
         );
       }
       ):Container()
       )


    );
  }
}
