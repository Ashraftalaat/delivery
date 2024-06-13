// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:delivery/controller/home_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListItemsHome extends GetView<HomeControllerImp> {
  const ListItemsHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.only(top: 10),
      height: 140,
      // width: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: controller.items.length,
        itemBuilder: (context, index) {
          return Container();
          // ItemsHome(
          //   itemsmodel: Itemsmodel.fromJson(
          //     controller.items[index],
          //   ),
          // );
        },
      ),
    );
  }
}

// class ItemsHome extends GetView<HomeControllerImp> {
//   final Itemsmodel itemsmodel;
//   const ItemsHome({
//     super.key,
//     required this.itemsmodel,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//        controller.gotoPageItemsDetails(itemsmodel);
//       },
//       child: Stack(
//         children: [
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//             margin: const EdgeInsets.symmetric(horizontal: 10),
//             // margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//             child: Image.network(
//               "${AppLinkApi.imagestitems}/${itemsmodel.itemsImage}",
//               height: 100,
//               width: 150,
//               fit: BoxFit.fill,
//             ),
//           ),
//           Container(
//             height: 120,
//             width: 190,
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20),
//                 color: AppColor.grey.withOpacity(0.5)),
//           ),
//           Positioned(
//             left: 10,
//             child: Text(
//               "${translateDataBase(itemsmodel.itemsNameAr, itemsmodel.itemsName)}",
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 15,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
