// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:budget_app/features/dashboard/data/expense_repository_impl.dart'
    as _i6;
import 'package:budget_app/features/dashboard/domain/interfaces/base_expense_repository.dart'
    as _i5;
import 'package:budget_app/features/dashboard/domain/use_cases/load_expenses_for_month_use_case.dart'
    as _i7;
import 'package:budget_app/features/dashboard/ui/cubit/dashboard_cubit.dart'
    as _i8;
import 'package:budget_app/features/shared/category/data/category_repository_impl.dart'
    as _i4;
import 'package:budget_app/features/shared/category/interfaces/base_category_repository.dart'
    as _i3;
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
    gh.factory<_i3.BaseCategoryRepository>(() => _i4.CategoryRepositoryImpl());
    gh.factory<_i5.BaseExpenseRepository>(() => _i6.ExpenseRepositoryImpl(
        baseCategoryRepository: gh<_i3.BaseCategoryRepository>()));
    gh.factory<_i7.LoadExpensesForMonthUseCase>(() =>
        _i7.LoadExpensesForMonthUseCase(
            expenseRepository: gh<_i5.BaseExpenseRepository>()));
    gh.factory<_i8.DashboardCubit>(
        () => _i8.DashboardCubit(gh<_i7.LoadExpensesForMonthUseCase>()));
    return this;
  }
}
