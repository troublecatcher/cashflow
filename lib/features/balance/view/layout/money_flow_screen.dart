import 'package:auto_route/auto_route.dart';
import 'package:cashflow/app/theme.dart';
import 'package:cashflow/common/custom_button.dart';
import 'package:cashflow/common/custom_icon.dart';
import 'package:cashflow/features/balance/controller/money_flow_cubit.dart';
import 'package:cashflow/features/balance/model/money_flow/money_flow.dart';
import 'package:cashflow/features/balance/model/money_flow_category/money_flow_category/money_flow_category.dart';
import 'package:cashflow/features/balance/model/money_flow_category/money_flow_category_expense/money_flow_category_expense.dart';
import 'package:cashflow/features/balance/model/money_flow_category/money_flow_category_income/money_flow_category_income.dart';
import 'package:cashflow/features/balance/model/money_flow_type/money_flow_type.dart';
import 'package:cashflow/features/balance/view/widget/tile_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

@RoutePage()
class MoneyFlowScreen extends StatefulWidget {
  final MoneyFlowType type;
  final MoneyFlow? moneyflow;
  const MoneyFlowScreen({super.key, this.moneyflow, required this.type});

  @override
  State<MoneyFlowScreen> createState() => _MoneyFlowScreenState();
}

class _MoneyFlowScreenState extends State<MoneyFlowScreen> {
  final nameController = TextEditingController();
  final amountController = TextEditingController();
  MoneyFlowCategory? selectedCategory;
  List<MoneyFlowCategory> categories = [];

  @override
  void initState() {
    super.initState();
    switch (widget.type) {
      case MoneyFlowType.income:
        categories = MoneyFlowCategoryIncome.incomeCategories;
        break;
      case MoneyFlowType.expense:
        categories = MoneyFlowCategoryExpense.expenseCategories;
        break;
      default:
    }
    final moneyflow = widget.moneyflow;
    if (moneyflow != null) {
      nameController.text = moneyflow.title;
      amountController.text = moneyflow.amount.toString();
      selectedCategory = moneyflow.category;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => context.router.popForced(),
          child: const CustomIcon(
              assetName: 'assets/icons/misc/back.svg', color: Colors.white),
        ),
        middle: Text(
          widget.moneyflow == null ? 'Add Expense' : 'Edit Expense',
        ),
        trailing: widget.moneyflow != null
            ? CupertinoButton(
                padding: EdgeInsets.zero,
                child: const Text(
                  'Delete',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  final list = context.read<MoneyFlowCubit>().state;
                  context
                      .read<MoneyFlowCubit>()
                      .delete(list.indexOf(widget.moneyflow!));
                  showTopSnackBar(
                    Overlay.of(context),
                    CustomSnackBar.success(
                      backgroundColor: Theme.of(context).primaryColor,
                      message:
                          '${widget.type.name.capitalize()} has been deleted successfully!',
                    ),
                  );
                  context.router.popForced();
                },
              )
            : null,
      ),
      child: SingleChildScrollView(
        child: TileContainer(
          margin: EdgeInsets.symmetric(vertical: 8.h),
          child: Column(
            children: [
              TitledSection(
                title: 'Title',
                child: CupertinoTextField.borderless(
                  onChanged: (_) => setState(() {}),
                  controller: nameController,
                  cursorColor: const Color.fromRGBO(214, 134, 101, 1),
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.white),
                  padding: EdgeInsets.symmetric(
                    vertical: 13.h,
                    horizontal: 16.w,
                  ),
                  placeholder: 'Name title',
                  placeholderStyle: Theme.of(context).textTheme.bodyMedium,
                  decoration: BoxDecoration(
                    borderRadius: borderRadius,
                    color: surfaceColor,
                  ),
                ),
              ),
              TitledSection(
                title: 'Amount',
                child: CupertinoTextField.borderless(
                  onChanged: (_) => setState(() {}),
                  controller: amountController,
                  cursorColor: const Color.fromRGBO(214, 134, 101, 1),
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.white),
                  padding: EdgeInsets.symmetric(
                    vertical: 13.h,
                    horizontal: 16.w,
                  ),
                  placeholder: 'Amount',
                  placeholderStyle: Theme.of(context).textTheme.bodyMedium,
                  decoration: BoxDecoration(
                    borderRadius: borderRadius,
                    color: surfaceColor,
                  ),
                ),
              ),
              TitledSection(
                title: 'Category',
                child: ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    final activeColor = Theme.of(context).primaryColor;
                    final isActive = selectedCategory?.name == category.name;
                    return CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () =>
                          setState(() => selectedCategory = category),
                      child: TileContainer(
                        color: isActive
                            ? const Color.fromRGBO(214, 134, 101, 0.14)
                            : surfaceColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CustomIcon(
                                  assetName: category.assetName,
                                  color: isActive ? activeColor : disabledColor,
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  category.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          color: isActive
                                              ? activeColor
                                              : disabledColor),
                                ),
                              ],
                            ),
                            CustomIcon(
                              assetName: isActive
                                  ? 'assets/icons/misc/check.svg'
                                  : 'assets/icons/misc/check_blank.svg',
                              color: isActive ? activeColor : surfaceColor,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(height: 8.h),
                  itemCount: categories.length,
                ),
              ),
              SizedBox(height: 16.h),
              CustomButton(
                title:
                    widget.moneyflow == null ? 'Add expense' : 'Save expense',
                onPressed: () {
                  if (widget.moneyflow == null) {
                    context.read<MoneyFlowCubit>().create(
                          MoneyFlow(
                            type: widget.type,
                            title: nameController.text,
                            amount: num.parse(amountController.text),
                            category: selectedCategory!,
                            createdAt: DateTime.now(),
                          ),
                        );
                  } else {
                    final moneyFlows = context.read<MoneyFlowCubit>().state;
                    final index = moneyFlows.indexOf(widget.moneyflow!);
                    context.read<MoneyFlowCubit>().update(
                          index,
                          MoneyFlow(
                            type: widget.type,
                            title: nameController.text,
                            amount: num.parse(amountController.text),
                            category: selectedCategory!,
                            createdAt: widget.moneyflow!.createdAt,
                          ),
                        );
                  }
                  showTopSnackBar(
                    Overlay.of(context),
                    CustomSnackBar.success(
                      backgroundColor: Theme.of(context).primaryColor,
                      message:
                          '${widget.type.name.capitalize()} has been ${widget.moneyflow == null ? 'created' : 'saved'} successfully!',
                    ),
                  );
                  context.router.popForced();
                },
                active: nameController.text.isNotEmpty &&
                    amountController.text.isNotEmpty &&
                    num.tryParse(amountController.text) != null &&
                    num.tryParse(amountController.text)! > 0 &&
                    selectedCategory != null,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.white),
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }
}

class TitledSection extends StatelessWidget {
  final String title;
  final Widget child;
  const TitledSection({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          SizedBox(height: 8.h),
          child,
        ],
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
