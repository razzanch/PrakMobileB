import 'dart:io';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class HomeController extends GetxController {
  // Dependencies
  final ImagePicker _picker = ImagePicker();
  final box = GetStorage();

  // Image related variables
  var selectedImagePath = ''.obs;
  var isImageLoading = false.obs;

  // Video related variables
  var selectedVideoPath = ''.obs;
  var isVideoPlaying = false.obs;
  VideoPlayerController? videoPlayerController;

  @override
  void onInit() {
    super.onInit();
    _loadStoredData();
  }

  @override
  void onReady() {
    super.onReady();
    _loadStoredData();
  }

  @override
  void onClose() {
    videoPlayerController?.dispose();
    super.onClose();
  }

  /// Picks an image from the specified source (camera or gallery)
  Future<void> pickImage(ImageSource source) async {
    try {
      isImageLoading.value = true;
      final XFile? pickedFile = await _picker.pickImage(source: source);

      if (pickedFile != null) {
        selectedImagePath.value = pickedFile.path;
        // Store image path in local storage
        box.write('imagePath', pickedFile.path);
      } else {
        print('No image selected.');
      }
    } catch (e) {
      print('Error picking image: $e');
    } finally {
      isImageLoading.value = false;
    }
  }

  /// Picks a video from the specified source (camera or gallery)
  Future<void> pickVideo(ImageSource source) async {
    try {
      isImageLoading.value = true;
      final XFile? pickedFile = await _picker.pickVideo(source: source);

      if (pickedFile != null) {
        selectedVideoPath.value = pickedFile.path;
        box.write('videoPath', pickedFile.path);
        
        await _initializeVideoPlayer(pickedFile.path);
      } else {
        print('No video selected.');
      }
    } catch (e) {
      print('Error picking video: $e');
    } finally {
      isImageLoading.value = false;
    }
  }

  /// Initializes video player with the given video path
  Future<void> _initializeVideoPlayer(String videoPath) async {
    videoPlayerController = VideoPlayerController.file(File(videoPath));
    
    await videoPlayerController!.initialize();
    videoPlayerController!.play();
    isVideoPlaying.value = true;
    update();
  }

  /// Loads stored image and video paths from local storage
  void _loadStoredData() async {
    selectedImagePath.value = box.read('imagePath') ?? '';
    selectedVideoPath.value = box.read('videoPath') ?? '';

    if (selectedVideoPath.value.isNotEmpty) {
      await _initializeVideoPlayer(selectedVideoPath.value);
    }
  }

  /// Video playback control methods
  void play() {
    videoPlayerController?.play();
    isVideoPlaying.value = true;
    update();
  }

  void pause() {
    videoPlayerController?.pause();
    isVideoPlaying.value = false;
    update();
  }

  void togglePlayPause() {
    if (videoPlayerController != null) {
      if (videoPlayerController!.value.isPlaying) {
        pause();
      } else {
        play();
      }
    }
  }
}