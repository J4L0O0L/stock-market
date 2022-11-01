import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_market_chart/bloc/detail/detail_bloc.dart';
import 'package:stock_market_chart/helpers/color_helper.dart';
import 'package:stock_market_chart/pages/detail/widgets/detail_section.dart';
import 'package:stock_market_chart/shared/colors.dart';

import 'package:stock_market_chart/widgets/empty_screen.dart';
import 'package:stock_market_chart/widgets/loading_indicator.dart';

class DetailScreen extends StatelessWidget {
  final String symbol;

  const DetailScreen({
    required this.symbol,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailBloc, DetailState>(
        builder: (BuildContext context, DetailState state) {
      if (state is DetailLoadingError) {
        return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.grey.shade900,
              title: const Text(':('),
            ),
            backgroundColor: kScaffoldBackground,
            body: Center(child: EmptyScreen(message: state.error)));
      }

      if (state is DetailLoaded) {
        return DetailSection(
            detail: state.detailModel,
            range: state.range,
            color: determineColorBasedOnChange(
                state.detailModel.stockDetail.changes ?? 0));
      }

      return const Scaffold(
          backgroundColor: kScaffoldBackground, body: LoadingIndicatorWidget());
    });
  }
}
