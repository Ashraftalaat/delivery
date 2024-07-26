

import 'package:delivery/core/class/statusrequest.dart';
import 'package:delivery/core/constant/routs.dart';
import 'package:delivery/core/function/handlingdata.dart';
import 'package:delivery/core/services/serviceslocal.dart';
import 'package:delivery/data/datasource/remote/delivery_data.dart';
import 'package:delivery/data/model/delivery.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  bool status = true;
  MyServices myServices = Get.find();
  DeliveryData deliveryData = DeliveryData(Get.find());
  // لتخزين الداتا اللي هتيجي من Backend
  List<DeliveryModel> data = [];
  late StatusRequest statusRequest;

  getData() async {
    // اولا التحميل بياخد وقت
    statusRequest = StatusRequest.loading;
    //getData() الموجودة في مجلد data
    var response =
        await deliveryData.getData(myServices.sharedPreferences.getString("id")!);
    print("==================== controllr $response");
    // handlingData هتحدد نتيجة StatusRequest
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        List listdata = response['data'];
        data.addAll(listdata.map((e) => DeliveryModel.fromJson(e)));
        // // لو نجح ضيف كل البيانات اللي رجعت
        // data.addAll(response['data']);
      } else {
        // لو مفيش بيانات
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

// onInit مثل inistate
  @override
  void onInit() {
    getData();
   
    super.onInit();
  }

  logout() {

    String usersid = myServices.sharedPreferences.getString("id").toString();
    FirebaseMessaging.instance.unsubscribeFromTopic("users");
    FirebaseMessaging.instance.unsubscribeFromTopic("users$usersid");
    myServices.sharedPreferences.clear();
    Get.offAllNamed(AppNamesRouts.login);
  }

  disableNotification(bool val) {
    status = val;
    if (val == false) {
      String usersid = myServices.sharedPreferences.getString("id").toString();
      FirebaseMessaging.instance.unsubscribeFromTopic("delivery");
      FirebaseMessaging.instance.unsubscribeFromTopic("delivery$usersid");
    }
    print(val);
    update();
  }
}
