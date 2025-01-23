import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StackedLineChart extends StatefulWidget {
  const StackedLineChart({super.key});

  @override
  State<StackedLineChart> createState() => _StackedLineChartState();
}

class _StackedLineChartState extends State<StackedLineChart> {
  @override
  Widget build(BuildContext context) {
    final List<SalesData> chartData = [
      SalesData(2010, 35),
      SalesData(2011, 28),
      SalesData(2012, 34),
      SalesData(2013, 32),
      SalesData(2014, 40)
    ];

    return Scaffold(
        body: Center(
            child: Container(
                child: SfCartesianChart(
                    primaryXAxis: DateTimeAxis(),
                    series: <ChartSeries>[
          // Renders line chart
          LineSeries<SalesData, DateTime>(
              dataSource: chartData,
              xValueMapper: (SalesData sales, _) => DateTime(sales.year, 1, 1),
              yValueMapper: (SalesData sales, _) => sales.sales)
        ]))));
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final int year;
  final double sales;
}
