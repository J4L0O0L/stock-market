part of 'detail_bloc.dart';

@immutable
abstract class DetailEvent {}

class FetchDetailData extends DetailEvent {
  final String symbol;
  final StockRange range;

  FetchDetailData({required this.symbol, this.range = StockRange.oneDay});
}
