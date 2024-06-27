import 'package:budget_app/features/shared/category/ui/cubit/category_state.dart';
import 'package:budget_app/features/shared/category/domain/models/expense_category.dart';
import 'package:budget_app/features/shared/category/domain/use_cases/create_expense_category_use_case.dart';
import 'package:budget_app/features/shared/category/domain/use_cases/get_all_existing_categories_use_case.dart';
import 'package:budget_app/features/shared/Errors/base_error.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit(
      this._createExpenseCategoryUseCase, this._allExistingCategoriesUseCase)
      : super(CategoryState());

  final CreateExpenseCategoryUseCase _createExpenseCategoryUseCase;
  final GetAllExistingCategoriesUseCase _allExistingCategoriesUseCase;

  Future<void> create({required ExpenseCategory category}) async {
    emit(state.copyWith(status: CategoryStateStatus.inProgress));

    try {
      await _createExpenseCategoryUseCase(expenseCategory: category);

      emit(state.copyWith(
        status: CategoryStateStatus.success,
      ));
    } on Exception catch (e, _) {
      emit(
        state.copyWith(
          status: CategoryStateStatus.error,
          error: BaseError(message: e.toString()),
        ),
      );
    }
  }

  Future<void> getAllCategories() async {
    emit(state.copyWith(status: CategoryStateStatus.inProgress));

    try {
      final result = await _allExistingCategoriesUseCase();

      emit(
        state.copyWith(
          status: CategoryStateStatus.success,
          categories: result,
        ),
      );
    } on Exception catch (e, _) {
      emit(
        state.copyWith(
          status: CategoryStateStatus.error,
          error: BaseError(message: e.toString()),
        ),
      );
    }
  }
}
