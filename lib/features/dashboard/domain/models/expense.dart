import 'package:budget_app/features/shared/category/domain/models/expense_category.dart';

class Expense {
  Expense({
    required this.name,
    required this.value,
    required this.categroy,
    required this.dateTime,
  });

  final String name;
  final double value;
  final DateTime dateTime;
  final ExpenseCategory? categroy;
}
