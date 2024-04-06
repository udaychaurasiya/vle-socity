import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:vlesociety/Dashboard/view/Earning/Model/FollowingModel.dart';

import '../../../../AppConstant/APIConstant.dart';
import '../../../../AppConstant/AppConstant.dart';
import '../../../../UtilsMethod/BaseController.dart';
import '../../../../UtilsMethod/base_client.dart';
import '../Model/FollowerModel.dart';

class DeatilsController extends GetxController {
  var followModel = FollowersModel(data: []).obs;
  var followingModel = FollowingModel(data: []).obs;
  GetStorage _storage = GetStorage();
  List<FollowingModel> result = [];
  ScrollController scrollController = ScrollController();
  bool loading = true;
  int offset = 0;


  getFollowersApi() async {
    Get.context!.loaderOverlay.show();
    var response = await BaseClient()
        .get(followerlist + "?lng=eng&ID=${_storage.read(AppConstant.id).toString()}&limit=5000&page=0")
        .catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    if (jsonDecode(response)["status"]== 1) {
      followModel.value = followersModelFromJson(response);
      return;
    }
    // BaseController().errorSnack(jsonDecode(response)["message"]);
  }

  getFollowingApi() async {
    var response = await BaseClient()
        .get(followinglist + "?lng=eng&ID=${_storage.read(AppConstant.id)}&limit=5000&page=0")
        .catchError(BaseController().handleError);
    if (jsonDecode(response)["status"]== 1) {
      print(response+"@@@@@@@@@@@@@@@@@@@@@@@@@@");
      followingModel.value = followingModelFromJson(response);
      return;
    }
    // BaseController().errorSnack(jsonDecode(response)["message"]);
  }
}