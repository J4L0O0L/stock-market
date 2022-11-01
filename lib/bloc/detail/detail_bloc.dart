import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_market_chart/models/detail/detail.dart';
import 'package:stock_market_chart/models/detail/stock_range.dart';
import 'package:stock_market_chart/respository/detail/detail_client.dart';

part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final _httpClient = DetailClient();

  DetailBloc() : super(DetailInitial()) {
    on<FetchDetailData>(_handleFetchDetailDataEvent);
  }

  Future<void> _handleFetchDetailDataEvent(
    FetchDetailData event,
    Emitter<DetailState> emit,
  ) async {
    emit(DetailLoading());
    try {
      emit(DetailLoaded(
        range: event.range,
        detailModel: await _httpClient.fetchStockData(
            symbol: event.symbol, range: event.range),
      ));
    } on Exception catch (e) {
      emit(DetailLoadingError(error: 'Symbol not supported.'));
    }
  }
}
