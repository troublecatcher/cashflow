import 'package:auto_route/auto_route.dart';
import 'package:cashflow/app/theme.dart';
import 'package:cashflow/features/activities/activity_chart_data_cubit.dart';
import 'package:cashflow/features/activities/chart_bar_list.dart';
import 'package:cashflow/features/balance/controller/money_flow_cubit.dart';
import 'package:cashflow/features/balance/model/money_flow/money_flow.dart';
import 'package:cashflow/features/balance/view/layout/money_flow_screen.dart';
import 'package:cashflow/features/balance/view/widget/tile_container.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

enum ChartType { today, week, month }

@RoutePage()
class ActivitiesScreen extends StatefulWidget implements AutoRouteWrapper {
  const ActivitiesScreen({super.key});

  @override
  State<ActivitiesScreen> createState() => _ActivitiesScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => ActivityChartDataCubit(),
      child: this,
    );
  }
}

class _ActivitiesScreenState extends State<ActivitiesScreen> {
  ChartType type = ChartType.today;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Activities'),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Column(
              children: [
                TileContainer(
                  margin: EdgeInsets.symmetric(vertical: 8.h),
                  child: Column(
                    children: [
                      ChartBarList(type: type),
                      SizedBox(height: 16.h),
                      CustomSlidingSegmentedControl(
                        height: 40.h,
                        customSegmentSettings: CustomSegmentSettings(
                          borderRadius: BorderRadius.circular(18.r),
                          highlightColor: surfaceColor,
                          splashFactory: NoSplash.splashFactory,
                        ),
                        innerPadding: EdgeInsets.all(3.r),
                        thumbDecoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: borderRadius,
                        ),
                        decoration: BoxDecoration(
                          color: surfaceColor,
                          borderRadius: borderRadius,
                        ),
                        initialValue: type,
                        children: Map.fromEntries(
                          ChartType.values.map(
                            (e) => MapEntry(
                              e,
                              Text(
                                e.name.capitalize(),
                                style: TextStyle(
                                  color: type == e ? Colors.white : null,
                                ),
                              ),
                            ),
                          ),
                        ),
                        onValueChanged: (value) {
                          setState(() => type = value);
                          context.read<ActivityChartDataCubit>().set(null);
                        },
                        isStretch: true,
                      ),
                      SizedBox(height: 16.h),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            BlocBuilder<MoneyFlowCubit, List<MoneyFlow>>(
              builder: (context, mfs) {
                return BlocBuilder<ActivityChartDataCubit, ActivityChartData?>(
                  builder: (context, data) {
                    late String dates;
                    if (data != null) {
                      if (type == ChartType.month) {
                        dates =
                            '${DateFormat('dd.MM.yy').format(data.date)} – ${DateFormat('dd.MM.yy').format(data.date.add(const Duration(days: 7)))}';
                      } else {
                        dates = DateFormat('dd.MM.yy').format(data.date);
                      }
                    } else {
                      dates = 'Period not selected';
                    }
                    return TileContainer(
                      child: Column(
                        children: [
                          Text(dates),
                          SizedBox(height: 8.h),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 13.h, horizontal: 16.w),
                            decoration: BoxDecoration(
                              color: surfaceColor,
                              borderRadius: borderRadius,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Total amount'),
                                Text(
                                  data != null
                                      ? data.total.toStringAsFixed(2)
                                      : '-',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 16.h),
                          Container(
                            decoration: BoxDecoration(
                              color: surfaceColor,
                              borderRadius: borderRadius,
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 13.h, horizontal: 16.w),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Income'),
                                      Text(
                                          data != null
                                              ? data.income.toStringAsFixed(2)
                                              : '-',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(color: Colors.white)),
                                    ],
                                  ),
                                ),
                                const Divider(height: 0),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 13.h, horizontal: 16.w),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Expense'),
                                      Text(
                                          data != null
                                              ? data.expense.toStringAsFixed(2)
                                              : '-',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(color: Colors.white)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
