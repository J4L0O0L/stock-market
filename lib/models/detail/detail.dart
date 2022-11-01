import 'stock_chart.dart';
import 'stock_detail.dart';
import 'stock_quote.dart';

class DetailModel {
  final StockDetail stockDetail;
  final StockQuote stockQuote;
  final List<StockChart> stockChart;

  DetailModel({
    required this.stockDetail,
    required this.stockQuote,
    required this.stockChart,
  });
}
