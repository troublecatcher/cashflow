import 'package:cashflow/features/balance/model/money_flow_category/money_flow_category/money_flow_category.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'money_flow_category_expense.g.dart';

@HiveType(typeId: 3)
class MoneyFlowCategoryExpense extends MoneyFlowCategory {
  MoneyFlowCategoryExpense(String name, String assetName)
      : super(name, assetName);

  static List<MoneyFlowCategoryExpense> expenseCategories = [
    MoneyFlowCategoryExpense(
        'Procurement', 'assets/icons/categories/expense/procurement.svg'),
    MoneyFlowCategoryExpense(
        'Food', 'assets/icons/categories/expense/food.svg'),
    MoneyFlowCategoryExpense(
        'Transport', 'assets/icons/categories/expense/transport.svg'),
    MoneyFlowCategoryExpense(
        'Rest', 'assets/icons/categories/expense/rest.svg'),
    MoneyFlowCategoryExpense(
        'Investment', 'assets/icons/categories/expense/investment.svg'),
  ];
}
