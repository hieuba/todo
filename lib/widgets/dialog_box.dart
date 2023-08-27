import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:todo/widgets/my_button.dart';

class DiaLogBox extends StatelessWidget {
  const DiaLogBox({
    super.key,
    required this.controller,
    required this.onSave,
  });

  // ignore: prefer_typing_uninitialized_variables
  final controller;
  final void Function()? onSave;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.blue.shade100,
      content: SizedBox(
        height: 120.h,
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Add new task',
              ),
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyButton(
                  onTap: onSave,
                  text: 'Save',
                ),
                SizedBox(width: 8.w),
                MyButton(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  text: 'Cancle',
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
