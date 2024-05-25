import 'package:cashflow/app/theme.dart';
import 'package:cashflow/common/custom_icon.dart';
import 'package:cashflow/features/balance/controller/money_flow_cubit.dart';
import 'package:cashflow/features/balance/model/money_flow/money_flow.dart';
import 'package:cashflow/features/balance/model/money_flow_type/money_flow_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  MySliverAppBar({required this.expandedHeight});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final collapsePercent = 1 - shrinkOffset / expandedHeight;
    return BlocBuilder<MoneyFlowCubit, List<MoneyFlow>>(
      builder: (context, state) {
        final income = state
            .where((element) => element.type == MoneyFlowType.income)
            .fold(0.0,
                (previousValue, element) => previousValue + element.amount);
        final expense = state
            .where((element) => element.type == MoneyFlowType.expense)
            .fold(0.0,
                (previousValue, element) => previousValue + element.amount);
        return Stack(
          children: [
            Container(
              height: collapsePercent < 0.4
                  ? (kToolbarHeight + 10).sp
                  : expandedHeight * collapsePercent,
              padding: EdgeInsets.all(16.r * collapsePercent),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(16.r * collapsePercent),
                ),
              ),
              child: Opacity(
                opacity: collapsePercent,
                child: SizedBox(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Your balance'),
                        Text(
                          '${(income - expense).toStringAsFixed(2)} \$',
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                        SizedBox(height: 16.h),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8.h, horizontal: 16.w),
                                decoration: BoxDecoration(
                                  color: surfaceColor,
                                  borderRadius: borderRadius,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Income'),
                                    Row(
                                      children: [
                                        const CustomIcon(
                                          assetName:
                                              'assets/icons/misc/income.svg',
                                          color: Colors.white,
                                        ),
                                        SizedBox(width: 4.w),
                                        Text(
                                          '${income.toStringAsFixed(2)} \$',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                color: Colors.white,
                                              ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8.h, horizontal: 16.w),
                                decoration: BoxDecoration(
                                  color: surfaceColor,
                                  borderRadius: borderRadius,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Expense'),
                                    Row(
                                      children: [
                                        const CustomIcon(
                                          assetName:
                                              'assets/icons/misc/expense.svg',
                                          color: Colors.white,
                                        ),
                                        SizedBox(width: 4.w),
                                        Text(
                                          '${expense.toStringAsFixed(2)} \$',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                color: Colors.white,
                                              ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Opacity(
                opacity: shrinkOffset / expandedHeight,
                child: Column(
                  children: [
                    const Text('Your balance'),
                    Text(
                      '${(income - expense).toStringAsFixed(2)} \$',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => (kToolbarHeight + 10).sp;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
