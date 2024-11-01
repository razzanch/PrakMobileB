import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/githubtest_controller.dart';

class GithubtestView extends GetView<GithubtestController> {
  const GithubtestView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GithubtestView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'GithubtestView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
