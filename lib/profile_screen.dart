import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:try_jules/profile_controller.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Screen'),
        automaticallyImplyLeading: true, // Back button enabled
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to the Profile Screen!',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            Obx(() => Text(
                  'Profile Name: ${controller.profileName}',
                  style: const TextStyle(fontSize: 16),
                )),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                controller.updateProfileName(); // Call controller method
              },
              child: const Text('Update Profile Name'),
            ),
          ],
        ),
      ),
    );
  }
}
