import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:stock_market_chart/bloc/detail/detail_bloc.dart';
import 'package:stock_market_chart/helpers/text_helper.dart';
import 'package:stock_market_chart/models/detail/stock_chart.dart';

import 'package:stock_market_chart/models/detail/stock_detail.dart';
import 'package:stock_market_chart/models/detail/stock_quote.dart';
import 'package:stock_market_chart/models/detail/stock_range.dart';
import 'package:stock_market_chart/pages/detail/widgets/detail_graph.dart';
import 'package:stock_market_chart/shared/styles.dart';
import 'package:stock_market_chart/widgets/elastic_tabbar.dart';

class Profile extends StatelessWidget {
  final Color color;
  final StockQuote stockQuote;
  final StockDetail stockProfile;
  final List<StockChart>? stockChart;
  final StockRange range;

  const Profile(
      {required this.color,
      required this.stockProfile,
      required this.stockQuote,
      required this.stockChart,
      required this.range,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 26, right: 26, top: 26),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(stockQuote.name ?? '-', style: kProfileCompanyName),
                  _buildPrice(),
                ],
              ),
            ),
            Container(
              height: 250,
              padding: const EdgeInsets.only(top: 26),
              child: stockChart != null
                  ? SimpleTimeSeriesChart(chart: stockChart!, color: color)
                  : const SpinKitThreeBounce(color: Colors.white, size: 25.0),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: ElasticTabbarWidget(
                color: color,
                currentTab: range.index,
                tabs: rangeMap.entries.map((e) => e.value).toList(),
                onChanged: (index) {
                  BlocProvider.of<DetailBloc>(context).add(FetchDetailData(
                      symbol: stockQuote.symbol ?? "",
                      range: rangeMap.entries.elementAt(index).key));
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPrice() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('\$${formatText(stockQuote.price)}', style: priceStyle),
          const SizedBox(height: 8),
          Text(
              '${determineTextBasedOnChange(stockQuote.change ?? 0)}  (${determineTextPercentageBasedOnChange(stockQuote.changesPercentage ?? 0)})',
              style: determineTextStyleBasedOnChange(stockQuote.change ?? 0))
        ],
      ),
    );
  }
}
