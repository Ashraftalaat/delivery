// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:delivery/core/class/crud.dart';
import 'package:delivery/linkapi.dart';


class OrdersDetailsData {
  Crud crud;
  OrdersDetailsData(this.crud);

  getData(String ordersid) async {
    var response = await crud.postdata(AppLinkApi.detailsorders, {"id": ordersid});

    return response.fold((l) => l, (r) => r);
  }
}
