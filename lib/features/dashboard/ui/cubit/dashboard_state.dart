import 'package:budget_app/features/dashboard/domain/models/monthly_expenses.dart';
import 'package:budget_app/features/shared/category/domain/models/expense_categroy_value.dart';
import 'package:budget_app/shared/Errors/base_error.dart';

enum DashboardStateStatus {
  idle,
  inProgress,
  success,
  error,
}

class DashboardState {
  DashboardState({
    this.status = DashboardStateStatus.idle,
    this.error,
    this.expensesCategoryValue = const [],
    this.expenses,
  });

  final DashboardStateStatus status;
  final List<ExpenseCategoryValue> expensesCategoryValue;
  final MonthlyExpenses? expenses;
  final BaseError? error;

  DashboardState copyWith({
    DashboardStateStatus? status,
    BaseError? error,
    List<ExpenseCategoryValue>? expensesCategoryValue,
    MonthlyExpenses? expenses,
  }) {
    return DashboardState(
      error: error ?? this.error,
      status: status ?? this.status,
      expensesCategoryValue:
          expensesCategoryValue ?? this.expensesCategoryValue,
      expenses: expenses ?? this.expenses,
    );
  }
}
