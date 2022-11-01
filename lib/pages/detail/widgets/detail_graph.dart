import 'package:flutter/material.dart';
import 'package:stock_market_chart/models/detail/stock_chart.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class SimpleTimeSeriesChart extends StatefulWidget {
  final List<StockChart> chart;

  final Color color;

  const SimpleTimeSeriesChart(
      {required this.chart, required this.color, Key? key})
      : super(key: key);

  @override
  State<SimpleTimeSeriesChart> createState() => _SimpleTimeSeriesChartState();
}

class _SimpleTimeSeriesChartState extends State<SimpleTimeSeriesChart> {
  @override
  Widget build(BuildContext context) {
    return SfSparkLineChart.custom(
      color: widget.color,
      axisLineColor: Colors.transparent,
      axisLineDashArray: const [2, 5],
      trackball: const SparkChartTrackball(
          activationMode: SparkChartActivationMode.tap),
      xValueMapper: (int index) => index,
      yValueMapper: (int index) => widget.chart[index].price,
      dataCount: widget.chart.length,
    );
  }
}
