import 'package:get/get.dart';

import '../controllers/githubtest_controller.dart';

class GithubtestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GithubtestController>(
      () => GithubtestController(),
    );
  }
}
