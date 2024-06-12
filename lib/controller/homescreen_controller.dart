import 'package:delivery/view/screen/home.dart';
import 'package:delivery/view/screen/notification.dart';
import 'package:delivery/view/screen/orders/accepted.dart';
import 'package:delivery/view/screen/orders/pending.dart';
import 'package:delivery/view/screen/test_view.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class HomeScreenController extends GetxController {
  changePage(int i);
}

class HomeScreenControllerImp extends HomeScreenController {
  int currentpage = 0;
  List<Widget> listPage = [
    const OrdersPending(),
     const OrdersAccepted(),
    // const OffersView(),
      const TestView(),
  ];

  List bottonAppBar = [
    {"title": "Pending", "icon": Icons.home},
    {"title": "Accepted", "icon": Icons.add_road_sharp},
   // {"title": "Offers", "icon": Icons.local_offer},
  {"title": "Setting", "icon": Icons.settings},
  ];

  @override
  changePage(int i) {
    currentpage = i;
    update();
  }
}
