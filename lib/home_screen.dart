import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:try_jules/home_controller.dart'; // Assuming your app name is try_jules

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // You can access the controller instance via `controller`
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        automaticallyImplyLeading: false, // To remove back button if not needed
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to the Home Screen!',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            Obx(() => Text(
                  'Button pressed: ${controller.count} times',
                  style: const TextStyle(fontSize: 16),
                )),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                controller.increment(); // Call controller method
              },
              child: const Text('Increment Counter'),
            ),
          ],
        ),
      ),
    );
  }
}
