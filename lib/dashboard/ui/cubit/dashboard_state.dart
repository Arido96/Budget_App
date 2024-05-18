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
  });

  final DashboardStateStatus status;
  final BaseError? error;

  DashboardState copyWith({
    DashboardStateStatus? status,
    BaseError? error,
  }) {
    return DashboardState(
      error: error ?? this.error,
      status: status ?? this.status,
    );
  }
}
