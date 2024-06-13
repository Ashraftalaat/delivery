import 'package:delivery/core/class/statusrequest.dart';
import 'package:delivery/core/constant/routs.dart';
import 'package:delivery/core/function/handlingdata.dart';
import 'package:delivery/core/services/serviceslocal.dart';
import 'package:delivery/data/datasource/remote/auth/login_data.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

abstract class LoginController extends GetxController {
  login();
  gotoSignUp();
  gotoforgetpassword();
}

class LoginControllerImp extends LoginController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  LoginData loginData = LoginData(Get.find());

  late TextEditingController email;
  late TextEditingController password;
  late bool isShowpassword = true;

  StatusRequest statusRequest = StatusRequest.none;

  MyServices myServices = Get.find();

  showPassword() {
    isShowpassword = isShowpassword == true ? false : true;
    update();
  }

  @override
  gotoSignUp() {
    Get.toNamed(AppNamesRouts.signUp);
  }

  @override
  login() async {
    var formdata = formstate.currentState;
    if (formdata!.validate()) {
      // اولا التحميل بياخد وقت
      statusRequest = StatusRequest.loading;
      update();
      //postData() الموجودة في مجلد data
      var response = await loginData.postData(email.text, password.text);
      print("==================== controllr $response");
      // handlingData هتحدد نتيجة StatusRequest
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          if (response['data']['delivery_approve'] == 1) {
            myServices.sharedPreferences
                .setString("id", response['data']['delivery_id'].toString());
            String usersid =
                myServices.sharedPreferences.getString("id").toString();
            myServices.sharedPreferences.setString(
                "username", response['data']['delivery_name'].toString());
            myServices.sharedPreferences
                .setString("email", response['data']['delivery_email'].toString());
            myServices.sharedPreferences
                .setString("phone", response['data']['delivery_phone'].toString());
            myServices.sharedPreferences.setString("step", "2");

            // اشعار لمستخدم واحد
            FirebaseMessaging.instance.subscribeToTopic("delivery$usersid");
            // اشعار لكل المستخدمين
            FirebaseMessaging.instance.subscribeToTopic("delivery");

            Get.offNamed(AppNamesRouts.homescreen);
          } else {
            Get.toNamed(AppNamesRouts.verifycodesignup,
                arguments: {"email": email.text});
          }
        } else {
          Get.defaultDialog(
              title: "Warning", middleText: "Password Or Email Not Correct");
          // لو مفيش بيانات
          statusRequest = StatusRequest.failure;
        }
      }
      update();
    } else {}
  }

  @override
  void onInit() {
    FirebaseMessaging.instance.getToken().then((value) {
      print(value);
      String? token = value;
    });
    email = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  gotoforgetpassword() {
    Get.toNamed(AppNamesRouts.forgetpassword);
  }
}
