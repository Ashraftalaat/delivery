// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:delivery/core/class/crud.dart';
import 'package:delivery/linkapi.dart';


class OrdersPendingData {
  Crud crud;
  OrdersPendingData(this.crud);

  getData() async {
    //لاستقبال وعرض البيانات فقط
    var response =
        await crud.postdata(AppLinkApi.viewpendingorders, {});
    //fold بترجع 2 parmeter l & r
    return response.fold((l) => l, (r) => r);
  }

  approveOrders(String deliveryid,String usersid,String ordersid) async {
    //لاستقبال وعرض البيانات فقط
    var response =
        await crud.postdata(AppLinkApi.approveorders, {"deliveryid" : deliveryid ,"usersid" : usersid,"ordersid" : ordersid});
    //fold بترجع 2 parmeter l & r
    return response.fold((l) => l, (r) => r);
  }
}
