import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cashflow/features/activities/chart_bar_list.dart';

class ActivityChartDataCubit extends Cubit<ActivityChartData?> {
  ActivityChartDataCubit() : super(null);
  set(ActivityChartData? data) => emit(data);
}
