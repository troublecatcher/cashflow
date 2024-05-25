import 'package:auto_route/auto_route.dart';
import 'package:cashflow/app/router/tabs_router.dart';
import 'package:cashflow/features/activities/activities_screen.dart';
import 'package:cashflow/features/balance/model/money_flow/money_flow.dart';
import 'package:cashflow/features/balance/model/money_flow_type/money_flow_type.dart';
import 'package:cashflow/features/balance/view/layout/balance_wrapper_screen.dart';
import 'package:cashflow/features/balance/view/layout/money_flow_screen.dart';
import 'package:cashflow/features/news/news.dart';
import 'package:cashflow/features/news/news_screen.dart';
import 'package:cashflow/features/news/news_single_screen.dart';
import 'package:cashflow/features/news/news_wrapper_screen.dart';
import 'package:cashflow/features/settings/screens/subscription_screen.dart';
import 'package:cashflow/features/settings/screens/support_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cashflow/app/config/remote_config.dart';
import 'package:cashflow/main.dart';
import 'package:cashflow/features/balance/view/layout/balance_screen.dart';

import '../../features/onboarding/onboarding_screen.dart';
import '../../features/settings/screens/privacy_policy_screen.dart';
import '../../features/settings/screens/promotion_screen.dart';
import '../../features/settings/settings_screen.dart';
import '../../features/settings/screens/terms_of_use_screen.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes {
    final isFirstTime = di<SharedPreferences>().getBool('isFirstTime');
    final promotion = di<RemoteConfig>().promotion;
    final showPromotion = promotion != null && promotion.isNotEmpty;
    return [
      AutoRoute(
        page: OnboardingRoute.page,
        initial: isFirstTime! && !showPromotion,
      ),
      AutoRoute(
        initial: !isFirstTime && !showPromotion,
        page: TabBarRoute.page,
        children: [
          AutoRoute(
            page: BalanceWrapperRoute.page,
            children: [
              AutoRoute(page: BalanceRoute.page),
              AutoRoute(page: MoneyFlowRoute.page),
            ],
          ),
          AutoRoute(page: ActivitiesRoute.page),
          AutoRoute(
            page: NewsWrapperRoute.page,
            children: [
              AutoRoute(page: NewsRoute.page),
              AutoRoute(page: NewsSingleRoute.page),
            ],
          ),
          AutoRoute(page: SettingsRoute.page),
        ],
      ),
      AutoRoute(page: PrivacyPolicyRoute.page),
      AutoRoute(page: PromotionRoute.page, initial: showPromotion),
      AutoRoute(page: TermsOfUseRoute.page),
      AutoRoute(page: SubscriptionRoute.page),
      AutoRoute(page: SupportRoute.page),
    ];
  }
}
