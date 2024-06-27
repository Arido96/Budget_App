import 'package:budget_app/features/shared/category/domain/models/expense_category.dart';
import 'package:budget_app/features/shared/Errors/base_error.dart';

enum CategoryStateStatus {
  idle,
  inProgress,
  success,
  error,
}

class CategoryState {
  CategoryState({
    this.status = CategoryStateStatus.idle,
    this.error,
    this.categories = const [],
  });

  final CategoryStateStatus status;
  final BaseError? error;
  final List<ExpenseCategory> categories;

  CategoryState copyWith({
    CategoryStateStatus? status,
    BaseError? error,
    List<ExpenseCategory>? categories,
  }) {
    return CategoryState(
        error: error ?? this.error,
        status: status ?? this.status,
        categories: categories ?? this.categories);
  }
}
