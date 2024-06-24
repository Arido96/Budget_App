import 'package:budget_app/features/dashboard/domain/models/expense.dart';
import 'package:budget_app/features/dashboard/ui/cubit/dashboard_cubit.dart';
import 'package:budget_app/features/dashboard/ui/cubit/dashboard_state.dart';
import 'package:budget_app/features/shared/category/domain/models/expense_categroy_value.dart';
import 'package:budget_app/injection/injection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({
    super.key,
    required this.month,
  });

  final DateTime month;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            getIt<DashboardCubit>()..loadDataForThisMonth(dateTime: month),
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
    return SafeArea(
      child: BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) {
          if (state.status == DashboardStateStatus.success) {
            return GestureDetector(
              onPanUpdate: (details) {
                // Swiping in right direction.
                if (details.delta.dx > 0) {
                  final nextMonth = DateTime(
                    state.expenses!.month.year,
                    state.expenses!.month.month - 1,
                  );

                  Navigator.of(context).pushReplacement(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          DashboardPage(month: nextMonth),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        const begin = Offset(-1.0, 0.0);
                        const end = Offset.zero;
                        const curve = Curves.ease;

                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));

                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                    ),
                  );
                }

                // Swiping in left direction.
                if (details.delta.dx < 0) {
                  final previouseMonth = DateTime(
                    state.expenses!.month.year,
                    state.expenses!.month.month + 1,
                  );
                  Navigator.of(context).pushReplacement(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          DashboardPage(month: previouseMonth),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        const begin = Offset(1.0, 0.0);
                        const end = Offset.zero;
                        const curve = Curves.ease;

                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));

                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                    ),
                  );
                }
              },
              child: PageView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat('MMMM - yyyy')
                              .format(state.expenses!.month),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        Expanded(
                          child: _DonutChart(
                            categoryWithValue: state.expensesCategoryValue,
                            totalOffAllExpenses:
                                state.expenses?.totalExpenses ?? 0,
                          ),
                        ),
                        SizedBox(
                          height: 100,
                          child: _ExpensesLegend(
                            expenses: state.expensesCategoryValue,
                          ),
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Letze ausgaben',
                          ),
                        ),
                        state.expenses != null
                            ? Expanded(
                                child: _ExpenseDetailView(
                                    expenses: state.expenses!.expenses),
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
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
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(expenses[index].name),
              Text(DateFormat('dd.MM.yyy').format(expenses[index].dateTime))
            ],
          ),
          trailing: Text(
            '\$${expenses[index].value.toString()}',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        );
      },
    );
  }
}

class _DonutChart extends StatelessWidget {
  const _DonutChart({
    required this.categoryWithValue,
    required this.totalOffAllExpenses,
  });

  final List<ExpenseCategoryValue> categoryWithValue;
  final double totalOffAllExpenses;

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
              '$totalOffAllExpenses €',
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
