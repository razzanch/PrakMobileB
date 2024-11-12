import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Picker'),
        elevation: 4,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildImageSection(),
              const SizedBox(height: 20),
              _buildImagePickerButtons(),
              const SizedBox(height: 20),
              const Divider(color: Colors.grey),
              _buildVideoSection(),
              _buildVideoPickerButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return SizedBox(
      height: Get.height / 2.32,
      width: Get.width * 0.7,
      child: Obx(
        () {
          if (controller.isImageLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (controller.selectedImagePath.isEmpty) {
            return const Center(
              child: Text('No image selected'),
            );
          }

          return ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.file(
              File(controller.selectedImagePath.value),
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }

  Widget _buildImagePickerButtons() {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () => controller.pickImage(ImageSource.camera),
          child: const Text('Pick Image from Camera'),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () => controller.pickImage(ImageSource.gallery),
          child: const Text('Pick Image from Gallery'),
        ),
      ],
    );
  }

  Widget _buildVideoSection() {
    return SizedBox(
      height: Get.height / 2.32,
      width: Get.width * 0.7,
      child: Obx(
        () {
          if (controller.selectedVideoPath.value.isEmpty) {
            return const Center(
              child: Text('No video selected'),
            );
          }

          return Card(
            child: Column(
              children: [
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: VideoPlayer(controller.videoPlayerController!),
                  ),
                ),
                VideoProgressIndicator(
                  controller.videoPlayerController!,
                  allowScrubbing: true,
                ),
                _buildVideoControls(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildVideoControls() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Obx(
              () => Icon(
                controller.isVideoPlaying.isTrue
                    ? Icons.pause
                    : Icons.play_arrow,
              ),
            ),
            onPressed: controller.togglePlayPause,
          ),
        ],
      ),
    );
  }

  Widget _buildVideoPickerButtons() {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () => controller.pickVideo(ImageSource.camera),
          child: const Text('Pick Video from Camera'),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () => controller.pickVideo(ImageSource.gallery),
          child: const Text('Pick Video from Gallery'),
        ),
      ],
    );
  }
}