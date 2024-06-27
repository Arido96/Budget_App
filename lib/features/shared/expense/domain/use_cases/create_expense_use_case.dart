import 'package:budget_app/features/shared/expense/domain/interfaces/base_expense_repository.dart';
import 'package:budget_app/features/shared/expense/domain/models/expense.dart';
import 'package:injectable/injectable.dart';

@injectable
class CreateExpenseUseCase {
  CreateExpenseUseCase(this._expenseRepository);
  final BaseExpenseRepository _expenseRepository;

  Future<void> call({required Expense expense}) async {
    await _expenseRepository.createExpense(expense: expense);
  }
}
