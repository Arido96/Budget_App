import 'package:budget_app/features/shared/expense/domain/models/expense.dart';

abstract class BaseExpenseRepository {
  Future<List<Expense>> loadExpensesForMonth({required DateTime date});
  Future<void> createExpense({required Expense expense});
}
