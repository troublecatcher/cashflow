import 'package:cashflow/app/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TileContainer extends StatelessWidget {
  final Widget child;
  final Color? color;
  final EdgeInsets? margin;
  const TileContainer(
      {super.key, required this.child, this.color, this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: color ?? surfaceColor,
        borderRadius: borderRadius,
      ),
      child: child,
    );
  }
}
