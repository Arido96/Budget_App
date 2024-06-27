import 'package:budget_app/features/shared/category/domain/models/expense_category.dart';

abstract class BaseCategoryRepository {
  Future<List<ExpenseCategory>> getAll();
  Future<void> createNew({required ExpenseCategory expenseCategory});
}
