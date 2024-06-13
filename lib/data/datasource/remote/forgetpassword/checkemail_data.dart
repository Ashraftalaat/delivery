// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:delivery/core/class/crud.dart';
import 'package:delivery/linkapi.dart';


class CheckEmailData {
  Crud crud;
  CheckEmailData(this.crud);

  postData(String email) async {
    //لاستقبال او اضافة  وعرض البيانات
    var response = await crud.postdata(AppLinkApi.checkemail, {
      "email": email,
    });
    //fold بترجع 2 parmeter l & r
    return response.fold((l) => l, (r) => r);
  }
}
