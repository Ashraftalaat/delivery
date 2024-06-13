// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:delivery/core/class/crud.dart';
import 'package:delivery/linkapi.dart';

class OrdersAcceptedData {
  Crud crud;
  OrdersAcceptedData(this.crud);

  getData(String deliveryid) async {
    //لاستقبال وعرض البيانات فقط
    var response =
        await crud.postdata(AppLinkApi.viewacceptedorders, {"id": deliveryid});
    //fold بترجع 2 parmeter l & r
    return response.fold((l) => l, (r) => r);
  }

  doneDeliveryData(String ordersid, String usersid) async {
    //لاستقبال وعرض البيانات فقط
    var response = await crud.postdata(
        AppLinkApi.doneorders, {"ordersid": ordersid, "usersid": usersid});
    //fold بترجع 2 parmeter l & r
    return response.fold((l) => l, (r) => r);
  }
}
