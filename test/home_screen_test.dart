import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:try_jules/home_screen.dart';
import 'package:try_jules/home_controller.dart';
import 'package:try_jules/app_routes.dart'; // For GetMaterialApp setup

void main() {
  setUpAll(() {
    // Essential for GetX testing, especially with navigation and bindings
    Get.testMode = true; 
  });

  // It's good practice to ensure controllers are reset before each test
  // if they are manually put or if state persists across tests in some way.
  setUp(() {
    // Manually inject the controller before each test that needs it directly
    // This ensures a fresh controller for each test.
    // However, for HomeScreen which uses GetView, the binding in appPages should handle it
    // when testing via GetMaterialApp.
    Get.lazyPut<HomeController>(() => HomeController());
  });

  tearDown(() {
    // Clean up controllers after each test to prevent state leakage
    Get.reset();
  });

  group('HomeScreen Widget Tests', () {
    testWidgets('Renders initial UI elements correctly', (WidgetTester tester) async {
      // Build HomeScreen. Using GetMaterialApp to correctly handle GetView and bindings.
      await tester.pumpWidget(
        GetMaterialApp(
          initialRoute: AppRoutes.home, // Start at the home screen
          getPages: appPages, // Use the app's route definitions
        ),
      );

      // Let the widget tree settle.
      await tester.pumpAndSettle();


      // Verify "Home Screen" AppBar title
      expect(find.widgetWithText(AppBar, 'Home Screen'), findsOneWidget);
      
      // Verify welcome text
      expect(find.text('Welcome to the Home Screen!'), findsOneWidget);

      // Verify initial counter text (assuming HomeController starts count at 0)
      // The text is 'Button pressed: 0 times'
      expect(find.text('Button pressed: 0 times'), findsOneWidget);

      // Verify "Increment Counter" button
      expect(find.widgetWithText(ElevatedButton, 'Increment Counter'), findsOneWidget);
    });

    testWidgets('Counter increments when "Increment Counter" button is tapped', (WidgetTester tester) async {
      await tester.pumpWidget(
        GetMaterialApp(
          initialRoute: AppRoutes.home,
          getPages: appPages,
        ),
      );
      await tester.pumpAndSettle(); // Ensure bindings are ready and UI is built

      // Initial counter value
      expect(find.text('Button pressed: 0 times'), findsOneWidget);

      // Tap the "Increment Counter" button
      await tester.tap(find.widgetWithText(ElevatedButton, 'Increment Counter'));
      await tester.pump(); // Rebuild the widget after the tap to reflect state change

      // Verify counter text updated
      expect(find.text('Button pressed: 1 times'), findsOneWidget);

      // Tap again
      await tester.tap(find.widgetWithText(ElevatedButton, 'Increment Counter'));
      await tester.pump();

      // Verify counter text updated again
      expect(find.text('Button pressed: 2 times'), findsOneWidget);
    });

    testWidgets('HomeController is accessible in HomeScreen', (WidgetTester tester) async {
      await tester.pumpWidget(
        GetMaterialApp(
          initialRoute: AppRoutes.home,
          getPages: appPages, // This will use the binding for HomeController
        ),
      );
      await tester.pumpAndSettle();

      // Access the controller. This is an indirect way to check if binding worked.
      // A more direct way is not straightforward with GetView in a test environment
      // without exposing the controller, but if UI updates, controller is working.
      final HomeController controller = Get.find<HomeController>();
      expect(controller, isNotNull);
      expect(controller.count.value, 0); // Check initial state

      // Tap the button to change controller state
      await tester.tap(find.widgetWithText(ElevatedButton, 'Increment Counter'));
      await tester.pump();

      expect(controller.count.value, 1); // Verify controller state changed
    });
  });
}
