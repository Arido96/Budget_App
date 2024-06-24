import 'package:budget_app/features/shared/category/domain/models/expense_category.dart';
import 'package:budget_app/features/shared/category/interfaces/base_category_repository.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

@Injectable(as: BaseCategoryRepository)
class CategoryRepositoryImpl implements BaseCategoryRepository {
  @override
  Future<List<ExpenseCategory>> getAll() async {
    return [
      ExpenseCategory(id: const Uuid().v4(), name: 'Rent', color: Colors.red),
      ExpenseCategory(id: const Uuid().v4(), name: 'Car', color: Colors.black),
      ExpenseCategory(
          id: const Uuid().v4(), name: 'Entertainment', color: Colors.blue),
    ];
  }
}
