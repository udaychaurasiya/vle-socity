import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';
import 'package:timeago/timeago.dart';
import 'package:vlesociety/AppConstant/textStyle.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../../AppConstant/AppConstant.dart';
import '../../../AppConstant/textStyle.dart';

import '../../controller/quize_controller.dart';
import '../dashboard.dart';
import 'QuestionHistory.dart';

class Supershowresult extends StatefulWidget {
  final String ttCorrect;
  final String ttInCorrect;
  final String quize_id;
  final List<String> selectedAnsList;

  const Supershowresult(this.selectedAnsList,
      {Key? key, required this.ttCorrect, required this.ttInCorrect, required this.quize_id})
      : super(key: key);

  @override
  State<Supershowresult> createState() => _SupershowresultState();
}

class _SupershowresultState extends State<Supershowresult> {
  late QuizeController controller;
  double _gifPlaybackSpeed = 2.0;

  @override
  void initState() {
    controller = Get.put(QuizeController(quizeId: widget.quize_id));
    controller.getQuizqNetworkApi();
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    print("dsjghkdjfmjdjfh" + widget.quize_id);
    print("gtftdu8gy ${int.parse(widget.ttCorrect.toString())}");
    print("gtftdu8gy ${int.parse(widget.ttCorrect.toString()) >= 3}");
    return Scaffold(

      body:Obx(()=>controller.quizqModel.value.data!=null?
          Column(
            children: [
              int.parse(widget.ttCorrect.toString()) >= int.parse(controller.quizqModel.value.data!.noOfQuestion.toString())/2
                  ?Stack(
                children: [
                  Positioned(
                      top: -60,
                      right: 50,
                      child: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xffcdf55a),

                        ),
                      )
                  ),

                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                    child: Center(
                      child: Container(

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 50.h,),
                            Row(
                              children: [
                               Padding(
                                 padding:  EdgeInsets.only(left: 8.w),
                                 child: IconButton(onPressed: (){
                                   Get.off(HomeDashboard());
                                 }, icon: Icon(Icons.clear)),
                               )
                              ],
                            ),
                            SizedBox(height: 70.h,),
                            Text("Congratulations !",
                                style: subtitleStyle.copyWith(fontSize: 26)),
                            SizedBox(height: 10.h,),
                            Container(
                              height: 150.h,
                              width: Get.width,
                              color: Colors.transparent,
                              child: Image.asset("assets/images/vhh.gif",gaplessPlayback: true),
                            ),
                            // Text(
                            //   "You have successfully completed", style: subtitleStyle,),
                            SizedBox(height: 20,),
                            Text("आपने स्कोर किया !",style: TextStyle(fontWeight: FontWeight.bold),),
                            Obx(()=>controller.quizqModel.value.data!=null?
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text( widget.ttCorrect+"/"+controller.quizqModel.value.data!.noOfQuestion.toString(),style: TextStyle(fontSize: 30.sp,fontWeight: FontWeight.bold),)
                              ],
                            ):Container()
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     TextButton(onPressed: () {},
                            //         child: Row(
                            //           children: [
                            //             Icon(Icons.check, color: Colors.green.shade600,
                            //                 size: 19),
                            //             Text(" ${widget.ttCorrect} Correct",
                            //               style: smallTextStyle,),
                            //           ],
                            //         ), style: ButtonStyle(padding: MaterialStateProperty
                            //             .all(EdgeInsets.all(8)),
                            //           backgroundColor: MaterialStateProperty.all(
                            //               Colors.grey.shade200),
                            //           shape: MaterialStateProperty.all<
                            //               RoundedRectangleBorder>(
                            //             RoundedRectangleBorder(
                            //               borderRadius: BorderRadius.circular(30.0),
                            //             ),),
                            //         )),
                            //     SizedBox(width: 20,),
                            //     TextButton(onPressed: () {},
                            //         child: Row(
                            //           children: [
                            //             Icon(Icons.close, color: Colors.red, size: 19,),
                            //             Text(" ${widget.ttInCorrect} Incorrect",
                            //               style: smallTextStyle,),
                            //           ],
                            //         ), style: ButtonStyle(padding: MaterialStateProperty
                            //             .all(EdgeInsets.all(8)),
                            //           backgroundColor: MaterialStateProperty.all(
                            //               Colors.grey.shade200),
                            //           shape: MaterialStateProperty.all<
                            //               RoundedRectangleBorder>(
                            //             RoundedRectangleBorder(
                            //               borderRadius: BorderRadius.circular(30.0),
                            //             ),),
                            //         )),
                            //   ],
                            // ),
                            SizedBox(
                              height: 30.h,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.orange,
                                  elevation: 0,
                                 /* shape: BeveledRectangleBorder(side: BorderSide(
                                      color: Colors.white),
                                      borderRadius: BorderRadius.circular(4))*/
                              ),
                              onPressed: ()
                               {
                                 generatePDF();
                              }
                              , child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(13.0),
                                  child: Text("Share Certificate", style:TextStyle(
                                      fontWeight: FontWeight.bold,letterSpacing:1,color: Colors.white),),
                                ),
                                Container(
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.6,
                                  decoration: BoxDecoration(
                                  ),
                                )
                              ],
                            ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.orange,
                                  elevation: 0,
                                 /* shape: BeveledRectangleBorder(side: BorderSide(
                                      color: Colors.black),
                                      borderRadius: BorderRadius.circular(4))*/
                              ),
                              onPressed: () {
                                print("jkdsfhhjg" + widget.selectedAnsList.toString());
                                Get.to(QuestionHistory(widget.quize_id, widget
                                    .selectedAnsList));
                              }, child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(13.0),
                                  child: Text("Show Result",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,letterSpacing:1,color: Colors.white),),
                                ),
                                Container(
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.6,
                                  decoration: BoxDecoration(
                                  ),
                                )
                              ],
                            ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.orange,
                                  elevation: 0,
                                 /* shape: BeveledRectangleBorder(side: BorderSide(
                                      color: Colors.black),
                                      borderRadius: BorderRadius.circular(4))*/
                              ),
                              onPressed: ()
                              {
                                Get.off(HomeDashboard());

                              }, child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(13.0),
                                  child: Text("Attempt New Quiz",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,letterSpacing:1,color: Colors.white),),
                                ),
                                Container(
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.6,
                                  decoration: BoxDecoration(
                                  ),
                                )
                              ],
                            ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    top: 100,
                    left: 0,
                    right: 0,
                    child: Lottie.asset('assets/json/confetti.json',
                        repeat: false,
                        frameRate: FrameRate.max
                        , fit: BoxFit.fill),
                  )
                ],
              ) :
              Stack(
                children: [
                  Positioned(
                      top: -60,
                      right: 50,
                      child: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xffcdf55a),

                        ),
                      )
                  ),
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                    child: Center(
                      child: Container(

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 50.h,),
                            Padding(
                              padding:  EdgeInsets.only(left:8.w),
                              child: Row(
                                children: [
                                  IconButton(onPressed: (){
                                    Get.off(HomeDashboard());
                                  }, icon: Icon(Icons.clear,size: 25.sp,))
                                ],
                              ),
                            ),
                            SizedBox(height: 70.h,),
                            Text("Do not cry !",
                                style: subtitleStyle.copyWith(fontSize: 26)),
                            SizedBox(height: 10.h,),
                            Container(
                              height: 130.h,
                              width: Get.width,
                              child: Image.asset("assets/images/sad2.gif",gaplessPlayback: true,),
                            ),
                            // Text(
                            //   "You have successfully completed", style: subtitleStyle,),
                            SizedBox(height: 20.h,),
                            Text("आपने स्कोर किया ! ",style: TextStyle(fontWeight: FontWeight.bold),),
                            Obx(()=>controller.quizqModel.value.data!=null?
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text( widget.ttCorrect+"/"+controller.quizqModel.value.data!.noOfQuestion.toString(),style: TextStyle(fontSize: 30.sp,fontWeight: FontWeight.bold),)
                              ],
                            ):Container()
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     TextButton(onPressed: () {},
                            //         child: Row(
                            //           children: [
                            //             Icon(Icons.check, color: Colors.green.shade600,
                            //                 size: 19),
                            //             Text(" ${widget.ttCorrect} Correct",
                            //               style: smallTextStyle,),
                            //           ],
                            //         ), style: ButtonStyle(padding: MaterialStateProperty
                            //             .all(EdgeInsets.all(8)),
                            //           backgroundColor: MaterialStateProperty.all(
                            //               Colors.grey.shade200),
                            //           shape: MaterialStateProperty.all<
                            //               RoundedRectangleBorder>(
                            //             RoundedRectangleBorder(
                            //               borderRadius: BorderRadius.circular(30.0),
                            //             ),),
                            //         )),
                            //     SizedBox(width: 20,),
                            //     TextButton(onPressed: () {},
                            //         child: Row(
                            //           children: [
                            //             Icon(Icons.close, color: Colors.red, size: 19,),
                            //             Text(" ${widget.ttInCorrect} Incorrect",
                            //               style: smallTextStyle,),
                            //           ],
                            //         ), style: ButtonStyle(padding: MaterialStateProperty
                            //             .all(EdgeInsets.all(8)),
                            //           backgroundColor: MaterialStateProperty.all(
                            //               Colors.grey.shade200),
                            //           shape: MaterialStateProperty.all<
                            //               RoundedRectangleBorder>(
                            //             RoundedRectangleBorder(
                            //               borderRadius: BorderRadius.circular(30.0),
                            //             ),),
                            //         )),
                            //   ],
                            // ),
                            SizedBox(
                              height: 30,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.orange,
                                  elevation: 0,
                              ),
                              onPressed: ()
                               {
                                 showDialog(
                                   context: context,
                                   builder: (BuildContext context) {
                                     return AlertDialog(
                                       content:Container(
                                         height: 250.h,
                                         child: Column(
                                           crossAxisAlignment: CrossAxisAlignment.center,
                                           mainAxisAlignment: MainAxisAlignment.center,
                                           children: [
                                            Container(
                                              height: 100.h,
                                              child: Image.asset("assets/images/luck.png",color: Colors.blue,),
                                            ),
                                             SizedBox(height: 20.h,),
                                             Text("Better luck next time!",style:bodyText2Style.copyWith(fontSize:35.sp),
                                               textAlign: TextAlign.center,),
                                            SizedBox(height: 15.h,),
                                             Row(
                                               children: [
                                                 InkWell(
                                                   onTap:(){
                                                   Get.back();
                                                   },
                                                   child: Container(
                                                     height: 35.h,
                                                     width: 110.w,
                                                     decoration: BoxDecoration(
                                                       color: Colors.green,
                                                       borderRadius: BorderRadius.circular(20.r),
                                                     ),
                                                     child: Center(child: Text("Cancel",style: bodyText2Style.copyWith(color: Colors.white,fontSize: 12.sp),)),
                                                   ),
                                                 ),
                                                 Spacer(),
                                                 InkWell(
                                                   onTap:(){
                                                     Get.off(HomeDashboard());
                                                   },
                                                   child: Container(
                                                     padding: EdgeInsets.only(left: 5,right: 5),
                                                     height: 35.h,
                                                     width: 110.w,
                                                     decoration: BoxDecoration(
                                                       color: Colors.red,
                                                       borderRadius: BorderRadius.circular(20.r),
                                                     ),
                                                     child: Center(child: Text("Attempt Quiz",style: bodyText2Style.copyWith(color: Colors.white,fontSize: 12.sp),)),
                                                   ),
                                                 ),
                                               ],
                                             )
                                           ],
                                         ),
                                       ),
                                     );
                                   },
                                 );
                              }
                              , child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(13.0),
                                  child: Text("Share Certificate",style:TextStyle(
                                      fontWeight: FontWeight.bold,letterSpacing:1,color: Colors.white),),
                                ),
                                Container(
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.6,
                                  decoration: BoxDecoration(
                                  ),
                                )
                              ],
                            ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.orange,
                                  elevation: 0,
                                 /* shape: BeveledRectangleBorder(side: BorderSide(
                                      color: Colors.black),
                                      borderRadius: BorderRadius.circular(4))*/
                              ),
                              onPressed: () {
                                print("jkdsfhhjg" + widget.selectedAnsList.toString());
                                Get.to(QuestionHistory(widget.quize_id, widget
                                    .selectedAnsList));
                              }, child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(13.0),
                                  child: Text("Show Result",
                                    style:TextStyle(
                                        fontWeight: FontWeight.bold,letterSpacing:1,color: Colors.white),),
                                ),
                                Container(
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.6,
                                  decoration: BoxDecoration(
                                  ),
                                )
                              ],
                            ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.orange,
                                  elevation: 0,
                                  /*shape: BeveledRectangleBorder(side: BorderSide(
                                      color: Colors.black),
                                      borderRadius: BorderRadius.circular(4))*/
                              ),
                              onPressed: ()
                              {
                                Get.off(HomeDashboard());

                              }, child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(13.0),
                                  child: Text("Attempt New Quiz",
                                    style:TextStyle(
                                        fontWeight: FontWeight.bold,letterSpacing:1,color: Colors.white),),
                                ),
                                Container(
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.6,
                                  decoration: BoxDecoration(
                                  ),
                                )
                              ],
                            ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    top: 100,
                    left: 0,
                    right: 0,
                    child: Lottie.asset('assets/json/confetti.json',
                        repeat: false,
                        frameRate: FrameRate.max
                        , fit: BoxFit.fill),
                  )
                ],
              )
            ],
          ):Container()
      ),
    );
  }

  Future<dynamic>  generatePdf()async
  {

    var result = await Printing.layoutPdf(onLayout: (format) => buildPdf(format));
    return result;
  }


  Future<Uint8List> buildPdf(PdfPageFormat format) async
  {
    // Create the Pdf document
    final pw.Document doc = pw.Document();
    final directory = await getTemporaryDirectory();
    final file = File('${directory.path}/my_goal.pdf');

    doc.addPage(
      pw.Page(

        margin: const pw.EdgeInsets.all(10),
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context)
        {
          return pw.Column(

              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [

                pw.Container(
                    margin: pw.EdgeInsets.only(left: 15,right: 15,top: 20),
                    child: pw.Row(
                        children: [
                          pw.Text("Name : ${"Uday"}"),
                          pw.SizedBox(width: 10),
                          pw.Text("Total correct Answer : ${widget.ttCorrect}"),
                          pw.SizedBox(width: 10),
                          pw.Text("Total Incorrect Answer :  ${widget.ttInCorrect}")
                        ]
                    )
                ),

                pw.ListView.builder(itemBuilder: (context,index)
                {
                  final data= controller.quizqModel.value.data!.questionList![index];
                  return pw.
                  Container(
                    margin: pw.EdgeInsets.only(left: 15,right: 15,top: 20),
                    child: pw.Column
                      (

                      children:
                      [

                        pw.Padding
                          (

                            padding: pw.EdgeInsets.only(right: 0),
                            child:pw.Text("Q.${index+1} "+data.question.toString(),textAlign: pw.TextAlign.center,style: pw.TextStyle(
                                color: PdfColors.tealAccent400,
                                fontSize: 16,
                                letterSpacing: 1.5,height: 1.2
                            ))
                        ),
                        pw.SizedBox(height: 10,),
                        pw.Padding(
                          padding:pw.EdgeInsets.only(left: 0,top: 0,bottom: 5),
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children:
                            [
                              pw.Text("1. "+data.optA.toString(),style: pw.TextStyle(color:data.answer.toString().contains("A")
                                  ?PdfColors.green:PdfColors.black,
                                  fontSize: 16
                              ) ),
                              pw.Text("2. "+data.optB.toString(),style: pw.TextStyle(color:data.answer.toString().contains("B")
                                  ?PdfColors.green:PdfColors.black,
                                  fontSize: 16
                              )
                              ),
                              pw.Text("3. "+data.optC.toString(),style: pw.TextStyle(color:data.answer.toString().contains("C")
                                  ?PdfColors.green:PdfColors.black,
                                  fontSize: 16
                              ) ),
                              pw.Text("4. "+data.optD.toString(),style: pw.TextStyle(color:data.answer.toString().contains("D")
                                  ?PdfColors.green:PdfColors.black,
                                  fontSize: 16
                              ) ),



                            ],
                          ),


                        )


                      ],
                    ),
                  );
                },
                    itemCount: controller.quizqModel.value.data!.questionList!.length

                )
              ]
          );



        },
      ),
    );
    await file.writeAsBytes(await doc.save());

    await Share.shareFiles(
      [file.path],
      text: 'Check out my goal details',
      subject: 'My goal details',
    );



    return await doc.save();
  }


  Future<void> generatePDF() async {
    final pdf = pw.Document();
    final ByteData bytes = await rootBundle.load('assets/images/certificate.jpg');
    final Uint8List byteList = bytes.buffer.asUint8List();
    var font = await PdfGoogleFonts.arizoniaRegular();
    print(byteList);
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4.landscape,
        build: (context) {
          return pw.Stack(
            children: [
              pw.Container(
                decoration: pw.BoxDecoration(
                  image: pw.DecorationImage(
                    image: pw.MemoryImage(byteList), fit: pw.BoxFit.cover,),
                  ),
                ),
            pw.Center(
                    child:pw.Row(
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      children: [
                        pw.Text(GetStorage().read(AppConstant.userName),
                    style:pw.TextStyle(font:font,color: PdfColors.orange200,fontSize: 45.sp,fontWeight: pw.FontWeight.bold),textAlign: pw.TextAlign.center,)
          ]
          ))
]
          );
        },
      ),
    );
    final output = await getTemporaryDirectory();
    final file = File('${output.path}/Certificate.pdf');
    await file.writeAsBytes(await pdf.save());
    Share.shareFiles([file.path], text: 'Sharing PDF');
  }
}
