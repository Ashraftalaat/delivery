import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:delivery/core/class/statusrequest.dart';
import 'package:delivery/core/function/checkinternet.dart';

import 'package:http/http.dart ' as http;

// للتعامل مع request اللي هنرسلهاو نستقبلها من Backend
//c : create  & r : read & u : Update & d : delete
class Crud {
  //function للارسال والاستقبال من Backend
  // Either نستخدمها لجعل الفينكشن تقبل نوعين ترجعهم
  //"left" => StatusRequest & "Right"=> Map
  // لذلك هنستخدم package: dartz اللي هتستخدم البرمجة الوظيفية في dart
  // StatusRequest مهمتهاالتأكد من  نجاح او فشل الاتصال بقاعدة البيانات والنت او اي سبب اخر
  Future<Either<StatusRequest, Map>> postdata(String linkurl, Map data) async {
    //   try {
    if (await checkInternet()) {
      //Uri.parse نوع من التشفير
      var response = await http.post(Uri.parse(linkurl),
          body: data, headers: {"accept": "application/json"});
      print(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 201) {
        //النتيجة اللي هترجع json من نوع map
        Map responsebody = jsonDecode(response.body);
        print(responsebody);
        // النوع الثاني "Map" اللي هترجعه
        return Right(responsebody);
      } else {
        // النوع الاول "StatusRequest" اللي هترجعه
        return const Left(StatusRequest.serverfailure);
      }
    } else {
      return const Left(StatusRequest.offlinefailure);
    }
    // } catch (_) {
    //   return const Left(StatusRequest.serverException);
    // }
  }
}
