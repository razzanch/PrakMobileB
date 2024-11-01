import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/app/modules/login/views/login_view.dart';


class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  RxBool isLoading = false.obs;

  Future<void> registerUser(String email, String password) async {
    try {
      isLoading.value = true;
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      Get.snackbar(
        'Success',
        'Registration successful',
        backgroundColor: Colors.green,
      );
      //Get.off(LoginPage()); // Navigasi ke halaman Login
    } catch (error) {
      Get.snackbar(
        'Error',
        'Registration failed: $error',
        backgroundColor: Colors.red,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Fungsi untuk login pengguna
Future<void> loginUser(String email, String password) async {
  try {
    isLoading.value = true;
    await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    Get.snackbar(
      'Success', 
      'Login successful',
      backgroundColor: Colors.green,
    );
  } catch (error) {
    Get.snackbar(
      'Error', 
      'Login failed: $error',
      backgroundColor: Colors.red,
    );
  } finally {
    isLoading.value = false;
  }
}

void logout() async {
  await _auth.signOut();
  Get.offAll(LoginView()); // Menghapus semua halaman dari stack dankembali ke halaman login.
}


}

