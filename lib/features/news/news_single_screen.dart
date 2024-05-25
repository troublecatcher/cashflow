import 'package:auto_route/auto_route.dart';
import 'package:cashflow/common/custom_icon.dart';
import 'package:cashflow/features/balance/view/widget/tile_container.dart';
import 'package:cashflow/features/news/news.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class NewsSingleScreen extends StatelessWidget {
  final News news;
  const NewsSingleScreen({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          news.title,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => context.router.popForced(),
          child: const CustomIcon(
              assetName: 'assets/icons/misc/back.svg', color: Colors.white),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 8.h),
            TileContainer(
              child: Image.asset(
                news.assetName,
                width: double.infinity,
                height: 262.h,
              ),
            ),
            SizedBox(height: 8.h),
            TileContainer(
              child: Column(
                children: [
                  Text(
                    news.title,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 24.sp,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 32.h),
                  Text(news.content),
                ],
              ),
            ),
            SizedBox(height: 8.h),
          ],
        ),
      ),
    );
  }
}
