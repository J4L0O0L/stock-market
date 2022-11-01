import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_market_chart/bloc/search/search_bloc.dart';
import 'package:stock_market_chart/shared/colors.dart';

class SearchBoxWidget extends StatelessWidget {
  Timer? searchOnStoppedTyping;

  _onChangeHandler(String value, BuildContext context) {
    searchOnStoppedTyping?.cancel();

    if (value.isNotEmpty) {
      const duration = Duration(milliseconds: 800);

      searchOnStoppedTyping = Timer(
          duration,
          () => BlocProvider.of<SearchBloc>(context)
              .add(FetchSearchResults(symbol: value.toUpperCase())));
    } else {
      BlocProvider.of<SearchBloc>(context).add(FetchSearchHistory());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 46,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: kGray,
        ),
        child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.search),
              const SizedBox(width: 8),
              Expanded(
                  child: TextFormField(
                      textAlign: TextAlign.start,
                      decoration: const InputDecoration(
                        hintText: 'Search',
                        hintStyle: TextStyle(fontSize: 15.5),
                        border: InputBorder.none,
                      ),
                      onChanged: (value) => _onChangeHandler(value, context))),
            ]));
  }
}
