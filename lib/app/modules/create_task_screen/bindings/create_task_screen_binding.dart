import 'package:get/get.dart';

import '../controllers/create_task_screen_controller.dart';

class CreateTaskScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateTaskScreenController>(
      () => CreateTaskScreenController(),
    );
  }
}
