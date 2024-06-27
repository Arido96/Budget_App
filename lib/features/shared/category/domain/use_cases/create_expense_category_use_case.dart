import 'package:budget_app/features/shared/category/domain/models/expense_category.dart';
import 'package:budget_app/features/shared/category/interfaces/base_category_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class CreateExpenseCategoryUseCase {
  CreateExpenseCategoryUseCase(
      {required BaseCategoryRepository categoryRepository})
      : _categoryRepository = categoryRepository;
  final BaseCategoryRepository _categoryRepository;

  Future<void> call({required ExpenseCategory expenseCategory}) async {
    return _categoryRepository.createNew(expenseCategory: expenseCategory);
  }
}
