import 'package:budget_app/features/shared/expense/domain/models/expense.dart';
import 'package:budget_app/features/shared/expense/domain/use_cases/create_expense_use_case.dart';
import 'package:budget_app/features/shared/expense/cubit/expense_state.dart';
import 'package:budget_app/features/shared/Errors/base_error.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class ExpenseCubit extends Cubit<ExpenseState> {
  ExpenseCubit(this._createExpenseUseCase) : super(ExpenseState());

  final CreateExpenseUseCase _createExpenseUseCase;

  Future<void> createExpense({required Expense expense}) async {
    emit(state.copyWith(status: ExpenseStateStatus.inProgress));

    try {
      await _createExpenseUseCase(expense: expense);

      emit(
        state.copyWith(
          status: ExpenseStateStatus.success,
        ),
      );
    } on Exception catch (e, _) {
      emit(
        state.copyWith(
          status: ExpenseStateStatus.error,
          error: BaseError(message: e.toString()),
        ),
      );
    }
  }
}
