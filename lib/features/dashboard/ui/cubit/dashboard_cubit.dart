import 'package:budget_app/features/shared/expense/domain/models/expense.dart';
import 'package:budget_app/features/shared/expense/domain/use_cases/load_expenses_for_month_use_case.dart';
import 'package:budget_app/features/dashboard/ui/cubit/dashboard_state.dart';
import 'package:budget_app/features/shared/category/domain/models/expense_category.dart';
import 'package:budget_app/features/shared/category/domain/models/expense_category_value.dart';
import 'package:budget_app/features/shared/Errors/base_error.dart';
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
          status: DashboardStateStatus.success,
          expensesCategoryValue: getAllCategoriesWithSum(result.expenses),
          expenses: result));
    } on Exception catch (e, _) {
      emit(
        state.copyWith(
          status: DashboardStateStatus.error,
          error: BaseError(message: e.toString()),
        ),
      );
    }
  }

  List<ExpenseCategoryValue> getAllCategoriesWithSum(List<Expense> expenses) {
    final map = <ExpenseCategory, double>{};

    for (final expense in expenses) {
      if (expense.category != null) {
        if (map.containsKey(expense.category!)) {
          var value = map[expense.category!]!;
          value += expense.value;
          map[expense.category!] = value;
        } else {
          map.addAll(
              <ExpenseCategory, double>{expense.category!: expense.value});
        }
      }
    }

    final result = map.entries.map(
      (e) => ExpenseCategoryValue(expenseCategory: e.key, value: e.value),
    );

    return result.toList();
  }
}
