import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_config.dart';

class MessageBubble extends StatelessWidget {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  const MessageBubble({
    Key? key,
    required this.text,
    required this.isUser,
    required this.timestamp,
  }) : super(key: key); // Added super.key

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: 1.0, // Use 1.0 instead of 0.0 to make visible
      duration: AppConfig.animationDuration,
      curve: Curves.easeInOut,
      child: Align(
        alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 6.h, horizontal: 8.w),
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: isUser ? Theme.of(context).primaryColor : Colors.grey[200],
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4.0,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 16.r,
                    backgroundImage: AssetImage(
                      isUser ? 'assets/images/user_avatar.png' : 'assets/images/ai_avatar.png',
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Flexible(
                    child: Text(
                      text,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: isUser ? Colors.white : Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.h),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    DateFormat('HH:mm').format(timestamp),
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: isUser ? Colors.white70 : Colors.black54,
                    ),
                  ),
                  if (isUser)
                    Padding(
                      padding: EdgeInsets.only(left: 4.w),
                      child: Icon(
                        Icons.done_all,
                        size: 14.sp,
                        color: Colors.white70,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
