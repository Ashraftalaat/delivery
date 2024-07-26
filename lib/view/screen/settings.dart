import 'dart:io';

import 'package:delivery/controller/settings_controller.dart';
import 'package:delivery/core/constant/color.dart';
import 'package:delivery/core/constant/imageasset.dart';
import 'package:delivery/core/constant/routs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SettingsController());
    return Scaffold(
        body: GetBuilder<SettingsController>(
      builder: (controller) => ListView(
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Container(
                height: Get.width / 3,
                color: AppColor.primaryColor,
              ),
              Positioned(
                top: Get.width / 3.9,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100)),
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey[200],
                    backgroundImage: const AssetImage(AppImageAsset.avatar),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          ...List.generate(
            controller.data.length,
            (index) => Column(
              children: [
                Center(
                  child: Text(
                    "${controller.data[index].deliveryName}",
                    style: const TextStyle(color: AppColor.primaryColor),
                  ),
                ),
                Center(
                  child: Text(
                    "${controller.data[index].deliveryEmail}",
                    style: const TextStyle(color: AppColor.darkblue),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Card(
            child: Column(
              children: [
                ListTile(
                  title: const Text("Disable Notification"),
                  trailing: Switch(
                      value: controller.status,
                      onChanged: (val) {
                        controller.disableNotification(val);
                      }),
                ),
                const Divider(),
                ListTile(
                  title: const Text("Orders"),
                  leading: const Icon(Icons.card_travel),
                  onTap: () {
                    Get.toNamed(AppNamesRouts.pendingorder);
                  },
                ),
                const Divider(),
                ListTile(
                  title: const Text("Archive"),
                  leading: const Icon(Icons.card_travel),
                  onTap: () {
                    Get.toNamed(AppNamesRouts.archiveorder);
                  },
                ),
               
                const Divider(),
                ListTile(
                  title: const Text("About us"),
                  leading: const Icon(Icons.help_outline_rounded),
                  onTap: () {},
                ),
                const Divider(),
                ListTile(
                  title: const Text("Contact us"),
                  leading: const Icon(Icons.phone_callback_outlined),
                  onTap: () async {
                    launchUrl(Uri.parse("tel:01122449170"));
                  },
                ),
                const Divider(),
                ListTile(
                  title: const Text("Logout"),
                  leading: const Icon(Icons.exit_to_app),
                  onTap: () {
                    Get.defaultDialog(
                      title: "Warnning",
                      titleStyle: const TextStyle(
                          color: AppColor.secondColor,
                          fontWeight: FontWeight.bold),
                      middleText: "Do you Want to Exit The App",
                      middleTextStyle: const TextStyle(color: AppColor.black),
                      onConfirm: () {
                        controller.logout();
                      },
                      confirmTextColor: AppColor.secondColor,
                      onCancel: () {},
                      cancelTextColor: AppColor.secondColor,
                      buttonColor: AppColor.thirdColor);
                  // alertExitApp();
                   // controller.logout();
                  },
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
