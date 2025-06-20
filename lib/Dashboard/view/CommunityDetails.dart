import 'dart:math';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vlesociety/AppConstant/AppConstant.dart';
import 'package:vlesociety/Dashboard/view/profile.dart';
import 'package:vlesociety/Dashboard/view/profile/tawk_widget.dart';
import 'package:vlesociety/Dashboard/view/profile/testimonials.dart';

import '../../AppConstant/APIConstant.dart';
import '../../AppConstant/textStyle.dart';
import '../../Widget/CustomAppBarWidget.dart';
import '../controller/CommunityDetails.dart';
import '../controller/DashboardController.dart';
import 'GallaryCommunity.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommunityDetails extends StatefulWidget {
  final String cid;
  const CommunityDetails({Key? key, required this.cid}) : super(key: key);

  @override
  State<CommunityDetails> createState() => _CommunityDetailsState();
  }

class _CommunityDetailsState extends State<CommunityDetails>
{
  late  CommunityDetailsController controller;
  DashboardController controller1 = Get.put(DashboardController());
  @override
  void initState() {
    controller=Get.put(CommunityDetailsController(cid: widget.cid));
    // TODO: implement initState
    super.initState();
  }
  String dataUrlValue="";
  @override
  Widget build(BuildContext context){
    int count;
    return  Scaffold(
      appBar: PreferredSize(
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
            ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: AppBar(
                  backgroundColor: Colors.white.withOpacity(0.5),
                  leading: Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: InkWell(
                      onTap: (){
                        Get.to(Profile());
                          },
                      child: CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.amber.withOpacity(0.1),
                        backgroundImage:
                        NetworkImage(BASE_URL + controller1.image),
                      ),
                    ),
                  ),
                  leadingWidth: 60,
                  title:
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller1.userName.toString(),
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      Text(
                        controller1.points.toString()+" Points",
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
                      constraints: BoxConstraints(maxHeight: 40, minWidth: 40),
                      onPressed: ()
                      {
                        Navigator.pop(context, true);
                      },

                      shape: CircleBorder(

                      ),
                      child: Image.asset(
                        "assets/images/back.png",
                        height: 40,
                        width: 40,
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
      body:Obx(()=> controller.communityModel.value.data!=null?Container
        (
          padding: EdgeInsets.all(10),
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children:
              [

                if (controller.communityModel.value.data!.imageList!.isNotEmpty)

                  controller.communityModel.value.data!.imageList!.length>=3?
                  InkWell(
                    onTap: (){
                      final data= controller.communityModel.value.data!;
                      Get.to(GalleryPage(cid:data.id.toString(),));
                    },
                    child: Container(
                        decoration: BoxDecoration(),
                        width: double.infinity,
                        height: 200,
                        child:
                        StaggeredGrid.count(crossAxisCount: 4,
                          mainAxisSpacing: 4,
                          crossAxisSpacing: 4,
                          children: [
                            StaggeredGridTile.count(
                              crossAxisCellCount: 3,
                              mainAxisCellCount: 3,
                              child: CachedNetworkImage(

                                fit: BoxFit.fill,
                                imageUrl: BASE_URL +controller.communityModel.value.data!.imageList![0].image!,
                                placeholder: (context, url) =>Center(child: const CircularProgressIndicator()),
                                errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                              ),
                            ),
                            StaggeredGridTile.count(
                              crossAxisCellCount: 1,
                              mainAxisCellCount: 1.2,
                              child:  CachedNetworkImage(
                                fit: BoxFit.fill,
                                imageUrl: BASE_URL +controller.communityModel.value.data!.imageList![1].image!,
                                placeholder: (context, url) =>Center(child: const CircularProgressIndicator()),
                                errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                              ),
                            ),
                            Stack(
                                children:[
                                  StaggeredGridTile.count(
                                    crossAxisCellCount: 1,
                                    mainAxisCellCount: 1.2,
                                    child:
                                    CachedNetworkImage
                                      (
                                      fit: BoxFit.fill,
                                      imageUrl: BASE_URL +controller.communityModel.value.data!.imageList![2].image!,
                                      placeholder: (context, url) =>Center(child: const CircularProgressIndicator()),
                                      errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                    ),
                                  )
                                  ,Padding(
                                    padding: const EdgeInsets.only(top: 28.0),
                                    child: Center(child: TextButton(onPressed: ()
                                    {
                                      final data= controller.communityModel.value.data!;
                                      Get.to(GalleryPage(cid:data.id.toString(),));
                                    },
                                      child:
                                      Text(
                                          ((controller.communityModel.value.data!.imageList!.length)-2).toString()+"+"
                                          ,style: TextStyle(fontSize: 30,fontWeight: FontWeight.w900,
                                          color: Colors.black)
                                      )
                                      ,)
                                    ),
                                  )]
                            ),],)

                    ),
                  ):
                  Container(
                    decoration: BoxDecoration(),
                    height: 200.r,
                    width: Get.width,
                    child:InkWell(
                      onTap: (){
                        final data= controller.communityModel.value.data!;
                        Get.to(GalleryPage(cid:data.id.toString(),));
                      },
                      child: Container(
                        child:
                        CachedNetworkImage
                          (
                          fit: BoxFit.fill,
                          imageUrl: BASE_URL + controller.communityModel.value.data!.imageList![0].image.toString(),
                          placeholder: (context, url) =>Center(child: const CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                        ),
                      ),
                    ),

                  ),



                const SizedBox(
                  height: 10,
                ),
                Container(
                  height:Get.height,
                  width: double.infinity,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(
                          controller.communityModel.value.data!.postCategory.toString(),
                          style: bodyText1Style,
                        ),
                        Column(
                          children: [
                            /*Text(
                              controller.communityModel.value.data!.addDate.toString().split(" ").first,
                              style: smallTextStyle,
                            ),*/
                            Text("Add By :- ",style: bodyText2Style.copyWith(fontSize: 17.sp,),),
                            Text(controller.communityModel.value.data!.addBy.toString(),
                              style: bodyText1Style.copyWith(color: Colors.deepPurple),textAlign: TextAlign.end,
                            ),
                            Text(
                              timeago.format(
                                  DateTime.parse( controller.communityModel.value.data!.addDate.toString().split(" ").first)
                              ),
                              style: smallTextStyle.copyWith(fontWeight: FontWeight.w500, fontSize: 10, color: Colors.black.withOpacity(0.5)),
                            ),
                          ],
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
                        //  dataUrlValue=controller.communityModel.value.data!.description.toString();


                        //  dataUrlValue = dataUrlValue.replaceFirst(RegExp('H'), 'h');
                        controller.communityModel.value.data!.description.toString().contains("Https")?
                        InkWell(
                          onTap: (){
                            Get.to(
                                ChatAd( directChatLink:controller.communityModel.value.data!.description.toString(), title:"",
                                  onLoad: ()
                                  {
                                    print('Hello Tawk!');
                                  },
                                  onLinkTap: (String url)
                                  {
                                    print(url);
                                  },
                                  placeholder: const Center(
                                    child: Text('Loading...'),
                                  ),));
                          },
                          child: Container(
                              child: Column(
                                children: [
                                  Html(
                                      data:controller.communityModel.value.data!.description.toString(),
                                      style: {
                                        "body": Style(
                                            color: Colors.blue,
                                            fontSize: FontSize(18.0),
                                            lineHeight: LineHeight(2),
                                            textAlign: TextAlign.justify
                                        ),
                                        "body ol li, body ul li": Style(
                                          fontSize: FontSize(18.0),

                                          letterSpacing: 1.2,
                                          lineHeight: LineHeight(2),
                                        ),

                                      },
                                      onLinkTap: (String? url,  Map<String,
                                          String> attributes,
                                          element)
                                      async{
                                        await launch(url!);
                                      }
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text("View more...",style: bodyText1Style.copyWith(
                                          color: Colors.blue.shade400,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14)
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        color: Colors.blue,
                                        size: 14,
                                      )

                                    ],
                                  ),
                                ],
                              )
                          ),
                        ):
                        Html(
                            data:controller.communityModel.value.data!.description.toString(),
                            style: {
                              "body": Style(

                                  fontSize: FontSize(18.0),

                                  lineHeight: LineHeight(2),
                                  textAlign: TextAlign.justify
                              ),
                              "body ol li, body ul li": Style(
                                fontSize: FontSize(18.0),
                                letterSpacing: 1.2,
                                lineHeight: LineHeight(2),
                              ),

                            },
                            onLinkTap: (String? url,  Map<String,
                                String> attributes,
                                element)
                            async{
                              await launch(url!);
                            }
                        ),



                      ],
                    ),
                  ),
                ),

                // ListView.separated(itemBuilder: itemBuilder, separatorBuilder: separatorBuilder, itemCount: itemCount)
              ],
            ),
          )):Center(
        child: const CupertinoActivityIndicator(),
      ),
      ),
    );
  }
  imageContainer(imgPath){
    return Image.asset(imgPath,fit: BoxFit.fill,);
  }
}