import 'package:budget_app/features/dashboard/domain/models/expense.dart';

abstract class BaseExpenseRepository {
  Future<List<Expense>> loadExpensesForMonth({required DateTime date});
}
