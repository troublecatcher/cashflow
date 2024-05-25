import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final bool active;
  final TextStyle? style;
  const CustomButton({
    super.key,
    required this.title,
    required this.onPressed,
    required this.active,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CupertinoButton(
            borderRadius: BorderRadius.circular(16.r),
            color: Theme.of(context).primaryColor,
            onPressed: active ? onPressed : null,
            child: Text(
              title,
              style: style ?? Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ),
      ],
    );
  }
}
