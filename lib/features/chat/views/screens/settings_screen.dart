import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../controllers/chat_controller.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings', style: TextStyle(fontSize: 20.sp)),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.w),
        children: [
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
            child: ListTile(
              leading: Icon(Icons.info_outline, color: Theme.of(context).primaryColor, size: 24.sp),
              title: Text('About', style: TextStyle(fontSize: 16.sp)),
              onTap: () {
                Get.snackbar(
                  'About',
                  'Gemini Clone v1.0.0\nBuilt with Flutter for internship assignment',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Theme.of(context).cardColor,
                  colorText: Theme.of(context).textTheme.bodyLarge!.color,
                  margin: EdgeInsets.all(16.w),
                  borderRadius: 12.r,
                  duration: const Duration(seconds: 3),
                );
              },
            ),
          ),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
            child: ListTile(
              leading: Icon(Icons.clear_all, color: Theme.of(context).primaryColor, size: 24.sp),
              title: Text('Clear History', style: TextStyle(fontSize: 16.sp)),
              onTap: () {
                Get.defaultDialog(
                  title: 'Clear History',
                  titleStyle: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                  middleText: 'Are you sure you want to clear all conversations?',
                  middleTextStyle: TextStyle(fontSize: 14.sp),
                  textConfirm: 'Yes',
                  textCancel: 'No',
                  confirmTextColor: Colors.white,
                  cancelTextColor: Theme.of(context).primaryColor,
                  buttonColor: Theme.of(context).primaryColor,
                  radius: 12.r,
                  onConfirm: () {
                    Get.find<ChatController>().clearConversation();
                    Get.back();
                  },
                  onCancel: () {},
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}