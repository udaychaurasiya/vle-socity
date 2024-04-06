import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../AppConstant/APIConstant.dart';
import '../../../AppConstant/AppConstant.dart';
import '../../../Widget/CustomAppBarWidget.dart';
import '../../controller/DashboardController.dart';
class MyFortuneWheel extends StatefulWidget {
  @override
  _MyFortuneWheelState createState() => _MyFortuneWheelState();
}

class _MyFortuneWheelState extends State<MyFortuneWheel> {
  StreamController<int> selected = StreamController<int>();
  DashboardController controller = Get.find();
  @override
  void dispose() {
    selected.close();
    super.dispose();
  }
  final items = <String>[
    '10 Point',
    '20 Point',
    '25 Point',
    '27 Point',
    '30 Point',
    '32 Point',
    '35 Point',
    '40 Point',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(
            double.infinity,
            60.0,
          ),
          child: CustomAppBar(
              title: GetStorage().read(AppConstant.userName),
              Points: controller.points,
              image:BASE_URL+GetStorage().read(AppConstant.profileImg)
          )
      ),
      body: GestureDetector(
        onTap: () {
          setState(() {
            selected.add(
              Fortune.randomInt(0, items.length),
            );
          });
        },
        child: Column(
          children: [
            Expanded(
              child: FortuneWheel(
                duration: Duration(seconds: 5),
                selected: selected.stream,
                items: [
                  for (var it in items) FortuneItem(child: Text(it),style: FortuneItemStyle(
                    color: _getItemColor(it),
                  ), ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Color _getItemColor(String itemText) {
    if (itemText == '10 Point') {
      return Colors.blue;
    } else if (itemText == '20 Point') {
      return Colors.orangeAccent;
    } else if (itemText == '25 Point') {
      return Colors.red;
    }else if (itemText == '27 Point') {
      return Colors.orangeAccent;
    } else if (itemText == '30 Point') {
      return Colors.red;
    }else if (itemText == '32 Point') {
      return Colors.orange;
    } else if (itemText == '35 Point') {
      return Colors.amber;
    }
    return Colors.black; // Default color
  }
}