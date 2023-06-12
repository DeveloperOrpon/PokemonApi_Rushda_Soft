import 'package:get/get.dart';

import '../Controller/api_controller.dart';
import '../Controller/view_detalis_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiController>(() => ApiController());
    Get.lazyPut<ViewDetailsController>(() => ViewDetailsController());
  }
}
