import 'package:get/get.dart';

class ProfileController extends GetxController {
  // Observable profile name
  var profileName = 'Default Name'.obs;

  // Method to update the profile name
  void updateProfileName() {
    profileName.value = 'Updated Name';
  }
}
