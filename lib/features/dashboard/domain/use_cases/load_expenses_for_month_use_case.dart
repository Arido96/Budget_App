import 'package:budget_app/features/dashboard/domain/interfaces/base_expense_repository.dart';
import 'package:budget_app/features/dashboard/domain/models/expense.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoadExpensesForMonthUseCase {
  LoadExpensesForMonthUseCase(
      {required BaseExpenseRepository expenseRepository})
      : _expenseRepository = expenseRepository;
  final BaseExpenseRepository _expenseRepository;

  Future<List<Expense>> call({required DateTime date}) {
    return _expenseRepository.loadExpensesForMonth(date: date);
  }
}
