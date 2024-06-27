import 'package:budget_app/features/shared/Errors/base_error.dart';

enum ExpenseStateStatus {
  idle,
  inProgress,
  success,
  error,
}

class ExpenseState {
  ExpenseState({
    this.status = ExpenseStateStatus.idle,
    this.error,
  });

  final ExpenseStateStatus status;

  final BaseError? error;

  ExpenseState copyWith({
    ExpenseStateStatus? status,
    BaseError? error,
  }) {
    return ExpenseState(
      error: error ?? this.error,
      status: status ?? this.status,
    );
  }
}
