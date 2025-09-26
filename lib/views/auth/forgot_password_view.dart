import 'package:chat_app/controllers/forgot_password_controller.dart';
import 'package:chat_app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgotPasswordController());
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(22),
          child: Form(
            key: controller.formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30),
                Row(
                  children: [
                    IconButton(
                      onPressed: controller.goBackToLogin,
                      icon: Icon(Icons.arrow_back_ios_new_rounded),
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Forgot Password',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Padding(
                  padding: EdgeInsets.only(left: 56),
                  child: Text(
                    'Enter your email to reset your password link',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.textSecondaryColor,
                    ),
                  ),
                ),
                SizedBox(height: 60),
                Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Icon(
                      Icons.lock_reset_outlined,
                      size: 50,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ),
                SizedBox(height: 60),
                Obx(() {
                  if (controller.emailSent) {
                    return _buildEmailSentContent(controller);
                  } else {
                    return _buildEmailForm(controller);
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailForm(ForgotPasswordController controller) {
    return Column(
      children: [
        TextFormField(
          controller: controller.emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'Email',
            prefixIcon: Icon(Icons.email_outlined),
            hintText: 'Enter your email',
          ),
          validator: controller.validateEmail,
        ),
        SizedBox(height: 24),
        Obx(
          () => SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed:
                  controller.isLoading
                      ? null
                      : controller.sendPasswordResetEmail,
              icon:
                  controller.isLoading
                      ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                      : Icon(Icons.send),
              label: Text(
                controller.isLoading ? 'Sending...' : 'Send Reset Link',
              ),
            ),
          ),
        ),
        SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Remember your password?",
              style: Theme.of(Get.context!).textTheme.bodyMedium,
            ),
            SizedBox(width: 10),
            GestureDetector(
              onTap: controller.goBackToLogin,
              child: Text(
                "Sign In",
                style: Theme.of(Get.context!).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildEmailSentContent(ForgotPasswordController controller) {
    return Column(children: [
      Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color:AppTheme.successColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppTheme.successColor.withOpacity(0.3)),
        ),
        child: Column(children: [
          Icon(Icons.mark_email_read_rounded,
          size: 50,
          color: AppTheme.successColor,
          ),
          SizedBox(height: 16),
          Text("Email Sent!",
          style: Theme.of(Get.context!).textTheme.headlineSmall?.copyWith(
            color: AppTheme.successColor,
            fontWeight: FontWeight.bold,
          ),
          ),
          SizedBox(height: 8),
          Text("We\'ve sent a password reset link to your email.",
          style: Theme.of(Get.context!).textTheme.bodyMedium?.copyWith(
            color: AppTheme.textSecondaryColor,
            fontWeight: FontWeight.normal,
          ),
          textAlign: TextAlign.center,
          ),
          SizedBox(height: 4),
          Text(controller.emailController.text,
          style:Theme.of(Get.context!).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppTheme.primaryColor,
          )
          ),
          SizedBox(height: 12),
          Text('Check your email and follow the instructions to reset your password.',
          style: Theme.of(Get.context!).textTheme.bodyMedium?.copyWith(
            color: AppTheme.textSecondaryColor,
            fontWeight: FontWeight.normal,
          ),
          textAlign: TextAlign.center,
          ),
        ],
      )
      ),
      SizedBox(height: 32),
      SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: controller.resendEmail,
        label: Text('Resend Email',),
        icon: Icon(Icons.refresh,
        ),
      ),
      ),
      SizedBox(height: 16),
        SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: controller.goBackToLogin,
        label: Text('Back to Login',),
        icon: Icon(Icons.arrow_back_ios_new_rounded,
        ),
      ),
      ),
      SizedBox(height: 24),
      Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppTheme.secondaryColor.withOpacity(0.1),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline,
            size: 24,
          color: AppTheme.primaryColor,
          ),
          SizedBox(width: 12),
          Expanded(child: Text(
            "Didn't receive the email? Check your spam folder or try again.",
            style: Theme.of(Get.context!).textTheme.bodySmall?.copyWith(
              color: AppTheme.secondaryColor
          ))
          )
        ],
      ),
      )
    ]
    );
  }
}
