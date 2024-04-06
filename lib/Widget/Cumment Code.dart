//   Quez Share pdf   // /*  Printing.layoutPdf(
// //                             // [onLayout] will be called multiple times
// //                             // when the user changes the printer or printer settings
// //                               onLayout: (PdfPageFormat format)
// //                               {
// //                                 // Any valid Pdf document can be returned here as a list of int
// //                                 return buildPdf(format);
// //                               }
// //                           );
// //                           var value=generatePdf();*/
// // {
// // // Create the Pdf document
// // final pw.Document doc = pw.Document();
// // final directory = await getTemporaryDirectory();
// // final file = File('${directory.path}/MyResult.pdf');
// //
// // /* doc.addPage(
// //                               pw.MultiPage(
// //
// //                                 margin: const pw.EdgeInsets.all(10),
// //                                 pageFormat: PdfPageFormat.a4,
// //                                 orientation: pw.PageOrientation.portrait,
// //                                 crossAxisAlignment: pw.CrossAxisAlignment.start,
// //
// //                                 build: (pw.Context context)
// //                                 {
// //                                   return <pw.Widget>
// //                                   [
// //                                   pw.Wrap(
// //
// //                                       children: [
// //
// //                                         pw.Container(
// //                                             margin: pw.EdgeInsets.only(left: 15,right: 15,top: 20),
// //                                             child: pw.Row(
// //                                                 children: [
// //                                                   pw.Text("Name : ${GetStorage().read(AppConstant.userName) }"+  +"Total correct Answer : ${widget.ttCorrect}"+"  "+"Total Incorrect Answer :  ${widget.ttInCorrect}"),
// //                                                   pw.SizedBox(width: 10),
// //                                                   pw.Text("Total correct Answer : ${widget.ttCorrect}"),
// //                                                   pw.SizedBox(width: 10),
// //                                                   pw.Text("Total Incorrect Answer :  ${widget.ttInCorrect}")
// //                                                 ]
// //                                             )
// //                                         ),
// //
// //                                         pw.ListView.builder(itemBuilder: (context,index)
// //                                         {
// //                                           final data= controller.quizqModel.value.data!.questionList![index];
// //                                           return pw.
// //                                           Container(
// //                                             margin: pw.EdgeInsets.only(left: 15,right: 15,top: 10),
// //                                             child: pw.Column
// //                                               (
// //
// //                                               children:
// //                                               [
// //
// //                                                 pw.Padding
// //                                                   (
// //
// //                                                     padding: pw.EdgeInsets.only(right: 0),
// //                                                     child:pw.Text("Q.${index+1} "+data.question.toString(),textAlign: pw.TextAlign.center,style: pw.TextStyle(
// //                                                         color: PdfColors.tealAccent400,
// //                                                         fontSize: 16,
// //                                                         letterSpacing: 1.5,height: 1.2
// //                                                     ))
// //                                                 ),
// //                                                 pw.SizedBox(height: 10,),
// //                                                 pw.Padding(
// //                                                   padding:pw.EdgeInsets.only(left: 0,top: 0,bottom: 5),
// //                                                   child: pw.Column(
// //                                                     crossAxisAlignment: pw.CrossAxisAlignment.start,
// //                                                     children:
// //                                                     [
// //                                                       pw.Text("1. "+data.optA.toString(),style: pw.TextStyle(color:data.answer.toString().contains("A")
// //                                                           ?PdfColors.green:PdfColors.black,
// //                                                           fontSize: 16
// //                                                       ) ),
// //                                                       pw.Text("2. "+data.optB.toString(),style: pw.TextStyle(color:data.answer.toString().contains("B")
// //                                                           ?PdfColors.green:PdfColors.black,
// //                                                           fontSize: 16
// //                                                       )
// //                                                       ),
// //                                                       pw.Text("3. "+data.optC.toString(),style: pw.TextStyle(color:data.answer.toString().contains("C")
// //                                                           ?PdfColors.green:PdfColors.black,
// //                                                           fontSize: 16
// //                                                       ) ),
// //                                                       pw.Text("4. "+data.optD.toString(),style: pw.TextStyle(color:data.answer.toString().contains("D")
// //                                                           ?PdfColors.green:PdfColors.black,
// //                                                           fontSize: 16
// //                                                       ) ),
// //
// //
// //
// //                                                     ],
// //                                                   ),
// //
// //
// //                                                 )
// //
// //
// //                                               ],
// //                                             ),
// //                                           );
// //                                         },
// //                                             itemCount: controller.quizqModel.value.data!.questionList!.length
// //
// //                                         )
// //                                       ]
// //                                   ),
// //                                    ];
// //
// //                                 },
// //                               ),
// //                             );*/
// // /*
// //                             await file.writeAsBytes(await doc.save());
// //
// //                         await Share.shareFiles(
// //                         [file.path],
// //                         text: 'Check out my goal details',
// //                         subject: 'My goal details',
// //                         );*/
// //
// //
// //
// // // doc.addPage(
// // //   pw.MultiPage(
// // //     pageFormat: PdfPageFormat.a4,
// // //     orientation: pw.PageOrientation.portrait,
// // //     crossAxisAlignment: pw.CrossAxisAlignment.start,
// // //     build: (pw.Context context)
// // //     {
// // //       return <pw.Widget>
// // //       [
// // //         pw.Wrap(
// // //           children: <pw.Widget>[
// // //             pw.Header(text: "Name :${GetStorage().read(AppConstant.userName) }"
// // //             ),
// // //             pw.Container(
// // //
// // //               width: PdfPageFormat.a4.width,
// // //               child: pw.Row(
// // //                 mainAxisSize: pw.MainAxisSize.min,
// // //                 crossAxisAlignment: pw.CrossAxisAlignment.start,
// // //                 children: <pw.Widget>[
// // //                   pw.Expanded(
// // //                     child: pw.Column(
// // //                       mainAxisSize: pw.MainAxisSize.min,
// // //                       crossAxisAlignment: pw.CrossAxisAlignment.start,
// // //                       children: <pw.Widget>[
// // //                         pw.SizedBox(height: 8.0),
// // //                         for (int i = 0; i < controller.quizqModel.value.data!.questionList!.length; i++)
// // //                           pw.Column(
// // //                             mainAxisSize: pw.MainAxisSize.min,
// // //                             crossAxisAlignment: pw.CrossAxisAlignment.start,
// // //                             children: <pw.Widget>[
// // //                               pw.Padding
// // //                                 (
// // //
// // //                                   padding: pw.EdgeInsets.only(right: 0),
// // //                                   child:pw.Text("${i+1} "+controller.quizqModel.value.data!.questionList![i].question.toString(),style: pw.TextStyle(
// // //                                       color: PdfColors.black,
// // //                                       fontSize: 16,
// // //                                       letterSpacing: 1.5,height: 1.2
// // //                                   ))
// // //                               ),
// // //                               pw.SizedBox(height: 1,),
// // //                               pw.Padding(
// // //                                 padding:pw.EdgeInsets.only(left: 0,top: 0,bottom: 0),
// // //                                 child: pw.Column(
// // //                                   crossAxisAlignment: pw.CrossAxisAlignment.start,
// // //                                   children:
// // //                                   [
// // //                                     pw.Text("1. "+controller.quizqModel.value.data!.questionList![i].optA.toString(),
// // //                                         style: pw.TextStyle(color:controller.quizqModel.value.data!.questionList![i].answer.toString().contains("A")
// // //                                             ?PdfColors.green:PdfColors.black,
// // //                                             fontSize: 10
// // //                                         ) ),
// // //                                     pw.Text("2. "+controller.quizqModel.value.data!.questionList![i].optB.toString(),style: pw.TextStyle(color:controller.quizqModel.value.data!.questionList![i].answer.toString().contains("B")
// // //                                         ?PdfColors.green:PdfColors.black,
// // //                                         fontSize: 10
// // //                                     )
// // //                                     ),
// // //
// // //
// // //                                     pw.Text("3. "+controller.quizqModel.value.data!.questionList![i].optC.toString(),style: pw.TextStyle(color:controller.quizqModel.value.data!.questionList![i].answer.toString().contains("C")
// // //                                         ?PdfColors.green:PdfColors.black,
// // //                                         fontSize: 10
// // //                                     ) ),
// // //                                     pw.Text("4. "+controller.quizqModel.value.data!.questionList![i].optD.toString(),style: pw.TextStyle(color:controller.quizqModel.value.data!.questionList![i].answer.toString().contains("D")
// // //                                         ?PdfColors.green:PdfColors.black,
// // //                                         fontSize: 10
// // //                                     )
// // //                                     ),
// // //
// // //
// // //
// // //                                   ],
// // //                                 ),
// // //
// // //
// // //                               )
// // //
// // //
// // //
// // //                             ],
// // //                           ),
// // //                       ],
// // //                     ),
// // //                   ),
// // //                 ],
// // //               ),
// // //             ),
// // //           ],
// // //         ),
// // //       ];
// // //     },
// // //   ),
// // // );
// //
// // await file.writeAsBytes(await doc.save());
// //
// // await Share.shareFiles(
// // [file.path],
// // text: 'Check out my goal details',
// // subject: 'My goal details',
// // );
// //
// //
// //
// // }