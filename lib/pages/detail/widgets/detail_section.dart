import 'package:flutter/material.dart';
import 'package:stock_market_chart/models/detail/detail.dart';
import 'package:stock_market_chart/models/detail/stock_range.dart';
import 'package:stock_market_chart/pages/detail/widgets/profile.dart';
import 'package:stock_market_chart/shared/colors.dart';

class DetailSection extends StatelessWidget {
  final Color color;
  final DetailModel detail;
  final StockRange range;

  const DetailSection({
    required this.detail,
    required this.color,
    required this.range,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: color,
          centerTitle: true,
          title: Text(detail.stockQuote.name ?? ""),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        backgroundColor: kScaffoldBackground,
        body: SafeArea(
          child: Profile(
            color: color,
            range: range,
            stockProfile: detail.stockDetail,
            stockChart: detail.stockChart,
            stockQuote: detail.stockQuote,
          ),
        ));
  }
}
