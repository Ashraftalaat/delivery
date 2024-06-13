
import 'package:delivery/core/class/statusrequest.dart';
import 'package:delivery/core/constant/routs.dart';
import 'package:delivery/core/function/handlingdata.dart';
import 'package:delivery/core/services/serviceslocal.dart';
import 'package:delivery/data/datasource/remote/home_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class HomeController extends SearchMixController {
  initialData();
  getdata();
  gotoItems(List categories, int selectedCat, String catid);
}

class HomeControllerImp extends HomeController {
  MyServices myServices = Get.find();
  String? username;
  String? id;
  String? lang;
  String titleHomeCard = "";
  String bodyHomeCard = "";
  String deliveryTime = "";

  HomeData homeData = HomeData(Get.find());
  // لتخزين الداتا اللي هتيجي من Backend
//  List data = [];
  List categories = [];
  List items = [];
  List settingsData = [];

  late StatusRequest statusRequest;

  @override
  initialData() {
    lang = myServices.sharedPreferences.getString("lang");
    username = myServices.sharedPreferences.getString("username");
    id = myServices.sharedPreferences.getString("id");
  }

  // @override
  // void onInit() {
  //  // search = TextEditingController();
  //   // للتجربة ارسال اشعار لكل المستخدمين
  //   // FirebaseMessaging.instance.subscribeToTopic("users");
  //   getdata();
  //   initialData();
  //   super.onInit();
  // }

  @override
  getdata() async {
    // اولا التحميل بياخد وقت
    statusRequest = StatusRequest.loading;
    //getData() الموجودة في مجلد data
    var response = await homeData.getData();
    print("==================== controllr $response");
    // handlingData هتحدد نتيجة StatusRequest
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        // لو نجح ضيف كل البيانات اللي رجعت
        categories.addAll(response['categories']['data']);
        items.addAll(response['items']['data']);
        settingsData.addAll(response['settings']['data']);

        titleHomeCard = settingsData[0]["settings_titlehome"];
        bodyHomeCard = settingsData[0]["settings_bodyhome"];
        deliveryTime = settingsData[0]["settings_deliverytime"].toString();
        myServices.sharedPreferences
            .setString("settings_deliverytime", deliveryTime).toString();
      } else {
        // لو مفيش بيانات
        statusRequest = StatusRequest.failure;
      }
    }
   // update();
  }

  @override
  gotoItems(categories, selectedCat, catid) {
    Get.toNamed(AppNamesRouts.items, arguments: {
      "categories": categories,
      "selectedCat": selectedCat,
      "catid": catid,
    });
  }

  gotoPageItemsDetails(itemsmodel) {
    Get.toNamed(AppNamesRouts.itemsdetails, arguments: {
      "itemsmodel": itemsmodel,
    });
  }
}

 class SearchMixController extends GetxController {
//   late TextEditingController search;
//   List<Itemsmodel> listdata = [];
//   HomeData homeData = HomeData(Get.find());
//   late StatusRequest statusRequest;

//   searchdata() async {
//     // اولا التحميل بياخد وقت
//     statusRequest = StatusRequest.loading;
//     //getData() الموجودة في مجلد data
//     var response = await homeData.searchData(search.text);
//     print("==================== controllr $response");
//     // handlingData هتحدد نتيجة StatusRequest
//     statusRequest = handlingData(response);
//     if (StatusRequest.success == statusRequest) {
//       if (response['status'] == "success") {
//         listdata.clear();
//         // لو نجح ضيف كل البيانات اللي رجعت
//         List responsedata = response['data'];
//         listdata.addAll(responsedata.map((e) => Itemsmodel.fromJson(e)));
//         // items.addAll(response['items']['data']);
//       } else {
//         // لو مفيش بيانات
//         statusRequest = StatusRequest.failure;
//       }
//     }
//     update();
//   }

//   bool isSearch = false;

//   checkSearch(val) {
//     if (val == "") {
//       statusRequest = StatusRequest.none;
//       isSearch = false;
//     }
//     update();
//   }

//   onSearchItems() {
//     isSearch = true;
//     searchdata();
//     update();
//   }
 }
