import 'package:auto_route/auto_route.dart';
import 'package:cashflow/common/custom_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:cashflow/app/config/remote_config.dart';
import 'package:cashflow/main.dart';
import 'package:cashflow/common/base_screen.dart';

@RoutePage()
class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Subscription info'),
        border: null,
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => context.router.popForced(),
          child: const CustomIcon(
              assetName: 'assets/icons/misc/back.svg', color: Colors.white),
        ),
      ),
      bottom: false,
      child: Builder(
        builder: (context) {
          final subscription = di<RemoteConfig>().subscription;
          if (subscription != null && subscription != '') {
            return InAppWebView(
              initialUrlRequest: URLRequest(
                url: WebUri(subscription),
              ),
            );
          } else {
            return const Center(
              child: Text('Failed to load Subscription info'),
            );
          }
        },
      ),
    );
  }
}
