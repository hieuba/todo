import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class TodoTile extends StatelessWidget {
  const TodoTile({
    super.key,
    required this.onChanged,
    required this.text,
    required this.isCompeleted,
  });

  final void Function(bool?)? onChanged;
  final String text;
  final bool isCompeleted;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          color: Colors.blue.shade300, borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Checkbox(
              value: isCompeleted,
              onChanged: onChanged,
            ),
            Text(
              text,
              style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  decoration: isCompeleted
                      ? TextDecoration.lineThrough
                      : TextDecoration.none),
            ),
          ],
        ),
      ),
    );
  }
}
