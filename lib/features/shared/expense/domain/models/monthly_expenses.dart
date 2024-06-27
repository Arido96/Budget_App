import 'package:budget_app/features/shared/expense/domain/models/expense.dart';

class MonthlyExpenses {
  MonthlyExpenses({
    required this.month,
    required this.expenses,
    required this.totalExpenses,
  });

  final DateTime month;
  final List<Expense> expenses;
  final double totalExpenses;
}
