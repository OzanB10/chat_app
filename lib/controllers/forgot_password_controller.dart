import 'package:chat_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  final AuthService _authService = AuthService();
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final RxBool _isloading = false.obs;
  final RxString _error = ''.obs;
  final RxBool _emailSent = false.obs;

  bool get isLoading => _isloading.value;
  String get error => _error.value;
  bool get emailSent => _emailSent.value;

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }


  Future<void> sendPasswordResetEmail() async {
    if(!formkey.currentState!.validate()) return;
    try {
      _isloading.value = true;
      _error.value = '';

      await _authService.sendPasswordResetEmail(emailController.text.trim());

      _emailSent.value = true;
      Get.snackbar('Success', 'Password reset email sent to ${emailController.text}',
      backgroundColor: Colors.green.withOpacity(0.1),
      colorText: Colors.green,
      duration: const Duration(seconds: 3),
      );
} catch (e) {

_error.value = e.toString();
Get.snackbar('Error', 'Failed to send password reset email',
backgroundColor: Colors.red.withOpacity(0.1),
colorText: Colors.red,
duration: const Duration(seconds: 3),
);
} finally {
  _isloading.value = false;
}
  }

  void goBackToLogin() {
    Get.back();
  }

  void resendEmail() {
    _emailSent.value = false;
    sendPasswordResetEmail();
  }

  String? validateEmail(String? value) {
    if(value?.isEmpty ?? true) {
      return 'Please enter your email';
    }
    if(!GetUtils.isEmail(value!)) {
      return 'Please enter a valid email';
    }
    return null;
  }
  void clearError() {
    _error.value = '';
  }
}
