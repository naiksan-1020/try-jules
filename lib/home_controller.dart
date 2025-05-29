import 'package:get/get.dart';

class HomeController extends GetxController {
  // Add any initial logic or variables here if needed
  // For now, a basic structure is fine.
  final count = 0.obs; // Example reactive variable

  void increment() {
    count.value++;
  }
}
