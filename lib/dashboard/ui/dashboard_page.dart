import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _DashboardView());
  }
}

class _DashboardView extends StatefulWidget {
  @override
  State<_DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<_DashboardView> {
  int touchedIndex = -1;
  final List<PieChartSectionData> sections = [
    PieChartSectionData(
      value: 50,
      title: 'Category 1',
      showTitle: false,
      color: Colors.blue,
      titleStyle: TextStyle(
          fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
    ),
    PieChartSectionData(
      value: 40,
      showTitle: false,
      title: 'Category 2',
      color: Colors.green,
      titleStyle: TextStyle(
          fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
    ),
    PieChartSectionData(
      value: 20,
      title: 'Category 3',
      showTitle: false,
      color: Colors.orange,
      titleStyle: TextStyle(
          fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
    ),
    PieChartSectionData(
      value: 10,
      title: 'Category 4',
      showTitle: false,
      color: Colors.red,
      titleStyle: TextStyle(
          fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Stack(
              children: [
                PieChart(
                  PieChartData(
                    sections: sections,
                    centerSpaceRadius: 100,
                    sectionsSpace: 5,
                    borderData: FlBorderData(
                      show: true,
                      border: Border.all(
                        width: 10,
                        color: Colors.black,
                      ),
                    ),
                    pieTouchData: PieTouchData(
                      enabled: true,
                      touchCallback: (p0, p1) {
                        if (p1?.touchedSection?.touchedSectionIndex == null) {
                          setState(() {
                            touchedIndex = -1;
                          });
                        } else {
                          setState(() {
                            touchedIndex =
                                p1!.touchedSection!.touchedSectionIndex;
                          });
                        }
                      },
                    ),
                  ),
                ),
                Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Total Expenses',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${sections.map((e) => e.value).reduce((a, b) => a + b).toString()} €',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )),
              ],
            ),
          ),
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
                  leading: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    width: touchedIndex == index ? 40 : 20,
                    height: touchedIndex == index ? 40 : 20,
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
  }
}
