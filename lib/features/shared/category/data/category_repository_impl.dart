import 'package:budget_app/features/shared/category/domain/models/expense_category.dart';
import 'package:budget_app/features/shared/category/interfaces/base_category_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: BaseCategoryRepository)
class CategoryRepositoryImpl implements BaseCategoryRepository {
  final List<ExpenseCategory> _categories = List.empty(growable: true);

  @override
  Future<List<ExpenseCategory>> getAll() async {
    return _categories;
  }

  @override
  Future<void> createNew({required ExpenseCategory expenseCategory}) async {
    _categories.add(expenseCategory);
  }
}
