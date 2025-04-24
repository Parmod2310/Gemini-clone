import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:gemini_clone/features/chat/controllers/chat_controller.dart';
import 'package:gemini_clone/features/chat/views/screens/chat_screen.dart';
import 'package:gemini_clone/core/di/dependency_injection.dart';

void main() {
  setUp(() {
    setupDependencies();
  });

  testWidgets('ChatScreen renders correctly and sends message', (WidgetTester tester) async {
    // Build the ChatScreen widget
    await tester.pumpWidget(
      GetMaterialApp(
        home: ChatScreen(),
      ),
    );

    // Verify the AppBar title
    expect(find.text('Gemini Clone'), findsOneWidget);

    // Verify initial empty state
    expect(find.text('Start a conversation!'), findsOneWidget);

    // Simulate typing a message
    await tester.enterText(find.byType(TextField), 'Hello, AI!');
    await tester.pump();

    // Simulate pressing the send button
    await tester.tap(find.byIcon(Icons.send));
    await tester.pumpAndSettle();

    // Verify the message appears in the chat
    expect(find.text('Hello, AI!'), findsOneWidget);
  });

  testWidgets('ChatScreen shows error message when error occurs', (WidgetTester tester) async {
    await tester.pumpWidget(
      GetMaterialApp(
        home: ChatScreen(),
      ),
    );

    // Simulate an error
    final controller = Get.find<ChatController>();
    controller.errorMessage.value = 'Test error';
    await tester.pump();

    // Verify error message is displayed
    expect(find.text('Test error'), findsOneWidget);
  });
}