import 'package:auto_route/auto_route.dart';
import 'package:cashflow/app/router/router.dart';
import 'package:cashflow/app/theme.dart';
import 'package:cashflow/common/custom_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

@RoutePage()
class TabBarScreen extends StatelessWidget {
  const TabBarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final activeColor = Theme.of(context).primaryColor;
    final disabledColor = Theme.of(context).disabledColor;
    return AutoTabsScaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      routes: const [
        BalanceRoute(),
        ActivitiesRoute(),
        NewsRoute(),
        SettingsRoute(),
      ],
      bottomNavigationBuilder: (_, tabsRouter) {
        return CupertinoTabBar(
          backgroundColor: surfaceColor,
          activeColor: activeColor,
          currentIndex: tabsRouter.activeIndex,
          onTap: (value) {
            tabsRouter.setActiveIndex(value);
          },
          items: [
            BottomNavigationBarItem(
              icon: CustomIcon(
                  assetName: 'assets/icons/navbar/balance.svg',
                  color: disabledColor),
              activeIcon: CustomIcon(
                  assetName: 'assets/icons/navbar/balance.svg',
                  color: activeColor),
              label: 'Balance',
            ),
            BottomNavigationBarItem(
              icon: CustomIcon(
                  assetName: 'assets/icons/navbar/activities.svg',
                  color: disabledColor),
              activeIcon: CustomIcon(
                  assetName: 'assets/icons/navbar/activities.svg',
                  color: activeColor),
              label: 'Activities',
            ),
            BottomNavigationBarItem(
              icon: CustomIcon(
                  assetName: 'assets/icons/navbar/news.svg',
                  color: disabledColor),
              activeIcon: CustomIcon(
                  assetName: 'assets/icons/navbar/news.svg',
                  color: activeColor),
              label: 'News',
            ),
            BottomNavigationBarItem(
              icon: CustomIcon(
                  assetName: 'assets/icons/navbar/settings.svg',
                  color: disabledColor),
              activeIcon: CustomIcon(
                  assetName: 'assets/icons/navbar/settings.svg',
                  color: activeColor),
              label: 'Settings',
            ),
          ],
        );
      },
    );
  }
}
