import 'package:get/get.dart';

import '../controllers/widgetbackground_controller.dart';

class WidgetbackgroundBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WidgetbackgroundController>(
      () => WidgetbackgroundController(),
    );
  }
}
