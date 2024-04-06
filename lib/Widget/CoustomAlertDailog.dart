import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vlesociety/AppConstant/textStyle.dart';

import '../AppConstant/APIConstant.dart';
import '../AppConstant/AppConstant.dart';
class CustomAlertDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r)
      ),
      child: Container(
        height:400.h,
        width:Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10.h,),
            Container(
              height: 100.h,
              width:Get.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/birth4.png"),fit: BoxFit.fill
                )
              ),
            ),
            Container(
              height: 120.h,
              width: 120.w,
              decoration:BoxDecoration(
                border: Border.all(width: 3.w),
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(BASE_URL +
                      GetStorage()
                          .read(AppConstant.profileImg)
                          .toString())
                )
              ),
            ),
            Container(
              height: 70.h,
              width:Get.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/birth5.jpg"),fit: BoxFit.fill
                  )
              ),
            ),
            Text(GetStorage().read(AppConstant.userName),
              style: smallTextStyle.copyWith(color: Color(0xfffc7e00),fontSize: 20.sp,fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.0),
            InkWell(onTap: (){
              Navigator.pop(context);
            },
              child: Container(
                height: 40.h,
                width: 150.w,
                decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.circular(25.r)
                ),
                child: Center(child: Text("Back",style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 19.sp),textAlign: TextAlign.center)),
              ),
            ),
            SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
