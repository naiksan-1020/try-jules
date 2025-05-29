import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:try_jules/login_screen.dart';
import 'package:try_jules/home_screen.dart'; // Import HomeScreen
import 'package:try_jules/app_routes.dart';   // Import AppRoutes and appPages
import 'package:try_jules/home_controller.dart'; // Import HomeController for bindings

void main() {
  setUpAll(() {
    Get.testMode = true;
    // Ensure bindings are set up for testing navigation
    // This is a simplified way; for complex apps, you might have a TestBindings class
    Get.lazyPut<HomeController>(() => HomeController());
  });

  // Reset GetX state after each test
  tearDown(() {
    Get.reset();
  });

  group('LoginScreen Widget Tests', () {
    testWidgets('Renders Email and Password fields and Login button', (WidgetTester tester) async {
      await tester.pumpWidget(
        GetMaterialApp(
          initialRoute: AppRoutes.login,
          getPages: appPages,
        ),
      );
      await tester.pumpAndSettle(); // Ensure LoginScreen is fully rendered

      expect(find.byType(LoginScreen), findsOneWidget);
      expect(find.bySemanticsLabel('Email'), findsOneWidget);
      expect(find.bySemanticsLabel('Password'), findsOneWidget);
      expect(find.widgetWithText(ElevatedButton, 'Login'), findsOneWidget);
    });

    testWidgets('Typing in Email and Password fields updates the controller', (WidgetTester tester) async {
      await tester.pumpWidget(
        GetMaterialApp(
          initialRoute: AppRoutes.login,
          getPages: appPages,
        ),
      );
      await tester.pumpAndSettle();

      // The LoginController is Get.put within LoginScreen itself.
      // So we find it after LoginScreen is rendered.
      final LoginController controller = Get.find<LoginController>();

      await tester.enterText(find.widgetWithText(TextField, 'Email'), 'test@example.com');
      expect(controller.emailController.text, 'test@example.com');

      await tester.enterText(find.widgetWithText(TextField, 'Password'), 'password123');
      expect(controller.passwordController.text, 'password123');
    });

    testWidgets('Tapping Login button navigates to HomeScreen', (WidgetTester tester) async {
      await tester.pumpWidget(
        GetMaterialApp(
          initialRoute: AppRoutes.login,
          getPages: appPages, // appPages includes routes for Login and Home
        ),
      );
      await tester.pumpAndSettle(); // Wait for LoginScreen to build

      // Enter some text, though not strictly necessary for current login logic
      await tester.enterText(find.widgetWithText(TextField, 'Email'), 'test@example.com');
      await tester.enterText(find.widgetWithText(TextField, 'Password'), 'password');

      // Tap the login button.
      await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
      await tester.pumpAndSettle(); // pumpAndSettle to allow navigation to complete

      // Verify that HomeScreen is now displayed.
      expect(find.byType(HomeScreen), findsOneWidget);
      expect(find.text('Welcome to the Home Screen!'), findsOneWidget);

      // Verify that LoginScreen is no longer displayed (due to Get.offAllNamed)
      expect(find.byType(LoginScreen), findsNothing);
    });
  });
}
