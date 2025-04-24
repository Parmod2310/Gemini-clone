import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../controllers/chat_controller.dart';
import '../../../../core/utils/validation_utils.dart';

class ChatInput extends StatefulWidget {
  const ChatInput({Key? key}) : super(key: key);

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  final ChatController chatController = Get.find<ChatController>();
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4.0,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).primaryColor),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Type a message...',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  errorText: ValidationUtils.validateInput(_controller.text),
                ),
                onChanged: (value) {
                  setState(() {});
                },
                onSubmitted: (value) => _handleSend(value),
              ),
            ),
          ),
          SizedBox(width: 8.w),
          AnimatedScale(
            scale: _controller.text.isNotEmpty ? 1.0 : 0.7,
            duration: const Duration(milliseconds: 200),
            child: IconButton(
              icon: const Icon(Icons.send, size: 28),
              color: Theme.of(context).primaryColor,
              onPressed: () => _handleSend(_controller.text),
            ),
          ),
        ],
      ),
    );
  }

  void _handleSend(String text) {
    final error = ValidationUtils.validateInput(text);
    if (error == null) {
      chatController.sendMessage(text);
      _controller.clear();
      setState(() {}); // trigger rebuild to hide send button
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error)),
      );
    }
  }
}
