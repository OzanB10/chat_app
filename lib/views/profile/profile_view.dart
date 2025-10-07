import 'package:chat_app/controllers/profile_controller.dart';
import 'package:chat_app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded),
        ),
        actions: [
          Obx(
            () => TextButton(
              onPressed:
                  controller.isEditing
                      ? controller.toggleEditing
                      : controller.toggleEditing,
              child: Text(
                controller.isEditing ? 'Cancel' : 'Edit',
                style: TextStyle(
                  color:
                      controller.isEditing
                          ? AppTheme.errorColor
                          : AppTheme.primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Obx(() {
        final user = controller.currentUser;
        if (user == null) {
          return Center(
            child: CircularProgressIndicator(color: AppTheme.primaryColor),
          );
        }
        return SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Column(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: AppTheme.primaryColor,
                        child:
                            user.photoURL.isNotEmpty
                                ? ClipOval(
                                  child: Image.network(
                                    user.photoURL,
                                    width: 120,
                                    height: 120,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return _buildDefaultAvatar(user);
                                    },
                                  ),
                                )
                                : _buildDefaultAvatar(user),
                      ),
                      if (controller.isEditing)
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppTheme.primaryColor,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: IconButton(
                              onPressed: () {
                                Get.snackbar(
                                  'Info',
                                  'Photo update Coming Soon',
                                );
                              },
                              icon: Icon(
                                Icons.camera_alt_outlined,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 18),
                  Text(
                    user.displayName,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    user.email,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: const Color.fromARGB(255, 51, 49, 49),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 12),
                    decoration: BoxDecoration(
                      color:
                          user.isOnline
                              ? AppTheme.successColor.withOpacity(0.1)
                              : AppTheme.textSecondaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color:
                                user.isOnline
                                    ? AppTheme.successColor
                                    : AppTheme.textSecondaryColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        SizedBox(width: 6),
                        Text(
                          user.isOnline ? 'Online' : 'Offline',
                          style: Theme.of(
                            Get.context!,
                          ).textTheme.bodySmall?.copyWith(
                            color:
                                user.isOnline
                                    ? AppTheme.successColor
                                    : AppTheme.textSecondaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    controller.getJoinedData(),
                    style: Theme.of(Get.context!).textTheme.bodySmall?.copyWith(
                      color: AppTheme.textSecondaryColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Obx(
                () => Card(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text(
                          'Personel Information',
                          style: Theme.of(
                            Get.context!,
                          ).textTheme.headlineSmall?.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: controller.displayNameController,
                          enabled: controller.isEditing,
                          decoration: InputDecoration(
                            labelText: 'Display Name',
                            prefixIcon: Icon(Icons.person_outline),
                          ),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: controller.emailController,
                          enabled: false,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.email_outlined),
                            helperText: 'Email can not be changed',
                          ),
                        ),
                        if (controller.isEditing) ...[
                          SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed:
                                  controller.isLoading
                                      ? null
                                      : controller.updateProfile,
                              child:
                                  controller.isLoading
                                      ? SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2,
                                        ),
                                      )
                                      : Text("Save Changes"),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Card(
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(
                        Icons.security_outlined,
                        color: AppTheme.primaryColor,
                      ),
                      title: Text("Change Password"),
                      trailing: Icon(Icons.arrow_forward_ios_outlined),
                      onTap: () => Get.toNamed('/change-password'),
                    ),
                    Divider(height: 1, color: Colors.grey),
                    ListTile(
                      leading: Icon(
                        Icons.delete_forever,
                        color: AppTheme.accentColor,
                      ),
                      title: Text("Delete Account"),
                      trailing: Icon(Icons.arrow_forward_ios_outlined),
                      onTap: controller.deleteAccount,
                    ),
                     Divider(height: 1, color: Colors.grey),
                    ListTile(
                      leading: Icon(
                        Icons.logout,
                        color: AppTheme.errorColor,
                      ),
                      title: Text("Sign Out"),
                      trailing: Icon(Icons.arrow_forward_ios_outlined),
                      onTap: controller.signOut,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Text("ChatApp v1.0.0",
               style: Theme.of(Get.context!).textTheme.bodySmall?.copyWith(
                color: AppTheme.textSecondaryColor,
              ),),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildDefaultAvatar(dynamic user) {
    return Text(
      user.displayName.isNotEmpty ? user.displayName[0].toUpperCase() : '?',
      style: TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    );
  }
}
