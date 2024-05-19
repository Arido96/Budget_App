import 'package:budget_app/features/dashboard/domain/use_cases/load_expenses_for_month_use_case.dart';
import 'package:budget_app/features/dashboard/ui/cubit/dashboard_state.dart';
import 'package:budget_app/shared/Errors/base_error.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit(this._expensesForMonthUseCase) : super(DashboardState());

  final LoadExpensesForMonthUseCase _expensesForMonthUseCase;

  Future<void> loadDataForThisMonth({required DateTime dateTime}) async {
    emit(state.copyWith(status: DashboardStateStatus.inProgress));

    try {
      final result = await _expensesForMonthUseCase(date: dateTime);
      emit(state.copyWith(
          status: DashboardStateStatus.success, expenses: result));
    } on Exception catch (e, _) {
      emit(
        state.copyWith(
          status: DashboardStateStatus.error,
          error: BaseError(message: e.toString()),
        ),
      );
    }
  }
}
