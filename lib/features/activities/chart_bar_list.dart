import 'package:cashflow/app/theme.dart';
import 'package:cashflow/features/activities/activities_screen.dart';
import 'package:cashflow/features/activities/activity_chart_data_cubit.dart';
import 'package:cashflow/features/balance/controller/money_flow_cubit.dart';
import 'package:cashflow/features/balance/model/money_flow/money_flow.dart';
import 'package:cashflow/features/balance/model/money_flow_type/money_flow_type.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ChartBarList extends StatefulWidget {
  final ChartType type;
  const ChartBarList({
    super.key,
    required this.type,
  });

  @override
  State<ChartBarList> createState() => _ChartBarListState();
}

class _ChartBarListState extends State<ChartBarList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoneyFlowCubit, List<MoneyFlow>>(
      builder: (context, state) {
        late List<ActivityChartData> list = [];
        final now = DateTime.now();
        switch (widget.type) {
          case ChartType.today:
            calcTodayMetrics(state, now, list);
            break;
          case ChartType.week:
            calcWeekMetrics(now, state, list);
            break;
          case ChartType.month:
            calcMonthMetrics(now, state, list);
            break;
        }
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(list.length, (index) {
            final data = list[index];
            return CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                context.read<ActivityChartDataCubit>().set(data);
              },
              child: BlocBuilder<ActivityChartDataCubit, ActivityChartData?>(
                builder: (context, state) {
                  final condition = state?.date == data.date;
                  return Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: condition
                              ? Theme.of(context).primaryColor.withOpacity(0.2)
                              : surfaceColor,
                          borderRadius: borderRadius,
                        ),
                        width: 32.w,
                        height: 177.h,
                        child: Builder(
                          builder: (context) {
                            double? fraction;
                            Color color = surfaceColor;
                            if (data.total > 0) {
                              color = Theme.of(context).primaryColor;
                              fraction = data.total / data.income;
                            } else if (data.total < 0) {
                              fraction = -(data.total / data.expense);
                            }
                            return FractionallySizedBox(
                              alignment: Alignment.bottomCenter,
                              heightFactor: fraction,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: color,
                                  borderRadius: borderRadius,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Text(
                        widget.type == ChartType.month
                            ? DateFormat('dd/MM').format(data.date)
                            : DateFormat('EEE').format(data.date),
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontWeight: FontWeight.w400,
                            color: condition
                                ? Theme.of(context).primaryColor
                                : disabledColor),
                      )
                    ],
                  );
                },
              ),
            );
          }),
        );
      },
    );
  }

  void calcMonthMetrics(
      DateTime now, List<MoneyFlow> state, List<ActivityChartData> list) {
    final sublist = state.where((mf) =>
        mf.createdAt.month == now.month && mf.createdAt.year == now.year);
    final firstDay = now.subtract(Duration(days: now.day - 1)).copyWith(
        hour: 0, minute: 0, second: 0, millisecond: 0, microsecond: 0);
    DateTime temp = firstDay;
    while (temp.month == now.month) {
      final weekLater = temp.add(const Duration(days: 7));
      final subsublist = sublist.where((element) =>
          element.createdAt.isAfter(temp) &&
          element.createdAt.isBefore(weekLater));
      final total = subsublist.fold(0.0, (previousValue, element) {
        if (element.type == MoneyFlowType.income) {
          return previousValue + element.amount;
        } else {
          return previousValue - element.amount;
        }
      });
      final income = subsublist
          .where((element) => element.type == MoneyFlowType.income)
          .fold(
              0.0, (previousValue, element) => previousValue + element.amount);
      final expense = subsublist
          .where((element) => element.type == MoneyFlowType.expense)
          .fold(
              0.0, (previousValue, element) => previousValue + element.amount);
      list.add(
        ActivityChartData(
            total: total, income: income, expense: expense, date: temp),
      );
      temp = weekLater;
    }
  }

  void calcWeekMetrics(
      DateTime now, List<MoneyFlow> state, List<ActivityChartData> list) {
    final monday = now.subtract(Duration(days: now.weekday - 1)).copyWith(
        hour: 0, minute: 0, second: 0, millisecond: 0, microsecond: 0);
    final sunday = monday.add(const Duration(days: 7));
    final sublist = state.where(
        (mf) => mf.createdAt.isAfter(monday) && mf.createdAt.isBefore(sunday));
    DateTime temp = monday;
    while (temp.isBefore(sunday)) {
      final subsublist = sublist.where((element) =>
          element.createdAt.isAfter(temp) &&
          element.createdAt.isBefore(temp.add(const Duration(days: 1))));
      final total = subsublist.fold(0.0, (previousValue, element) {
        if (element.type == MoneyFlowType.income) {
          return previousValue + element.amount;
        } else {
          return previousValue - element.amount;
        }
      });
      final income = subsublist
          .where((element) => element.type == MoneyFlowType.income)
          .fold(
              0.0, (previousValue, element) => previousValue + element.amount);
      final expense = subsublist
          .where((element) => element.type == MoneyFlowType.expense)
          .fold(
              0.0, (previousValue, element) => previousValue + element.amount);
      list.add(
        ActivityChartData(
            total: total, income: income, expense: expense, date: temp),
      );
      temp = temp.add(const Duration(days: 1));
    }
  }

  void calcTodayMetrics(
      List<MoneyFlow> state, DateTime now, List<ActivityChartData> list) {
    final sublist = state.where((mf) =>
        mf.createdAt.year == now.year &&
        mf.createdAt.month == now.month &&
        mf.createdAt.day == now.day);
    final total = sublist.fold(0.0, (previousValue, element) {
      if (element.type == MoneyFlowType.income) {
        return previousValue + element.amount;
      } else {
        return previousValue - element.amount;
      }
    });
    final income = sublist
        .where((element) => element.type == MoneyFlowType.income)
        .fold(0.0, (previousValue, element) => previousValue + element.amount);
    final expense = sublist
        .where((element) => element.type == MoneyFlowType.expense)
        .fold(0.0, (previousValue, element) => previousValue + element.amount);
    list.add(
      ActivityChartData(
        total: total,
        income: income,
        expense: expense,
        date: now,
      ),
    );
  }
}

class ActivityChartData {
  final num total;
  final num income;
  final num expense;
  final DateTime date;

  ActivityChartData({
    required this.total,
    required this.income,
    required this.expense,
    required this.date,
  });
}
