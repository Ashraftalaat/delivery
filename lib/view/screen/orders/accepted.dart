import 'package:delivery/controller/orders/accepted_controller.dart';
import 'package:delivery/core/class/handingdataview.dart';
import 'package:delivery/view/widget/orders/orderlistcardaccepted.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrdersAccepted extends StatelessWidget {
  const OrdersAccepted({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OrdersAcceptedController());
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        child: GetBuilder<OrdersAcceptedController>(
          builder: (controller) => HandingDataView(
            statusRequest: controller.statusRequest,
            widget: ListView.builder(
              itemCount: controller.data.length,
              itemBuilder: (context, index) => CardOrderListAccepted(
                listData: controller.data[index],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
