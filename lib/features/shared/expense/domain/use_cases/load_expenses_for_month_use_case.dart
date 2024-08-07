import 'package:budget_app/features/shared/expense/domain/interfaces/base_expense_repository.dart';
import 'package:budget_app/features/shared/expense/domain/models/monthly_expenses.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoadExpensesForMonthUseCase {
  LoadExpensesForMonthUseCase(
      {required BaseExpenseRepository expenseRepository})
      : _expenseRepository = expenseRepository;
  final BaseExpenseRepository _expenseRepository;

  Future<MonthlyExpenses> call({required DateTime date}) async {
    final expenses = await _expenseRepository.loadExpensesForMonth(date: date);

    double totalExpenses = 0;
    if (expenses.isNotEmpty) {
      totalExpenses = expenses.map((e) => e.value).reduce((a, b) => a + b);
    }

    return MonthlyExpenses(
      month: date,
      expenses: expenses,
      totalExpenses: totalExpenses,
    );
  }
}
