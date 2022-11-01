import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_market_chart/bloc/detail/detail_bloc.dart';
import 'package:stock_market_chart/bloc/search/search_bloc.dart';
import 'package:stock_market_chart/pages/search/search_screen.dart';

void main() {
  runApp(MultiBlocProvider(
      providers: [
        BlocProvider<SearchBloc>(
          create: (context) => SearchBloc(),
        ),
        BlocProvider<DetailBloc>(
          create: (context) => DetailBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Stock Market',
        theme: ThemeData(brightness: Brightness.dark),
        home: SearchScreen(),
        debugShowCheckedModeBanner: false,
      )));
}
