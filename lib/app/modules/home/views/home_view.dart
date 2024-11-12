import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app/routes/app_pages.dart';
import 'package:myapp/app/modules/home/controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HomePage"),
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              switch (value) {
                case 0:
                  Get.toNamed(Routes.GET_CONNECT);
                  break;
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 0,
                child: TextButton(
                  onPressed: null,
                  child: Text("GetConnect Page"),
                ),
              ),
            ],
          ),
        ],
      ),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("HOW TO USE THIS APPLICATION"),
          Text("1. Buka icon titik 3 di pojok kanan atas"),
          Text("2. Pilih Package yang ingin kalian liat sebagai outputnya"),
        ],
      ),
    );
  }
}
