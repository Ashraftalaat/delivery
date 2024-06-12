import 'package:delivery/controller/auth/signup_controller.dart';
import 'package:delivery/core/class/crud.dart';

import 'package:get/get.dart';

class MyBinding extends Bindings {
  @override
  void dependencies() {
    // fenix: true يجب وضعها حتي يمكن ان نستدعي lazyPut اكثر من مرة
    Get.lazyPut(() => SignUpControllerImp(), fenix: true);
    
    Get.put(Crud());
  }
}
