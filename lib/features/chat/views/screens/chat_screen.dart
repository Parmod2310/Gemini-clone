import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../controllers/chat_controller.dart';
import '../widgets/message_bubble.dart';
import '../widgets/chat_input.dart';
import '../../../../core/theme/theme_manager.dart';
import '../../../../core/constants/app_config.dart';
import 'settings_screen.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ChatController chatController = Get.put(ChatController());

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConfig.appName),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () {
              ThemeManager.to.toggleTheme(
                ThemeManager.to.currentTheme == 'light' ? 'dark' : 'light',
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Get.to(() => SettingsScreen());
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: chatController.clearConversation,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (chatController.messages.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/ai_avatar.png',
                        height: 100.h,
                        width: 100.w,
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        'Start a conversation!',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                padding: EdgeInsets.all(16.w),
                itemCount: chatController.messages.length,
                itemBuilder: (context, index) {
                  final message = chatController.messages[index];
                  return MessageBubble(
                    text: message.text,
                    isUser: message.isUser,
                    timestamp: message.timestamp,
                  );
                },
              );
            }),
          ),

          /// Typing indicator
          Obx(() => chatController.isTyping.value
              ? Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                3,
                    (index) => Padding(
                  padding: EdgeInsets.only(right: 4.w),
                  child: Container(
                    width: 8.w,
                    height: 8.w,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),
          )
              : const SizedBox.shrink()),

          /// Error Message
          Obx(() => chatController.errorMessage.value.isNotEmpty
              ? Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Text(
              chatController.errorMessage.value,
              style: TextStyle(color: Colors.red, fontSize: 14.sp),
            ),
          )
              : const SizedBox.shrink()),

          /// Loading Spinner
          Obx(() => chatController.isLoading.value
              ? Padding(
            padding: EdgeInsets.all(16.w),
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).primaryColor,
              ),
            ),
          )
              : const SizedBox.shrink()),

          /// Chat Input Box
          const ChatInput(),
        ],
      ),
    );
  }
}
