import 'package:budget_app/features/dashboard/domain/models/expense.dart';
import 'package:budget_app/features/dashboard/ui/cubit/dashboard_cubit.dart';
import 'package:budget_app/features/dashboard/ui/cubit/dashboard_state.dart';
import 'package:budget_app/features/shared/category/domain/models/expense_categroy_value.dart';
import 'package:budget_app/injection/injection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => getIt<DashboardCubit>()
          ..loadDataForThisMonth(dateTime: DateTime.now()),
        child: Scaffold(body: _DashboardView()));
  }
}

class _DashboardView extends StatefulWidget {
  @override
  State<_DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<_DashboardView> {
  final List<PieChartSectionData> sections = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                  child: _DonutChart(
                      categoryWithValue: state.expensesCategoryValue)),
              SizedBox(
                  height: 100,
                  child:
                      _ExpensesLegend(expenses: state.expensesCategoryValue)),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Letze ausgaben',
                ),
              ),
              Expanded(
                child: _ExpenseDetailView(expenses: state.expenses),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ExpenseDetailView extends StatelessWidget {
  const _ExpenseDetailView({
    required this.expenses,
  });

  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: expenses.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        return ListTile(
          leading: Container(
            width: 20,
            height: 20,
            color: expenses[index].categroy?.color ?? Colors.grey,
          ),
          title: Text(expenses[index].name),
          trailing: Text('\$${expenses[index].value.toString()}'),
        );
      },
    );
  }
}

class _DonutChart extends StatelessWidget {
  const _DonutChart({
    required this.categoryWithValue,
  });

  final List<ExpenseCategoryValue> categoryWithValue;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PieChart(
          PieChartData(
            sections: categoryWithValue
                .map(
                  (e) => PieChartSectionData(
                    value: e.value,
                    color: e.expenseCategory.color,
                    showTitle: false,
                  ),
                )
                .toList(),
            centerSpaceRadius: 100,
            sectionsSpace: 5,
            borderData: FlBorderData(
              show: true,
              border: Border.all(
                width: 10,
                color: Colors.black,
              ),
            ),
          ),
        ),
        Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Total Expenses',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              '${categoryWithValue.map((e) => e.value).reduce((a, b) => a + b).toString()} €',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        )),
      ],
    );
  }
}

class _ExpensesLegend extends StatelessWidget {
  const _ExpensesLegend({
    required this.expenses,
  });

  final List<ExpenseCategoryValue> expenses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: expenses.length,
      itemBuilder: (context, index) {
        return SizedBox(
          child: Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Row(
              children: [
                Container(
                  width: 25,
                  height: 25,
                  color: expenses[index].expenseCategory.color,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(expenses[index].expenseCategory.name),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
