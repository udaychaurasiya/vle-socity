import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../AppConstant/textStyle.dart';
import '../controller/DashboardController.dart';
import 'ServicesDescription.dart';
import 'SubCategoryOfCategoryServices.dart';
class SubCategoryOfServices extends StatelessWidget
{
  final String title;
  final String type;
  SubCategoryOfServices(this.title, this.type,  {Key? key}) : super(key: key);
  DashboardController controller = Get.find();
  @override
  Widget build(BuildContext context)
  {

    return
      Scaffold(
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
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: AppBar(
                  backgroundColor: Colors.white.withOpacity(0.5),
                  leading: Container(
                    height: 8,
                    width: 8,
                    decoration: BoxDecoration(

                    ),
                    child: IconButton(
                      onPressed:()=> Navigator.of(context).pop(),
                      icon: Icon(Icons.arrow_back_ios_new,color: Colors.black,),),
                  ),
                  leadingWidth: 60,
                  elevation: 0.0,
                  title: title!=null?
                  Text(title, style: subtitleStyle.copyWith(fontWeight: FontWeight.w900,fontSize: 16)
                  ):Text("", style: TextStyle(color: Colors.black, fontSize: 16)
                  ),
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

      body:
      Obx(() =>controller.serviceCategoryModel.value.data!= null?ListView.builder(
          itemCount: controller.serviceCategoryModel.value.data!.length,
          itemBuilder: (context,index)
          {
            return
              Padding(
              padding: const EdgeInsets.only(left: 12.0,right: 12,top: 10),
              child: Card(
                shadowColor: Colors.white,
                elevation: 1.0,
                surfaceTintColor: Colors.white,
                child: InkWell(
                  highlightColor: Colors.yellow.withOpacity(0.3),
                  splashColor: Colors.greenAccent.withOpacity(0.8),
                  focusColor: Colors.green.withOpacity(0.0),
                  hoverColor: Colors.blue.withOpacity(0.8),
                  onTap: ()
                  {
                   // print(  "xvbjchv"+controller.serviceCategoryModel.value.data![index].isGosite.toString());
                    if(type=="0")
                      {
                        controller.serviceCategoryModel.value.data![index].isGosite=='0'?
                        controller.getServicesSubCategoryOfCategoryNetworkApi(controller.serviceCategoryModel.value.data![index].id.toString(),
                            controller.serviceCategoryModel.value.data![index].title.toString())
                            :Get.to(ServicesDescription( controller.serviceCategoryModel.value.data![index].description.toString(),
                            controller.serviceCategoryModel.value.data![index].url.toString(),controller.serviceCategoryModel.value.data![index].title.toString(),controller.serviceCategoryModel.value.data![index].image.toString()));

                      }
                    else if(type=="1")
                        {
                              controller.serviceCategoryModel.value.data![index].isGosite=='0'?
                              controller.getServicesGovernmentSubCategoryOfCategoryNetworkApi(controller.serviceCategoryModel.value.data![index].id.toString(),
                              controller.serviceCategoryModel.value.data![index].title.toString())
                              :Get.to(ServicesDescription( controller.serviceCategoryModel.value.data![index].description.toString(),
                              controller.serviceCategoryModel.value.data![index].url.toString(),controller.serviceCategoryModel.value.data![index].title.toString(),controller.serviceCategoryModel.value.data![index].image.toString()));

                        }
                    else if(type=="2")
                      {
                            controller.serviceCategoryModel.value.data![index].isGosite=='0'?
                            controller.getServicesCSCSubCategoryOfCategoryNetworkApi(controller.serviceCategoryModel.value.data![index].id.toString(),
                            controller.serviceCategoryModel.value.data![index].title.toString())
                            :Get.to(ServicesDescription( controller.serviceCategoryModel.value.data![index].description.toString(),
                            controller.serviceCategoryModel.value.data![index].url.toString(),controller.serviceCategoryModel.value.data![index].title.toString(),controller.serviceCategoryModel.value.data![index].image.toString()));

                      }

                       },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    color: Colors.orange,
                    child: Center(child: Text(controller.serviceCategoryModel.value.data![index].title.toString(),
                      style: bodyText1Style.copyWith(color: Colors.white,fontSize: 16.sp),)),
                  ),
                ),
              ),
            );
          }):
         Center(
        child: CupertinoActivityIndicator(),
           ),
      )

    );
  }
}