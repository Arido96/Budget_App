import 'package:budget_app/features/dashboard/domain/models/expense.dart';
import 'package:budget_app/features/dashboard/ui/cubit/dashboard_cubit.dart';
import 'package:budget_app/features/dashboard/ui/cubit/dashboard_state.dart';
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
              Expanded(child: _DonutChart(expenses: state.expenses)),
              SizedBox(
                  height: 100,
                  child: _ExpensesLegend(expenses: state.expenses)),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Letze ausgaben',
                ),
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: sections.length,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Container(
                        width: 20,
                        height: 20,
                        color: sections[index].color,
                      ),
                      title: Text(sections[index].title),
                      trailing: Text('\$${sections[index].value.toString()}'),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _DonutChart extends StatelessWidget {
  const _DonutChart({
    required this.expenses,
  });

  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PieChart(
          PieChartData(
            sections: expenses
                .map(
                  (e) => PieChartSectionData(
                    value: e.value,
                    color: e.categoryColor,
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
              '${expenses.map((e) => e.value).reduce((a, b) => a + b).toString()} €',
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

  final List<Expense> expenses;

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
                  color: expenses[index].categoryColor,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(expenses[index].name),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
