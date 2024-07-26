// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:delivery/core/class/crud.dart';
import 'package:delivery/linkapi.dart';


class DeliveryData {
  Crud crud;
  DeliveryData(this.crud);

  getData(String deliveryid) async {
   
    //لاستقبال وعرض البيانات فقط
    var response = await crud.postdata(AppLinkApi.deliveries, {"id": deliveryid});
     //fold بترجع 2 parmeter l & r
    return response.fold((l) => l , (r) => r);
  }
} 
