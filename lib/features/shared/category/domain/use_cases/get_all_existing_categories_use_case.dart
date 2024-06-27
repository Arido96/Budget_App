import 'package:budget_app/features/shared/category/domain/models/expense_category.dart';
import 'package:budget_app/features/shared/category/interfaces/base_category_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class GetAllExistingCategoriesUseCase {
  final BaseCategoryRepository _categoryRepository;

  GetAllExistingCategoriesUseCase(this._categoryRepository);
  Future<List<ExpenseCategory>> call() {
    return _categoryRepository.getAll();
  }
}
