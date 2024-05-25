import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:cashflow/app/config/remote_config.dart';
import 'package:cashflow/main.dart';
import 'package:cashflow/common/base_screen.dart';

@RoutePage()
class PromotionScreen extends StatelessWidget {
  const PromotionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Promotion'),
      ),
      bottom: false,
      child: InAppWebView(
        initialUrlRequest: URLRequest(
          url: WebUri(di<RemoteConfig>().promotion!),
        ),
      ),
    );
  }
}
