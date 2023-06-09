import 'package:app8/contollers/login_controller.dart';
import 'package:get/get.dart';

class ControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController(), fenix: true);
  }
}
