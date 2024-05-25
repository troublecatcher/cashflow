import 'package:cashflow/features/balance/controller/money_flow_cubit.dart';
import 'package:cashflow/features/balance/model/money_flow/money_flow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:cashflow/app/config/init_di.dart';
import 'package:cashflow/app/config/init_hive.dart';
import 'package:cashflow/app/router/router.dart';
import 'package:cashflow/app/theme.dart';
import 'package:hive_flutter/hive_flutter.dart';

late Box<MoneyFlow> moneyFlowBox;
final di = GetIt.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDI();
  await initHive();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);

  runApp(
    BlocProvider(
      create: (context) => MoneyFlowCubit(),
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp.router(
          theme: theme,
          routerConfig: _appRouter.config(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
