import 'package:delivery/controller/orders/tracking_controller.dart';
import 'package:delivery/core/class/handingdataview.dart';
import 'package:delivery/core/constant/color.dart';
import 'package:delivery/core/shared/custombutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OrdersTracking extends StatelessWidget {
  const OrdersTracking({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(TrackingController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders Tracking"),
      ),
      body: Container(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: GetBuilder<TrackingController>(
            builder: (controller) => HandingDataView(
              statusRequest: controller.statusRequest,
              widget: Column(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      width: double.infinity,
                      child: GoogleMap(
                        polylines: controller.polylineset,
                        mapType: MapType.normal,
                        markers: controller.markers.toSet(),
                        initialCameraPosition: controller.cameraPosition!,
                        onMapCreated: (GoogleMapController controllermap) {
                          controller.gmc = controllermap;
                        },
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: MaterialButton(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      height: 40,
                      textColor: AppColor.darkblue,
                      color: AppColor.primaryColor,
                      onPressed: () {
                        controller.donedelivery();
                      },
                      child: const Text("the order has been delivered"),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
