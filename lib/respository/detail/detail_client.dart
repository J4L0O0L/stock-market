import 'package:intl/intl.dart';
import 'package:stock_market_chart/models/detail/detail.dart';
import 'package:stock_market_chart/models/detail/stock_chart.dart';
import 'package:stock_market_chart/models/detail/stock_detail.dart';

import 'package:stock_market_chart/helpers/http_helper.dart';
import 'package:stock_market_chart/models/detail/stock_quote.dart';
import 'package:stock_market_chart/models/detail/stock_range.dart';

class DetailClient extends FetchClient {
  Future<DetailModel> fetchStockData(
      {required String symbol, required StockRange range}) async {
    final stockProfile =
        await super.financialModelRequest('/api/v3/company/profile/$symbol');
    final stockQuote =
        await super.financialModelRequest('/api/v3/quote/$symbol');

    final DateTime date = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');

    final Uri uri = Uri.https(
        "api.polygon.io",
        '/v2/aggs/ticker/$symbol/range/${range.getQueryPath}/${formatter.format(range.getFromDate)}/${formatter.format(date)}',
        {
          'adjusted': "true",
          'sort': "asc",
          'apiKey': "YLPNyMlnLCC07PQFGCGrJDp_L3DzwAkR"
        });

    final stockChart = await super.fetchData(uri: uri);

    return DetailModel(
        stockQuote: StockQuote.fromJson(stockQuote.data[0]),
        stockDetail: StockDetail.fromJson(stockProfile.data['profile']),
        stockChart: StockChart.toList(stockChart.data['results'])); //));
  }
}
