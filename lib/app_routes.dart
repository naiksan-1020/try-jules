import 'package:get/get.dart';
import 'package:try_jules/login_screen.dart'; // Assuming your app name is try_jules
import 'package:try_jules/home_screen.dart';   // Assuming your app name is try_jules
import 'package:try_jules/home_controller.dart'; // To bind HomeController

class AppRoutes {
  static const String login = '/login';
  static const String home = '/home';
}

final List<GetPage> appPages = [
  GetPage(
    name: AppRoutes.login,
    page: () => LoginScreen(),
    // No binding needed here if LoginController is put directly in LoginScreen
  ),
  GetPage(
    name: AppRoutes.home,
    page: () => const HomeScreen(),
    binding: BindingsBuilder(() { // Example of binding HomeController
      Get.lazyPut<HomeController>(() => HomeController());
    }),
  ),
  // Add other pages here
];
