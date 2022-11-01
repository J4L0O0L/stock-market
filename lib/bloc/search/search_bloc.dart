import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_market_chart/models/search/search.dart';
import 'package:stock_market_chart/respository/search/search_client.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final _client = SearchClient();

  SearchBloc() : super(SearchInitial()) {
    on<FetchSearchHistory>(_handleFetchSearchHistoryEvent);
    on<SaveSearch>(_handleSaveSearchEvent);
    on<DeleteSearch>(_handleDeleteSearchEvent);
    on<FetchSearchResults>(_handleFetchSearchResultsEvent);
  }

  Future<void> _handleFetchSearchHistoryEvent(
    FetchSearchHistory event,
    Emitter<SearchState> emit,
  ) async {
    await _fetchSavedSearches(emit);
  }

  Future<void> _handleSaveSearchEvent(
    SaveSearch event,
    Emitter<SearchState> emit,
  ) async {
    await _client.save(symbol: event.symbol, name: event.name);
    await _fetchSavedSearches(emit);
  }

  Future<void> _handleDeleteSearchEvent(
    DeleteSearch event,
    Emitter<SearchState> emit,
  ) async {
    await _client.delete(symbol: event.symbol);
    await _fetchSavedSearches(emit);
  }

  Future<void> _handleFetchSearchResultsEvent(
    FetchSearchResults event,
    Emitter<SearchState> emit,
  ) async {
    emit(SearchLoading());
    try {
      final data = await _client.searchStock(symbol: event.symbol);
      emit(data.isEmpty
          ? SearchResultsLoadingError(message: 'No results were found')
          : SearchData(data: data, listType: ListType.searchResults));
    } catch (e) {
      emit(SearchResultsLoadingError(message: 'There was an error loading'));
    }
  }

  _fetchSavedSearches(Emitter<SearchState> emit) async {
    emit(SearchLoading());

    final data = await _client.fetch();

    emit(data.isEmpty
        ? SearchResultsLoadingError(message: 'No recent searches')
        : SearchData(data: data, listType: ListType.searchHistory));
  }
}
