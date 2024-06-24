import 'package:budget_app/features/shared/category/domain/models/expense_category.dart';

class ExpenseCategoryValue {
  ExpenseCategoryValue({required this.expenseCategory, required this.value});
  final ExpenseCategory expenseCategory;
  final double value;
}
