import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:cashflow/app/router/router.dart';
import 'package:cashflow/app/theme.dart';
import 'package:cashflow/common/custom_icon.dart';
import 'package:cashflow/features/balance/controller/money_flow_cubit.dart';
import 'package:cashflow/features/balance/model/money_flow/money_flow.dart';
import 'package:cashflow/features/balance/model/money_flow_category/money_flow_category_expense/money_flow_category_expense.dart';
import 'package:cashflow/features/balance/model/money_flow_category/money_flow_category_income/money_flow_category_income.dart';
import 'package:cashflow/features/balance/model/money_flow_type/money_flow_type.dart';
import 'package:cashflow/features/balance/view/layout/money_flow_screen.dart';
import 'package:cashflow/features/balance/view/widget/my_sliver_app_bar.dart';
import 'package:cashflow/features/balance/view/widget/tile_container.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class BalanceScreen extends StatefulWidget {
  const BalanceScreen({super.key});

  @override
  State<BalanceScreen> createState() => _BalanceScreenState();
}

class _BalanceScreenState extends State<BalanceScreen> {
  MoneyFlowType type = MoneyFlowType.all;

  @override
  Widget build(BuildContext context) {
    // final now = DateTime.now();
    // DateTime n = now.subtract(Duration(days: now.day - 1));
    // while (n.month == now.month) {
    //   final t =
    //       Random().nextBool() ? MoneyFlowType.expense : MoneyFlowType.income;
    //   context.read<MoneyFlowCubit>().create(
    //         MoneyFlow(
    //           type: t,
    //           title: 'test',
    //           amount: Random().nextInt(100),
    //           category: t == MoneyFlowType.income
    //               ? MoneyFlowCategoryIncome
    //                   .incomeCategories[Random().nextInt(8)]
    //               : MoneyFlowCategoryExpense
    //                   .expenseCategories[Random().nextInt(5)],
    //           createdAt: n,
    //         ),
    //       );
    //   n = n.add(const Duration(days: 1));
    // }
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        child: SafeArea(
          bottom: false,
          child: Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverPersistentHeader(
                  pinned: true,
                  delegate: MySliverAppBar(expandedHeight: 175.sp),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 8.h)),
                SliverToBoxAdapter(
                  child: TileContainer(
                    child: CupertinoButton(
                        borderRadius: borderRadius,
                        color: surfaceColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomIcon(
                              assetName: 'assets/icons/misc/add.svg',
                              color: Theme.of(context).primaryColor,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              'Refill Balance',
                              style: Theme.of(context).textTheme.bodySmall,
                            )
                          ],
                        ),
                        onPressed: () => showCupertinoModalPopup(
                              context: context,
                              builder: (context) => CupertinoActionSheet(
                                title: const Text('What do you want to add?'),
                                actions: [
                                  CupertinoActionSheetAction(
                                    onPressed: () => context.router
                                      ..popForced()
                                      ..push(MoneyFlowRoute(
                                          type: MoneyFlowType.income)),
                                    child: const Text('Add Income'),
                                  ),
                                  CupertinoActionSheetAction(
                                    onPressed: () => context.router
                                      ..popForced()
                                      ..push(MoneyFlowRoute(
                                          type: MoneyFlowType.expense)),
                                    child: const Text('Add Expense'),
                                  ),
                                ],
                                cancelButton: CupertinoActionSheetAction(
                                  onPressed: () => context.router.popForced(),
                                  isDefaultAction: true,
                                  child: const Text('Cancel'),
                                ),
                              ),
                            )),
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 8.h)),
                SliverToBoxAdapter(
                  child: TileContainer(
                    child: BlocBuilder<MoneyFlowCubit, List<MoneyFlow>>(
                      builder: (context, moneyFlowList) {
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('History'),
                                CustomSlidingSegmentedControl(
                                  height: 40.h,
                                  customSegmentSettings: CustomSegmentSettings(
                                    borderRadius: BorderRadius.circular(18.r),
                                    highlightColor: surfaceColor,
                                    splashFactory: NoSplash.splashFactory,
                                  ),
                                  fixedWidth: 90.w,
                                  innerPadding: EdgeInsets.all(2.r),
                                  thumbDecoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: borderRadius,
                                  ),
                                  decoration: BoxDecoration(
                                    color: surfaceColor,
                                    borderRadius: borderRadius,
                                  ),
                                  initialValue: type,
                                  children: {
                                    MoneyFlowType.all: FittedBox(
                                      child: Text(
                                        'All',
                                        style: TextStyle(
                                          color: type == MoneyFlowType.all
                                              ? Colors.white
                                              : null,
                                        ),
                                      ),
                                    ),
                                    MoneyFlowType.income: FittedBox(
                                      child: Text(
                                        'Income',
                                        style: TextStyle(
                                          color: type == MoneyFlowType.income
                                              ? Colors.white
                                              : null,
                                        ),
                                      ),
                                    ),
                                    MoneyFlowType.expense: FittedBox(
                                      child: Text(
                                        'Expense',
                                        style: TextStyle(
                                          color: type == MoneyFlowType.expense
                                              ? Colors.white
                                              : null,
                                        ),
                                      ),
                                    ),
                                  },
                                  onValueChanged: (value) =>
                                      setState(() => type = value),
                                ),
                              ],
                            ),
                            SizedBox(height: 16.h),
                            if (moneyFlowList.isNotEmpty)
                              Builder(builder: (context) {
                                late List<MoneyFlow> neededMoneyFlowList;
                                switch (type) {
                                  case MoneyFlowType.all:
                                    neededMoneyFlowList = moneyFlowList;
                                    break;
                                  default:
                                    neededMoneyFlowList = moneyFlowList
                                        .where(
                                            (element) => element.type == type)
                                        .toList();
                                    break;
                                }
                                return AnimatedSize(
                                  duration: Durations.medium1,
                                  curve: Curves.easeOut,
                                  child: ListView.separated(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: neededMoneyFlowList.length,
                                    itemBuilder: (context, index) {
                                      final moneyflow =
                                          neededMoneyFlowList[index];
                                      return CupertinoButton(
                                        padding: EdgeInsets.zero,
                                        onPressed: () => context.router.push(
                                            MoneyFlowRoute(
                                                type: moneyflow.type,
                                                moneyflow: moneyflow)),
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 8.h),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      color: surfaceColor,
                                                      borderRadius:
                                                          borderRadius,
                                                    ),
                                                    padding:
                                                        EdgeInsets.all(12.r),
                                                    child: CustomIcon(
                                                      assetName: moneyflow
                                                          .category.assetName,
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                    ),
                                                  ),
                                                  SizedBox(width: 8.w),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        moneyflow.title,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium!
                                                            .copyWith(
                                                                color: Colors
                                                                    .white),
                                                      ),
                                                      SizedBox(height: 4.h),
                                                      Text(
                                                        moneyflow.category.name,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    '${moneyflow.type == MoneyFlowType.income ? '+' : '-'}${moneyflow.amount.toStringAsFixed(2)} \$',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium!
                                                        .copyWith(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor),
                                                  ),
                                                  Text(
                                                    moneyflow.type.name
                                                        .capitalize(),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) =>
                                        SizedBox(height: 8.h),
                                  ),
                                );
                              })
                            else
                              TileContainer(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        CustomIcon(
                                          assetName:
                                              'assets/icons/misc/info.svg',
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        SizedBox(width: 8.w),
                                        Text(
                                          'Your balance is empty',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8.h),
                                    const Text(
                                        'To add income or expense, tap the “Refill Balance“ button'),
                                  ],
                                ),
                              ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 8.h)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
