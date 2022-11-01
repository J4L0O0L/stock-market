import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_market_chart/bloc/detail/detail_bloc.dart';
import 'package:stock_market_chart/bloc/search/search_bloc.dart';
import 'package:stock_market_chart/models/search/search.dart';
import 'package:stock_market_chart/pages/detail/detail_screen.dart';

class SearchHistoryWidget extends StatelessWidget {
  final StockSearch search;

  const SearchHistoryWidget({
    required this.search,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.history),
      title: Text(search.name),
      subtitle: Text(search.symbol),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => DetailScreen(symbol: search.symbol)));

        BlocProvider.of<DetailBloc>(context)
            .add(FetchDetailData(symbol: search.symbol));
      },
      trailing: IconButton(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          icon: const Icon(Icons.clear),
          onPressed: () {
            BlocProvider.of<SearchBloc>(context)
                .add(DeleteSearch(symbol: search.symbol));
          }),
    );
  }
}
