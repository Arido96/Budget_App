import 'package:budget_app/features/dashboard/domain/models/expense.dart';
import 'package:budget_app/shared/Errors/base_error.dart';

enum DashboardStateStatus {
  idle,
  inProgress,
  success,
  error,
}

class DashboardState {
  DashboardState(
      {this.status = DashboardStateStatus.idle,
      this.error,
      this.expenses = const []});

  final DashboardStateStatus status;
  final List<Expense> expenses;
  final BaseError? error;

  DashboardState copyWith({
    DashboardStateStatus? status,
    BaseError? error,
    List<Expense>? expenses,
  }) {
    return DashboardState(
      error: error ?? this.error,
      status: status ?? this.status,
      expenses: expenses ?? this.expenses,
    );
  }
}
