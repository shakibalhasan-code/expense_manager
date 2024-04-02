import 'package:expense_manager/bar_graph/bar_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../enums/category_enums.dart';
import '../models/expense.dart';

class MyGraph extends StatelessWidget {
  final List<Expense> expenses;

  MyGraph({Key? key, required this.expenses}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Extracting amounts from expenses
    double foodAmount = 0;
    double travelAmount = 0;
    double leisureAmount = 0;
    double workAmount = 0;

    for (var expense in expenses) {
      switch (expense.category) {
        case ExpenseCategory.food:
          foodAmount += expense.amount;
          break;
        case ExpenseCategory.travel:
          travelAmount += expense.amount;
          break;
        case ExpenseCategory.leisure:
          leisureAmount += expense.amount;
          break;
        case ExpenseCategory.work:
          workAmount += expense.amount;
          break;
      }
    }

    // Initializing BarData with extracted amounts
    BarData myBarData = BarData(
      food: foodAmount,
      travel: travelAmount,
      leisure: leisureAmount,
      work: workAmount,
    );
    myBarData.initializeBarData();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10)
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: BarChart(
            BarChartData(
              maxY: 100,
              minY: 0,
              gridData: FlGridData(show: false),
              borderData: FlBorderData(show: false),
              titlesData: FlTitlesData(
                show: true,
                topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                bottomTitles:AxisTitles(sideTitles: SideTitles(showTitles: true, getTitlesWidget: getBottomIcon)),
              ),
              barGroups: myBarData.barData
                  .map(
                    (data) => BarChartGroupData(
                  x: data.x,
                  barRods: [
                    BarChartRodData(toY: data.y,
                      width: 50,
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(2),
                      backDrawRodData: BackgroundBarChartRodData(
                        show: true,
                        toY: 100,
                        color: Colors.grey[200],


                      )

                    ),
                  ],
                ),
              )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}

Widget getBottomIcon(double value, TitleMeta meta) {
  Icon icon;
  switch (value.toInt()) {
    case 0:
      icon = Icon(categoryIcons[ExpenseCategory.food]);
      break;
    case 1:
      icon = Icon(categoryIcons[ExpenseCategory.travel]);
      break;
    case 2:
      icon = Icon(categoryIcons[ExpenseCategory.leisure]);
      break;
    case 3:
      icon = Icon(categoryIcons[ExpenseCategory.work]);
      break;
    default:
    // Handle the case where the value doesn't match any of the keys
      icon = Icon(Icons.error);
  }
  return icon;
}
