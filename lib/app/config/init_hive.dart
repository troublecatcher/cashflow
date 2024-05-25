import 'package:cashflow/features/balance/model/money_flow/money_flow.dart';
import 'package:cashflow/features/balance/model/money_flow_category/money_flow_category/money_flow_category.dart';
import 'package:cashflow/features/balance/model/money_flow_category/money_flow_category_expense/money_flow_category_expense.dart';
import 'package:cashflow/features/balance/model/money_flow_category/money_flow_category_income/money_flow_category_income.dart';
import 'package:cashflow/features/balance/model/money_flow_type/money_flow_type.dart';
import 'package:cashflow/main.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(MoneyFlowTypeAdapter());
  Hive.registerAdapter(MoneyFlowCategoryAdapter());
  Hive.registerAdapter(MoneyFlowCategoryIncomeAdapter());
  Hive.registerAdapter(MoneyFlowCategoryExpenseAdapter());
  Hive.registerAdapter(MoneyFlowAdapter());
  moneyFlowBox = await Hive.openBox('box');
  // moneyFlowBox.clear();
}
