import 'package:auto_route/auto_route.dart';
import 'package:cashflow/common/custom_button.dart';
import 'package:cashflow/features/onboarding/onboarding_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cashflow/app/router/router.dart';
import 'package:cashflow/main.dart';

@RoutePage()
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final pageController = PageController();
  int page = 0;

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            scrollBehavior: null,
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            children: const [
              OnboardingPage(
                assetName: 'assets/images/onboarding/1.png',
                title: 'Welcome to your personalized finance app!',
                subtitle:
                    'This app will become your indispensable assistant in managing your personal finances.',
              ),
              OnboardingPage(
                assetName: 'assets/images/onboarding/2.png',
                title: 'Your personal financial assistant in your pocket.',
                subtitle:
                    'In our app, you can easily track expenses and income, keep a budget, and plan savings.',
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 100.h, horizontal: 16.w),
              child: CustomButton(
                title: page == 0 ? 'Next' : 'Get started',
                onPressed: () {
                  if (page == 0) {
                    pageController.animateToPage(
                      ++page,
                      duration: Durations.medium1,
                      curve: Curves.decelerate,
                    );
                  } else {
                    di<SharedPreferences>().setBool('isFirstTime', false);
                    context.router.replace(const BalanceRoute());
                  }
                },
                active: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
