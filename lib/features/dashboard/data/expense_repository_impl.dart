import 'package:budget_app/features/dashboard/domain/interfaces/base_expense_repository.dart';
import 'package:budget_app/features/dashboard/domain/models/expense.dart';
import 'package:budget_app/features/shared/category/domain/models/expense_category.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: BaseExpenseRepository)
class ExpenseRepositoryImpl implements BaseExpenseRepository {
  @override
  Future<List<Expense>> loadExpensesForMonth({required DateTime date}) async {
    return [
      Expense(
        name: "Lieferando",
        value: 22,
        categroy: ExpenseCategory(
          color: Colors.black38,
          name: 'food',
        ),
      ),
      Expense(
        name: "Netflix",
        value: 5,
        categoryColor: Colors.red,
      ),
      Expense(
        name: "Gaming",
        value: 22,
        categoryColor: Colors.blue,
      ),
      Expense(
        name: "Gas",
        value: 50,
        categoryColor: Colors.green,
      ),
    ];
  }
}
