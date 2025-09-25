import 'package:chat_app/controllers/auth_controller.dart';
import 'package:chat_app/routes/app_routes.dart';
import 'package:chat_app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formkey = GlobalKey<FormState>();
   final _displayNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final AuthController _authController = Get.find<AuthController>();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _displayNameController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formkey,
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Row(
                  children: [
                    IconButton(onPressed: () => Get.back(), icon: Icon(Icons.arrow_back_ios_new_rounded)),
                    SizedBox(width: 12),
                    Text(
                      "Create Account!",
                    style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  "Fill in your details to get started",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.textSecondaryColor,
                  ),
                  ),
                  SizedBox(height: 32),
                  TextFormField(
                    controller: _displayNameController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      labelText: "Display Name",
                      prefixIcon: Icon(Icons.person_outline),
                      hintText: "Enter your Name",
                    ),
                    validator: (value) {
                      if(value?.isEmpty ?? true){
                        return 'Please enter your Name';
                      }
                      
                      return null;
                    }
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Email",
                      prefixIcon: Icon(Icons.email_outlined),
                      hintText: "Enter your email",
                    ),
                    validator: (value) {
                      if(value?.isEmpty ?? true){
                        return 'Please enter your email';
                      }
                      if (!GetUtils.isEmail(value!)){
                        return 'Please enter a valid email';
                      }
                      return null;
                    }
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      labelText: "Password",
                      prefixIcon: Icon(Icons.lock_outline),
                      hintText: "Enter your password",
                      suffixIcon: IconButton(
                        icon: Icon(_obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if(value?.isEmpty ?? true){
                        return 'Please enter your password';
                      }
                     if(value!.length < 6){
                      return 'Password must be at least 6 characters';
                     }
                      return null;
                    }
                  ),
                   SizedBox(height: 16),
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: _obscureConfirmPassword,
                    decoration: InputDecoration(
                      labelText: "Confirm Password",
                      prefixIcon: Icon(Icons.lock_outline),
                      hintText: "Confirm your password",
                      suffixIcon: IconButton(
                        icon: Icon(_obscureConfirmPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                        onPressed: () {
                          setState(() {
                            _obscureConfirmPassword = !_obscureConfirmPassword;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if(value?.isEmpty ?? true){
                      return 'Please confirm your password';
                    }
                    if(value != _passwordController.text){
                      return 'Passwords do not match';
                    }
                      return null;
                    }
                  ),
                  SizedBox(height: 24),
                  Obx(()=>
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _authController.isLoading ? null : () {
                        if(_formkey.currentState?.validate() ?? false){
                          _authController.registerWithEmailAndPassword(
                            _emailController.text.trim(),
                            _passwordController.text,
                            _displayNameController.text,
                          );
                        }
                      },
                      child: _authController.isLoading
                       ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      ) : Text('Create Account'),
                      ),
                    ),
                  ),
                  SizedBox(height: 32),
                  Row(
                    children: [
                      Expanded(child: Divider(color: AppTheme.borderColor)),
                      Padding(padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Or'
                        ),
                      ),
                      Expanded(child: Divider(color: AppTheme.borderColor)),
                    ],
                  ),
                  SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style:Theme.of(context).textTheme.bodyMedium,
                        ),
                        SizedBox(width: 12  ),
                        GestureDetector(onTap: () => Get.toNamed(Approutes.login),
                        child: Text(
                          "Sign In",
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppTheme.primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                          )
                        ),
                    ],
                        ),
                    ],
                  )
                  ),
            ),
          ),
          );
}
}

