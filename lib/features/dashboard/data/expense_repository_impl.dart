import 'package:budget_app/features/dashboard/domain/interfaces/base_expense_repository.dart';
import 'package:budget_app/features/dashboard/domain/models/expense.dart';
import 'package:budget_app/features/shared/category/interfaces/base_category_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: BaseExpenseRepository)
class ExpenseRepositoryImpl implements BaseExpenseRepository {
  ExpenseRepositoryImpl(
      {required BaseCategoryRepository baseCategoryRepository})
      : _baseCategoryRepository = baseCategoryRepository;

  final BaseCategoryRepository _baseCategoryRepository;

  @override
  Future<List<Expense>> loadExpensesForMonth({required DateTime date}) async {
    final categories = await _baseCategoryRepository.getAll();

    return [
      Expense(
        name: "Lieferando",
        value: 22,
        categroy: categories
            .where((element) => element.name == 'Entertainment')
            .firstOrNull,
        dateTime: DateTime.now(),
      ),
      Expense(
        name: "Netflix",
        value: 5,
        categroy: categories
            .where((element) => element.name == 'Entertainment')
            .firstOrNull,
        dateTime: DateTime.now(),
      ),
      Expense(
        name: "Gaming",
        value: 22,
        categroy: categories
            .where((element) => element.name == 'Entertainment')
            .firstOrNull,
        dateTime: DateTime.now(),
      ),
      Expense(
        name: "Gas",
        value: 50,
        categroy:
            categories.where((element) => element.name == 'Car').firstOrNull,
        dateTime: DateTime.now(),
      ),
      Expense(
        name: "Rent",
        value: 50,
        categroy:
            categories.where((element) => element.name == 'Rent').firstOrNull,
        dateTime: DateTime.now(),
      ),
    ];
  }
}
