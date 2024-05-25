import 'package:auto_route/auto_route.dart';
import 'package:cashflow/app/router/router.dart';
import 'package:cashflow/app/theme.dart';
import 'package:cashflow/features/balance/view/widget/tile_container.dart';
import 'package:cashflow/features/news/news.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('News'),
      ),
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            sliver: SliverList.separated(
              itemCount: News.newsList.length,
              itemBuilder: (context, index) {
                final news = News.newsList[index];
                return CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () =>
                      context.router.push(NewsSingleRoute(news: news)),
                  child: TileContainer(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: surfaceColor,
                            borderRadius: borderRadius,
                          ),
                          child: Image.asset(
                            news.assetName,
                            width: 120.r,
                            height: 120.r,
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: Text(
                            news.title,
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 20.sp,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => SizedBox(height: 8.h),
            ),
          ),
        ],
      ),
    );
  }
}
