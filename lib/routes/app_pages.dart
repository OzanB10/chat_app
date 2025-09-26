import 'package:chat_app/routes/app_routes.dart';
import 'package:chat_app/views/auth/forgot_password_view.dart';
import 'package:chat_app/views/auth/login_view.dart';
import 'package:chat_app/views/auth/register_view.dart';
import 'package:chat_app/views/splash_view.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AppPages {
  static const String initial = Approutes.splash;

  static final routes = [
     GetPage(name: Approutes.splash, page: () => const SplashView()),
     GetPage(name: Approutes.login, page: () => const LoginView()),
     GetPage(name: Approutes.register, page: () => const RegisterView()),
    GetPage( name: Approutes.forgotPassword, page: () => const ForgotPasswordView(),),
    // GetPage(
    // name: Approutes.home, 
    // page: () => const HomeView(),
    // binding: BindingsBuilder(() {
    //   Get.put(HomeController());
    // }),
    // ),
    // GetPage(
    // name: Approutes.main, 
    // page: () => const MainView(),
    // binding: BindingsBuilder(() {
    //   Get.put(MainController());
    // }),
    // ),
   
    // GetPage(
    // name: Approutes.changePassword, 
    // page: () => const ChangePasswordView(),
    
    // ),
    // GetPage(
    // name: Approutes.profile, 
    // page: () => const ProfileView(),
    // binding: BindingsBuilder(() {
    //   Get.put(ProfileController());
    // }),
    // ),
    // GetPage(
    // name: Approutes.chat, 
    // page: () => const ChatView(),
    // binding: BindingsBuilder(() {
    //   Get.put(ChatController());
    // }),
    // ),
    // GetPage
    // (name: Approutes.usersList, 
    // page: () => const UsersListView(),
    // binding: BindingsBuilder(() {
    //   Get.put(UsersListController());
    // }),
    // ),
    // GetPage(
    // name: Approutes.friends,
    // page: () => const FriendsView(),
    // binding: BindingsBuilder(() {
    //   Get.put(FriendsController());
    // }),
    // ),
    // GetPage(
    // name: Approutes.friendRequests, 
    // page: () => const FriendRequestsView(),
    // binding: BindingsBuilder(() {
    //   Get.put(FriendRequestsController());
    // }),
    // ),
    // GetPage(name: Approutes.notifications, 
    // page: () => const NotificationsView(),
    // binding: BindingsBuilder(() {
    //   Get.put(NotificationsController());
    // }),
    // ),
  ];
}