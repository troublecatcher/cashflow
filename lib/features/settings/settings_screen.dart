import 'package:auto_route/auto_route.dart';
import 'package:cashflow/app/router/router.dart';
import 'package:cashflow/app/theme.dart';
import 'package:cashflow/common/custom_icon.dart';
import 'package:cashflow/features/balance/view/widget/tile_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';

@RoutePage()
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool shareable = true;
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        transitionBetweenRoutes: false,
        middle: Text('Settings'),
      ),
      child: TileContainer(
        margin: EdgeInsets.symmetric(vertical: 8.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SettingsItem(
              title: 'Terms of use',
              assetPath: 'assets/icons/settings/terms.svg',
              onPressed: (_) => context.router.push(const TermsOfUseRoute()),
            ),
            SizedBox(height: 8.h),
            SettingsItem(
              title: 'Privacy Policy',
              assetPath: 'assets/icons/settings/privacy.svg',
              onPressed: (_) => context.router.push(const PrivacyPolicyRoute()),
            ),
            SizedBox(height: 8.h),
            SettingsItem(
              title: 'Support page',
              assetPath: 'assets/icons/settings/support.svg',
              onPressed: (_) => context.router.push(const SupportRoute()),
            ),
            SizedBox(height: 8.h),
            SettingsItem(
              title: 'Share with friends',
              assetPath: 'assets/icons/settings/share.svg',
              onPressed: (ctx) async {
                if (shareable) {
                  shareable = false;
                  final box = ctx.findRenderObject() as RenderBox?;
                  await Share.share(
                    'Check out ShareFlow on the AppStore! This app really helps you keep track of your finances',
                    sharePositionOrigin:
                        box!.localToGlobal(Offset.zero) & box.size,
                  ).whenComplete(() => shareable = true);
                }
              },
            ),
            SizedBox(height: 8.h),
            SettingsItem(
              title: 'Subscription info',
              assetPath: 'assets/icons/settings/subscription.svg',
              onPressed: (_) => context.router.push(const SubscriptionRoute()),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsItem extends StatelessWidget {
  final String title;
  final String assetPath;
  final Function(BuildContext) onPressed;
  const SettingsItem(
      {super.key,
      required this.title,
      required this.assetPath,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (ctx) {
      return CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: () => onPressed(ctx),
        child: TileContainer(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CustomIcon(
                    assetName: assetPath,
                    color: Theme.of(context).primaryColor,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    title,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.white),
                  ),
                ],
              ),
              const CustomIcon(
                  assetName: 'assets/icons/misc/forward.svg',
                  color: disabledColor),
            ],
          ),
        ),
      );
    });
  }
}
