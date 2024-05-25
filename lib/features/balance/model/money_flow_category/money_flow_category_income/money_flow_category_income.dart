import 'package:cashflow/features/balance/model/money_flow_category/money_flow_category/money_flow_category.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'money_flow_category_income.g.dart';

@HiveType(typeId: 2)
class MoneyFlowCategoryIncome extends MoneyFlowCategory {
  MoneyFlowCategoryIncome(String name, String assetName)
      : super(name, assetName);

  static List<MoneyFlowCategoryIncome> incomeCategories = [
    MoneyFlowCategoryIncome(
        'Business', 'assets/icons/categories/income/business.svg'),
    MoneyFlowCategoryIncome(
        'Salary', 'assets/icons/categories/income/salary.svg'),
    MoneyFlowCategoryIncome(
        'Dividends', 'assets/icons/categories/income/dividents.svg'),
    MoneyFlowCategoryIncome(
        'Investment', 'assets/icons/categories/income/investment.svg'),
    MoneyFlowCategoryIncome('Rent', 'assets/icons/categories/income/rent.svg'),
    MoneyFlowCategoryIncome(
        'Freelance', 'assets/icons/categories/income/freelance.svg'),
    MoneyFlowCategoryIncome(
        'Royalty', 'assets/icons/categories/income/royalty.svg'),
    MoneyFlowCategoryIncome(
        'Passive income', 'assets/icons/categories/income/passive_income.svg'),
  ];
}
