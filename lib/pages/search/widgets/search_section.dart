import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:stock_market_chart/bloc/search/search_bloc.dart';
import 'package:stock_market_chart/models/search/search.dart';
import 'package:stock_market_chart/pages/search/widgets/search_results.dart';
import 'package:stock_market_chart/pages/search/widgets/search_history.dart';
import 'package:stock_market_chart/widgets/loading_indicator.dart';
import 'package:stock_market_chart/widgets/message.dart';

class SearchSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
        builder: (BuildContext context, SearchState state) {
      if (state is SearchInitial) {
        BlocProvider.of<SearchBloc>(context).add(FetchSearchHistory());
      }

      if (state is SearchResultsLoadingError) {
        return MessageScreen(message: state.message, action: Container());
      }

      if (state is SearchData) {
        return _buildWrapper(data: state.data, listType: state.listType);
      }

      return Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 4),
        child: LoadingIndicatorWidget(),
      );
    });
  }

  Widget _buildWrapper(
      {required List<StockSearch> data, required ListType listType}) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: data.length,
        itemBuilder: (BuildContext ctx, int i) {
          return listType == ListType.searchHistory
              ? SearchHistoryWidget(search: data[i])
              : SearchResultsWidget(search: data[i]);
        });
  }
}
