import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_market_chart/bloc/detail/detail_bloc.dart';
import 'package:stock_market_chart/bloc/search/search_bloc.dart';
import 'package:stock_market_chart/models/search/search.dart';
import 'package:stock_market_chart/pages/detail/detail_screen.dart';

class SearchResultsWidget extends StatelessWidget {
  final StockSearch search;

  const SearchResultsWidget({required this.search, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.search),
      title: Text(search.name),
      subtitle: Text(search.symbol),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => DetailScreen(symbol: search.symbol)));

        // Save event.
        BlocProvider.of<SearchBloc>(context)
            .add(SaveSearch(symbol: search.symbol, name: search.name));

        // Fetch profile event.
        BlocProvider.of<DetailBloc>(context)
            .add(FetchDetailData(symbol: search.symbol));
      },
    );
  }
}
