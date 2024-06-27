import 'package:budget_app/features/shared/expense/domain/interfaces/base_expense_repository.dart';
import 'package:budget_app/features/shared/expense/domain/models/expense.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: BaseExpenseRepository)
class ExpenseRepositoryImpl implements BaseExpenseRepository {
  ExpenseRepositoryImpl();

  final List<Expense> _expenses = List.empty(growable: true);

  @override
  Future<List<Expense>> loadExpensesForMonth({required DateTime date}) async {
    final expensesForMonth = _expenses
        .where((x) =>
            x.dateTime.month == date.month && x.dateTime.year == date.year)
        .toList();

    return expensesForMonth;
  }

  @override
  Future<void> createExpense({required Expense expense}) async {
    _expenses.add(expense);
  }
}
