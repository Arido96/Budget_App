// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:budget_app/features/dashboard/data/expense_repository_impl.dart'
    as _i8;
import 'package:budget_app/features/dashboard/domain/interfaces/base_expense_repository.dart'
    as _i7;
import 'package:budget_app/features/dashboard/domain/use_cases/load_expenses_for_month_use_case.dart'
    as _i10;
import 'package:budget_app/features/dashboard/ui/cubit/dashboard_cubit.dart'
    as _i11;
import 'package:budget_app/features/shared/category/data/category_repository_impl.dart'
    as _i4;
import 'package:budget_app/features/shared/category/domain/use_cases/create_expense_categorie_use_case.dart'
    as _i5;
import 'package:budget_app/features/shared/category/domain/use_cases/get_all_existing_categories_use_case.dart'
    as _i6;
import 'package:budget_app/features/shared/category/interfaces/base_category_repository.dart'
    as _i3;
import 'package:budget_app/features/shared/category/ui/cubit/category_cubit.dart'
    as _i9;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i3.BaseCategoryRepository>(
        () => _i4.CategoryRepositoryImpl());
    gh.factory<_i5.CreateExpenseCategorieUseCase>(() =>
        _i5.CreateExpenseCategorieUseCase(
            categoryRepository: gh<_i3.BaseCategoryRepository>()));
    gh.factory<_i6.GetAllExistingCategoriesUseCase>(() =>
        _i6.GetAllExistingCategoriesUseCase(gh<_i3.BaseCategoryRepository>()));
    gh.factory<_i7.BaseExpenseRepository>(() => _i8.ExpenseRepositoryImpl(
        baseCategoryRepository: gh<_i3.BaseCategoryRepository>()));
    gh.factory<_i9.CategoryCubit>(() => _i9.CategoryCubit(
          gh<_i5.CreateExpenseCategorieUseCase>(),
          gh<_i6.GetAllExistingCategoriesUseCase>(),
        ));
    gh.factory<_i10.LoadExpensesForMonthUseCase>(() =>
        _i10.LoadExpensesForMonthUseCase(
            expenseRepository: gh<_i7.BaseExpenseRepository>()));
    gh.factory<_i11.DashboardCubit>(
        () => _i11.DashboardCubit(gh<_i10.LoadExpensesForMonthUseCase>()));
    return this;
  }
}
