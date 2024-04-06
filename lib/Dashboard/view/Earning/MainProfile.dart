import 'dart:io';
import 'dart:ui';

import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:vlesociety/Dashboard/view/Earning/controller/DetailsController.dart';

import '../../../AppConstant/APIConstant.dart';
import '../../../AppConstant/AppConstant.dart';
import '../../../AppConstant/textStyle.dart';
import '../../../Auth/controller/login_controller.dart';
import '../../../Auth/model/CityModel.dart';
import '../../../Auth/model/StateModel.dart';
import '../../../Widget/CircularButton.dart';
import '../../../Widget/EditTextWidget.dart';
import '../../controller/DashboardController.dart';
class MainProfile extends StatefulWidget {
  const MainProfile({Key? key}) : super(key: key);

  @override
  State<MainProfile> createState() => _MainProfileState();
}

class _MainProfileState extends State<MainProfile> {
  LoginController loginController = Get.put(LoginController());
  final DeatilsController _controller=Get.put(DeatilsController());
  DashboardController controller = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.getFollowersApi();
    _controller.getFollowingApi();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200.h,
              child: Stack(
                children: [
                  Container(
                    height: 180.h,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Color(0xf9ff840a),
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 40.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
                                        child: Icon(Icons.keyboard_arrow_left, color: Colors.white),
                                      ),
                                      Text('Back',
                                          style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold,color: Colors.white))
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 50.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap:(){
                                  loginController.getStateNetworkApi();

                                  bottomSheet();
                                },
                                child: Container(
                                  height: 30.h,
                                  width: 30.w,
                                  child:Image.asset("assets/images/editing.png",color: Colors.white,),
                                ),
                              ),
                              Container(
                                child: Column(
                                  children: [

                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 100.h,
                    left: 10.w,
                    child: Row(
                      children: [
                        InkWell(
                          onTap:(){
                            showDialog(
                              context: context,
                              builder: (_) =>
                                  Dialog(
                                    alignment: Alignment.center,
                                    insetPadding:EdgeInsets.all(20.w) ,
                                    backgroundColor: Colors.transparent,
                                    child:
                                    Container(
                                      height: 300.h,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(10.r)
                                      ),
                                      child:
                                      Padding(
                                        padding: EdgeInsets.all(10.w),
                                        child: Column(
                                          children:[
                                            CachedNetworkImage(
                                              fit: BoxFit.cover,
                                              imageUrl:BASE_URL+GetStorage().read(AppConstant.profileImg).toString(),
                                              height: 280.h,
                                              width: double.infinity,
                                              placeholder: (context, url) => Center(
                                                  child: const CupertinoActivityIndicator()),
                                              errorWidget: (context, url, error) =>
                                                  CircleAvatar(
                                                      backgroundColor:
                                                      Colors.amber.withOpacity(0.1),
                                                      child: const Icon(
                                                        Icons.image_not_supported_outlined,
                                                        color: Colors.black26,
                                                      )),
                                            )

                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                            );
                          },
                          child: Container(
                            height:100,
                            width: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              border: Border.all(width: 2.w,color: Colors.black),
                              // image: DecorationImage(
                              //     image: NetworkImage(BASE_URL+GetStorage().read(AppConstant.profileImg).toString()),fit: BoxFit.fill                                        )
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50.r),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: BASE_URL+GetStorage().read(AppConstant.profileImg).toString(),
                                height:100,
                                width: 100,
                                placeholder: (context, url) =>
                                    Center(child: const CircularProgressIndicator()),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.person,color: Colors.grey,size: 80.sp,),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(GetStorage().read(AppConstant.userName),maxLines:3,style: TextStyle(fontSize: 16.sp,color: Colors.white,fontWeight: FontWeight.bold),),
                              Container(
                                  width: 230.w,
                                  child: Text("",style: smallTextStyle.copyWith(color: Colors.white,fontSize:12.sp),))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h,),
            Container(
              height: MediaQuery.of(context).size.height/1.45,
              child: ContainedTabBarView(
                tabBarProperties: TabBarProperties(
                  indicatorColor: Colors.orange,
                  unselectedLabelColor: Colors.black,
                  labelColor: Colors.orange,
                  height: 30.h,
                ),
                  tabs: [
                    Text('Followers',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.sp),),
                    Text('Following',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.sp)),
                    Text('My Referral',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.sp)),
                  ],
                  views: [
                     Center(
              child: RefreshIndicator(
              color: Color(0xff049486),
              onRefresh: (){
                return Future.delayed(Duration.zero, () {
                  _controller.getFollowersApi();
                });
              },
              child:
              Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                        child: Obx(()=>_controller.followModel.value.data!=null
                            ?
                        Column(
                          children: [
                            _controller.followModel.value.data.isNotEmpty?
                            ListView.builder(
                                itemCount:_controller.followModel.value.data.length,
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (context,index){
                                  final data=_controller.followModel.value.data[index];
                                  print(data);
                                  return Padding(
                                    padding:  EdgeInsets.only(left: 8.w,right: 8.w,top: 8.h),
                                    child: Container(
                                      width: Get.width,
                                      child: Row(

                                        children: [
                                          Container(
                                            height: 50.h,
                                            width: 50.w,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                            ),
                                            child: InkWell(
                                              onTap: (){
                                                showDialog(
                                                  context: context,
                                                  builder: (_) =>
                                                      Dialog(
                                                        alignment: Alignment.center,
                                                        insetPadding:EdgeInsets.all(20) ,
                                                        backgroundColor: Colors.transparent,
                                                        child:
                                                        Container(
                                                          height: 300.h,
                                                          width: double.infinity,
                                                          decoration: BoxDecoration(
                                                              color: Colors.white,
                                                              borderRadius: BorderRadius.circular(10)
                                                          ),
                                                          child:
                                                          Padding(
                                                            padding: EdgeInsets.all(10.w),
                                                            child: Column(
                                                              children:
                                                              [
                                                                CachedNetworkImage(
                                                                  fit: BoxFit.cover,
                                                                  imageUrl: BASE_URL + data.profile.toString(),
                                                                  height: 280.h,
                                                                  width: double.infinity,
                                                                  placeholder: (context, url) => Center(
                                                                      child: const CupertinoActivityIndicator()),
                                                                  errorWidget: (context, url, error) =>
                                                                      CircleAvatar(
                                                                          backgroundColor:
                                                                          Colors.amber.withOpacity(0.1),
                                                                          child: const Icon(
                                                                            Icons.image_not_supported_outlined,
                                                                            color: Colors.black26,
                                                                          )),
                                                                )

                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                );
                                              },
                                              child: ClipOval(
                                                child: CachedNetworkImage(
                                                  fit: BoxFit.cover,
                                                  imageUrl: BASE_URL + data.profile.toString(),
                                                  height: 50,
                                                  width: 50,
                                                  placeholder: (context, url) => Center(
                                                      child: const CupertinoActivityIndicator()),
                                                  errorWidget: (context, url, error) =>
                                                      CircleAvatar(
                                                          backgroundColor:
                                                          Colors.amber.withOpacity(0.1),
                                                          child:  Icon(
                                                            Icons.image_not_supported_outlined,
                                                            color: Colors.black26,
                                                          )),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 13.w,),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(data.name.toString()),
                                                  SizedBox(width: 5.w,),
                                                  Container(
                                                      alignment: Alignment.topCenter,
                                                      child:  data.isVerify=="1"?
                                                      Image(image: AssetImage("assets/images/us.png",),width: 15.w,height: 15.h,
                                                      ):Container()
                                                  )
                                                ],
                                              ),
                                              Text(data.cityName.toString()+", "+data.stateName.toString()+" , "+data.zipCode.toString(),style: TextStyle(fontSize: 11.sp,color: Colors.black45),),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }):Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:MainAxisAlignment.center,
                                  children: [
                                    SizedBox(height: 200.h,),
                                    Center(child: Text("No Record Found !",textAlign: TextAlign.center,)),
                                  ],
                                )
                          ],
                        ):Container(
                          child: Center(child: Text("No Record found !",style: TextStyle(color: Colors.black),),),
                        ),
                        )),
                  )
                ],
              ),
            ),
      ),
                      Center(
                      child: RefreshIndicator(
                        color: Color(0xff049486),
                        onRefresh: (){
                          return Future.delayed(Duration.zero, () {
                            _controller.getFollowersApi();
                          });
                        },
                        child:
                        Column(
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                  child: Obx(()=>_controller.followingModel.value.data!=null
                                      ?
                                  Column(
                                    children: [
                                      _controller.followingModel.value.data.isNotEmpty
                                          ?
                                      ListView.builder(
                                          itemCount:_controller.followingModel.value.data.length,
                                          shrinkWrap: true,
                                          physics: BouncingScrollPhysics(),
                                          itemBuilder: (context,index){
                                            final data=_controller.followingModel.value.data[index];
                                            print(data);
                                            return Padding(
                                              padding:  EdgeInsets.only(left: 8.w,right: 8.w,top: 8.h),
                                              child: Container(
                                                width: Get.width,
                                                child: Row(

                                                  children: [
                                                    Container(
                                                      height: 50.h,
                                                      width: 50.w,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: InkWell(
                                                        onTap: (){
                                                          showDialog(
                                                            context: context,
                                                            builder: (_) =>
                                                                Dialog(
                                                                  alignment: Alignment.center,
                                                                  insetPadding:EdgeInsets.all(20) ,
                                                                  backgroundColor: Colors.transparent,
                                                                  child:
                                                                  Container(
                                                                    height: 300.h,
                                                                    width: double.infinity,
                                                                    decoration: BoxDecoration(
                                                                        color: Colors.white,
                                                                        borderRadius: BorderRadius.circular(10)
                                                                    ),
                                                                    child:
                                                                    Padding(
                                                                      padding: EdgeInsets.all(10.w),
                                                                      child: Column(
                                                                        children:[
                                                                          CachedNetworkImage(
                                                                            fit: BoxFit.cover,
                                                                            imageUrl: BASE_URL + data.profile.toString(),
                                                                            height: 280.h,
                                                                            width: double.infinity,
                                                                            placeholder: (context, url) => Center(
                                                                                child: const CupertinoActivityIndicator()),
                                                                            errorWidget: (context, url, error) =>
                                                                                CircleAvatar(
                                                                                    backgroundColor:
                                                                                    Colors.amber.withOpacity(0.1),
                                                                                    child: const Icon(
                                                                                      Icons.image_not_supported_outlined,
                                                                                      color: Colors.black26,
                                                                                    )),
                                                                          )

                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                          );
                                                        },
                                                        child: ClipOval(
                                                          child: CachedNetworkImage(
                                                            fit: BoxFit.cover,
                                                            imageUrl: BASE_URL + data.profile.toString(),
                                                            height: 50,
                                                            width: 50,
                                                            placeholder: (context, url) => Center(
                                                                child: const CupertinoActivityIndicator()),
                                                            errorWidget: (context, url, error) =>
                                                                CircleAvatar(
                                                                    backgroundColor:
                                                                    Colors.amber.withOpacity(0.1),
                                                                    child:  Icon(
                                                                      Icons.image_not_supported_outlined,
                                                                      color: Colors.black26,
                                                                    )),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 13.w,),
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text(data.name.toString()),
                                                            SizedBox(width: 5.w,),
                                                            Container(
                                                                alignment: Alignment.topCenter,
                                                                child:  data.isVerify=="1"?
                                                                Image(image: AssetImage("assets/images/us.png",),width: 15.w,height: 15.h,
                                                                ):Container()
                                                            )
                                                          ],
                                                        ),
                                                        Text(data.cityName.toString()+", "+data.stateName.toString()+" , "+data.zipCode.toString(),style: TextStyle(fontSize: 11.sp,color: Colors.black45),),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                          }):Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment:MainAxisAlignment.center,
                                        children: [
                                          SizedBox(height: 200.h,),
                                          Center(child: Text("No Record Found !",textAlign: TextAlign.center,)),
                                        ],
                                      )
                                    ],
                                  ):Container(),
                                  )),
                            )
                          ],
                        ),
                      ),
                    ),
                      Center(
                      child: Text("No Record Found !"),
                    ),
                  ],
                  // child: Column(
                  //   children: [
                  //     ButtonsTabBar(
                  //       backgroundColor: Color(0xf9ff840a),
                  //       buttonMargin: EdgeInsets.only(left: 30.w,right: 70.w),
                  //       unselectedBackgroundColor: Colors.grey[300],
                  //       unselectedLabelStyle: TextStyle(color: Colors.black),
                  //       labelStyle:
                  //       TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  //       tabs: [
                  //          Tab(
                  //           icon: Icon(Icons.person_add_alt_1_rounded),
                  //           text:" Followers",
                  //         ),
                  //         Tab(
                  //           icon: Icon(Icons.supervised_user_circle),
                  //           text:" Following",
                  //         ),
                  //       ],
                  //     ),
                  //     SizedBox(height: 20.h,),
                  //     Expanded(
                  //       child: TabBarView(
                  //         children:[
                  //           Center(
                  //             child: RefreshIndicator(
                  //               color: Color(0xff049486),
                  //               onRefresh: (){
                  //                 return Future.delayed(Duration.zero, () {
                  //                   _controller.getFollowersApi();
                  //                 });
                  //               },
                  //               child:
                  //                 Column(
                  //                   children: [
                  //                     Expanded(
                  //                         child: SingleChildScrollView(
                  //                           child: Obx(()=>_controller.followModel.value.data!=null
                  //                            ?
                  //                           Column(
                  //                           children: [
                  //                           ListView.builder(
                  //                               itemCount:_controller.followModel.value.data.length,
                  //                               shrinkWrap: true,
                  //                               physics: BouncingScrollPhysics(),
                  //                               itemBuilder: (context,index){
                  //                                 final data=_controller.followModel.value.data[index];
                  //                                 print(data);
                  //                             return Padding(
                  //                               padding:  EdgeInsets.only(left: 8.w,right: 8.w,top: 8.h),
                  //                               child: Container(
                  //                                 width: Get.width,
                  //                                 child: Row(
                  //
                  //                                   children: [
                  //                                    Container(
                  //                                       height: 50.h,
                  //                                       width: 50.w,
                  //                                       decoration: BoxDecoration(
                  //                                         shape: BoxShape.circle,
                  //                                       ),
                  //                                      child: ClipOval(
                  //                                        child: CachedNetworkImage(
                  //                                          fit: BoxFit.cover,
                  //                                          imageUrl: BASE_URL + data.profile.toString(),
                  //                                          height: 50,
                  //                                          width: 50,
                  //                                          placeholder: (context, url) => Center(
                  //                                              child: const CupertinoActivityIndicator()),
                  //                                          errorWidget: (context, url, error) =>
                  //                                              CircleAvatar(
                  //                                                  backgroundColor:
                  //                                                  Colors.amber.withOpacity(0.1),
                  //                                                  child:  Icon(
                  //                                                    Icons.image_not_supported_outlined,
                  //                                                    color: Colors.black26,
                  //                                                  )),
                  //                                        ),
                  //                                      ),
                  //                                     ),
                  //                                     SizedBox(width: 13.w,),
                  //                                     Column(
                  //                                       crossAxisAlignment: CrossAxisAlignment.start,
                  //                                       mainAxisAlignment: MainAxisAlignment.start,
                  //                                       children: [
                  //                                         Text(data.name.toString()),
                  //                                         Text(data.cityName.toString()+", "+data.stateName.toString()+" , "+data.zipCode.toString(),style: TextStyle(fontSize: 11.sp,color: Colors.black45),),
                  //                                       ],
                  //                                     )
                  //                                   ],
                  //                                 ),
                  //                               ),
                  //                             );
                  //                           })
                  //                       ],
                  //                     ):Container(),
                  //                         )),
                  //                     )
                  //                   ],
                  //               ),
                  //             ),
                  //           ),
                  //           Center(
                  //             child: RefreshIndicator(
                  //               color: Color(0xff049486),
                  //               onRefresh: (){
                  //                 return Future.delayed(Duration.zero, () {
                  //                   _controller.getFollowersApi();
                  //                 });
                  //               },
                  //               child:
                  //               Column(
                  //                 children: [
                  //                   Expanded(
                  //                     child: SingleChildScrollView(
                  //                         child: Obx(()=>_controller.followingModel.value.data!=null
                  //                             ?
                  //                         Column(
                  //                           children: [
                  //                             ListView.builder(
                  //                                 itemCount:_controller.followModel.value.data.length,
                  //                                 shrinkWrap: true,
                  //                                 physics: BouncingScrollPhysics(),
                  //                                 itemBuilder: (context,index){
                  //                                   final data=_controller.followModel.value.data[index];
                  //                                   print(data);
                  //                                   return Padding(
                  //                                     padding:  EdgeInsets.only(left: 8.w,right: 8.w,top: 8.h),
                  //                                     child: Container(
                  //                                       width: Get.width,
                  //                                       child: Row(
                  //
                  //                                         children: [
                  //                                           Container(
                  //                                             height: 50.h,
                  //                                             width: 50.w,
                  //                                             decoration: BoxDecoration(
                  //                                               shape: BoxShape.circle,
                  //                                             ),
                  //                                             child: ClipOval(
                  //                                               child: CachedNetworkImage(
                  //                                                 fit: BoxFit.cover,
                  //                                                 imageUrl: BASE_URL + data.profile.toString(),
                  //                                                 height: 50,
                  //                                                 width: 50,
                  //                                                 placeholder: (context, url) => Center(
                  //                                                     child: const CupertinoActivityIndicator()),
                  //                                                 errorWidget: (context, url, error) =>
                  //                                                     CircleAvatar(
                  //                                                         backgroundColor:
                  //                                                         Colors.amber.withOpacity(0.1),
                  //                                                         child:  Icon(
                  //                                                           Icons.image_not_supported_outlined,
                  //                                                           color: Colors.black26,
                  //                                                         )),
                  //                                               ),
                  //                                             ),
                  //                                           ),
                  //                                           SizedBox(width: 13.w,),
                  //                                           Column(
                  //                                             crossAxisAlignment: CrossAxisAlignment.start,
                  //                                             mainAxisAlignment: MainAxisAlignment.start,
                  //                                             children: [
                  //                                               Text(data.name.toString()),
                  //                                               Text(data.cityName.toString()+", "+data.stateName.toString()+" , "+data.zipCode.toString(),style: TextStyle(fontSize: 11.sp,color: Colors.black45),),
                  //                                             ],
                  //                                           )
                  //                                         ],
                  //                                       ),
                  //                                     ),
                  //                                   );
                  //                                 })
                  //                           ],
                  //                         ):Container(),
                  //                         )),
                  //                   )
                  //                 ],
                  //               ),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  // )
              ),
            ),
          ],
        ),
      ),
        );
  }
  Widget imageProfile() {
    return Container(
      height: 74,
      width: 74,
      child: Stack(
        children: [
          Obx(
                () => loginController.rxPath.value.isEmpty
                ? InkWell(
              onTap: ()
              {
                showOptionDailog(context);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60),
                  border: Border.all(),
                  image: DecorationImage(
                      image: NetworkImage(BASE_URL + controller.image),
                      fit: BoxFit.fill),
                ),
                child: Container(),
              ),
            )
                :
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60),
                border: Border.all(),
                image: DecorationImage(
                    image: FileImage(File(loginController.rxPath.value)),
                    fit: BoxFit.fill),
              ),
            ),
          ),
          Positioned(
              bottom: 0,
              right: 0,
              child: InkWell(
                onTap: ()
                {
                  showOptionDailog(context);
                },
                child: Icon(
                  Icons.camera_alt_rounded,
                  size: 20,
                  color: Colors.grey,
                ),
              )),
        ],
      ),
    );
  }
  showOptionDailog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => SimpleDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4.0))),
          backgroundColor:
          Theme.of(context).dialogBackgroundColor.withOpacity(0.9),
          children: [
            SimpleDialogOption(
              onPressed: () {
                loginController.chooseImage(false);
                Get.back();
              },
              child: Row(
                children: [
                  Icon(Icons.image),
                  Text(
                    "   Gallery",
                    style: Theme.of(context).textTheme.bodyText1,
                  )
                ],
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                loginController.chooseImage(true);

                Get.back();
              },
              child: Row(
                children: [
                  Icon(Icons.camera),
                  Text(
                    "   Camera",
                    style: Theme.of(context).textTheme.bodyText1,
                  )
                ],
              ),
            ),
            SimpleDialogOption(
              onPressed: () => Get.back(),
              child: Row(
                children: [
                  Icon(Icons.clear),
                  Text(
                    "  Cancel",
                    style: Theme.of(context).textTheme.bodyText1,
                  )
                ],
              ),
            ),
          ],
        ));
  }
  void bottomSheet() {
    loginController.setEtDataController();
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;
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
                        height: Get.height / 1.3,
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
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      // Row(
                                      //   crossAxisAlignment: CrossAxisAlignment.start,
                                      //   children: [
                                      //     Padding(padding: EdgeInsets.only(left: 60)),
                                      //     Text(
                                      //       "Profile",
                                      //       style: playfairDisplay.copyWith(
                                      //           fontWeight: FontWeight.w800),
                                      //     ),
                                      //   ],
                                      // ),
                                      // const SizedBox(
                                      //   height: 30,
                                      // ),
                                      Row(
                                        children: [
                                          Padding(padding: EdgeInsets.only(left: 20)),
                                          imageProfile(),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: [
                                                Text(controller.userName.toString(),
                                                    style: titleStyle.copyWith(
                                                        fontSize: 17,
                                                        fontWeight: FontWeight.w800)),
                                                SizedBox(
                                                  height: 4,
                                                ),
                                                Text(
                                                  "",
                                                  style: subtitleStyle,
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      // const SizedBox(
                                      //   height: 30,
                                      // ),
                                      Form(
                                        key: loginController.formKey,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                                padding: EdgeInsets.only(left: 80),
                                                child: Center(
                                                  child: EditTextWidget(
                                                    controller: loginController.etName,
                                                    hint: 'Name',
                                                    validator: (value) {
                                                      if (value.toString().isEmpty) {
                                                        return "Please Enter Name";
                                                      }
                                                      return null;
                                                    },
                                                    length: 22,
                                                  ),
                                                )),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Padding(
                                                padding: EdgeInsets.only(left: 80),
                                                child: Center(
                                                  child: EditTextWidget(
                                                    controller: loginController.etEmail,
                                                    hint: 'Email',
                                                    validator: (value) {
                                                      if (value.toString().isEmpty)
                                                      {
                                                        return "Please Enter Email";
                                                      }
                                                      if (!GetUtils.isEmail(value)) {
                                                        return "Please Enter Valid Email";
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                )),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(left: 80),
                                              child: Center(
                                                child: TextFormField(
                                                    controller: loginController.dob,
                                                    decoration: InputDecoration(
                                                      prefixIconConstraints:
                                                      BoxConstraints(
                                                        minWidth: 20,
                                                      ),
                                                      enabledBorder:
                                                      const UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors.black),
                                                      ),
                                                      focusedBorder:
                                                      const UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors.black),
                                                      ),
                                                      hintText: "Select Date Of Birth",
                                                      isDense: true,
                                                      counter: Offstage(),
                                                      contentPadding:
                                                      const EdgeInsets.symmetric(
                                                          horizontal: 1.5,
                                                          vertical: 5),
                                                    ),
                                                    readOnly: true,
                                                    onTap: () async {
                                                      final Datet =
                                                      await showDatePicker(
                                                          context: context,
                                                          builder:
                                                              (context, child) {
                                                            return Theme(
                                                              data:
                                                              Theme.of(context)
                                                                  .copyWith(
                                                                colorScheme:
                                                                ColorScheme
                                                                    .light(
                                                                  primary:
                                                                  Colors.white,
                                                                  // <-- SEE HERE
                                                                  onPrimary: Colors
                                                                      .redAccent,
                                                                  // <-- SEE HERE
                                                                  onSurface: Colors
                                                                      .black, // <-- SEE HERE
                                                                ),
                                                                textButtonTheme:
                                                                TextButtonThemeData(
                                                                  style: TextButton
                                                                      .styleFrom(
                                                                    primary: Colors
                                                                        .red, // button text color
                                                                  ),
                                                                ),
                                                              ),
                                                              child: child!,
                                                            );
                                                          },
                                                          initialDate:
                                                          DateTime.now(),
                                                          firstDate: DateTime(1950),
                                                          lastDate: DateTime(2050));
                                                      if (Datet != null) {
                                                        String formattedDate =
                                                        DateFormat('dd/MM/yyyy')
                                                            .format(Datet);
                                                        loginController.dob.text = formattedDate;
                                                      }
                                                    },
                                                    keyboardType: TextInputType.text,
                                                    validator: (value) {
                                                      if (value.toString().isEmpty) {
                                                        return "Please Enter DOB";
                                                      }
                                                      return null;
                                                    },
                                                    style: subtitleStyle),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Padding(
                                                padding: EdgeInsets.only(left: 80),
                                                child: Center(
                                                  child: EditTextWidget(
                                                    controller:
                                                    loginController.etMobile,
                                                    hint: 'Mobile',
                                                    validator: (value) {
                                                      if (value.toString().isEmpty) {
                                                        return "Please enter mobile";
                                                      }
                                                      if (value.toString().length !=
                                                          10) {
                                                        return "Please enter 10 digit Number";
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                )),
                                            Padding(
                                                padding: EdgeInsets.only(left: 80),
                                                child: Center(
                                                  child: EditTextWidget(
                                                    controller:
                                                    loginController.etZip,
                                                    hint: 'Zip Code',
                                                    validator: (value) {
                                                      if (value.toString().isEmpty) {
                                                        return "Please enter Zip Code";
                                                      }
                                                      if (value.toString().length !=
                                                          6) {
                                                        return "Please enter 6 digit Number";
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                )),
                                            SizedBox
                                              (
                                              height: 10,
                                            ),
                                            Padding(
                                                padding: EdgeInsets.only(left: 80),
                                                child: Center(
                                                  child: EditTextWidget(
                                                    controller:
                                                    loginController.etblock,
                                                    hint: 'Block',
                                                    validator: (value) {
                                                      if (value.toString().isEmpty) {
                                                        return "Please enter block";
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                )),
                                            SizedBox
                                              (
                                              height: 5,
                                            ),
                                            Padding(
                                                padding: EdgeInsets.only(left: 80),
                                                child: Center(
                                                  child: Obx(()
                                                  {
                                                    int ind = loginController.stateData.value.data!.indexWhere((element) => element.stateId == GetStorage().read(AppConstant.stateId).toString());
                                                    if (ind != -1)
                                                    {
                                                      loginController.selectedState = loginController.stateData.value.data![ind];
                                                      loginController.etSate.text = loginController.stateData.value.data![ind].stateId!;
                                                      loginController.getCityNetworkApi(
                                                          loginController.stateData
                                                              .value.data![ind].stateId
                                                              .toString());
                                                    }
                                                    return loginController.stateData.value.data != null
                                                        ? DropdownButton(
                                                      value: loginController
                                                          .selectedState,
                                                      isExpanded: true,
                                                      underline: Container(
                                                        height: 5,
                                                        decoration:
                                                        const BoxDecoration(
                                                          border: Border(
                                                            bottom: BorderSide(
                                                              color: Colors.black,
                                                              width: 1.2,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      icon: const Icon(Icons
                                                          .keyboard_arrow_down),
                                                      items: loginController
                                                          .stateData.value.data!
                                                          .map(
                                                              (StateDatum items) {
                                                            return DropdownMenuItem(
                                                              value: items,
                                                              child: Text(
                                                                  " " +
                                                                      items.stateTitle
                                                                          .toString(),
                                                                  style:
                                                                  subtitleStyle),
                                                            );
                                                          }).toList(),
                                                      hint: Text(
                                                        " Select State",
                                                        style: subtitleStyle
                                                            .copyWith(
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                0.7)),
                                                      ),
                                                      onChanged: (newValue) {
                                                        print("dbvbsdovb");
                                                        loginController
                                                            .selectedState =
                                                        newValue!;
                                                        loginController
                                                            .etSate.text =
                                                        loginController
                                                            .selectedState
                                                            .stateId!;
                                                        loginController.stateData
                                                            .refresh();
                                                        loginController.cityModel
                                                            .value.data = null;
                                                        loginController
                                                            .selectedCity = null;
                                                        loginController
                                                            .getCityNetworkApi(
                                                            loginController
                                                                .selectedState
                                                                .stateId!);
                                                      },
                                                    )
                                                        : const Center();
                                                  }),
                                                )),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Padding(
                                                padding: EdgeInsets.only(left: 80),
                                                child: Center(
                                                  child: Obx(() {
                                                    if (loginController
                                                        .cityModel.value.data !=
                                                        null) {
                                                      int ind = loginController
                                                          .cityModel.value.data!
                                                          .indexWhere((element) =>
                                                      element.id ==
                                                          GetStorage()
                                                              .read(AppConstant
                                                              .cityId)
                                                              .toString());

                                                      if (ind != -1) {
                                                        loginController.selectedCity =
                                                        loginController.cityModel
                                                            .value.data![ind];
                                                        loginController.etCity.text =
                                                        loginController.cityModel
                                                            .value.data![ind].id!;
                                                      }
                                                    }

                                                    return loginController
                                                        .cityModel.value.data !=
                                                        null
                                                        ? DropdownButton(
                                                      value: loginController
                                                          .selectedCity,
                                                      isExpanded: true,
                                                      underline: Container(
                                                        decoration:
                                                        const BoxDecoration(
                                                          border: Border(
                                                            bottom: BorderSide(
                                                              color: Colors.black,
                                                              width: 1.2,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      icon: const Icon(Icons
                                                          .keyboard_arrow_down),
                                                      items: loginController
                                                          .cityModel.value.data!
                                                          .map((CityDatum items) {
                                                        return DropdownMenuItem(
                                                          value: items,
                                                          child: Text(
                                                            " " +
                                                                items.name
                                                                    .toString(),
                                                            style: subtitleStyle,
                                                          ),
                                                        );
                                                      }).toList(),
                                                      hint: Text(" Select City",
                                                          style: subtitleStyle
                                                              .copyWith(
                                                            color: Colors.grey
                                                                .withOpacity(0.7),
                                                          )),
                                                      onChanged: (newValue) {
                                                        loginController
                                                            .selectedCity =
                                                            newValue;
                                                        loginController
                                                            .etCity.text =
                                                            loginController
                                                                .selectedCity.id;
                                                        loginController.cityModel
                                                            .refresh();
                                                      },
                                                    )
                                                        : const Center();
                                                  }),
                                                )),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        children: [
                                          /* MaterialButton(onPressed: ()
                                  {
                                    //editInterestBottomSheet();
                                  },
                                    color: Colors.transparent.withOpacity(0.0),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                                    child: Text("Edit Interest",style:smallTextStyle.copyWith(fontWeight: FontWeight.w500) ,),),*/

                                          Spacer(),
                                          Container(child: CircularButton(onPress: ()
                                          {
                                            if (loginController.formKey.currentState!
                                                .validate()) {
                                              loginController.signUpProfileImgNetworkApi();
                                              controller.getgetUserDetailsNetworkApi();
                                              Get.back();

                                            }
                                          })),
                                          /*  CircleAvatar(
                           radius: 35,
                           child:  Image.asset('assets/images/profile.png',
                           ),),*/
                                        ],
                                      )
                                    ],
                                  ),
                                )),

                          ],
                        ),
                      )),
                )),
          );
        });
  }
}
