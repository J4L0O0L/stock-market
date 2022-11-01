import 'package:flutter/material.dart';
import 'package:stock_market_chart/pages/search/widgets/search_section.dart';
import 'package:stock_market_chart/pages/search/widgets/seach_box.dart';
import 'package:stock_market_chart/widgets/header.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            children: [
              StandardHeader(
                title: 'Search',
                subtitle: 'Search Companies',
                action: Container(),
              ),
              const SizedBox(height: 16),
              SearchBoxWidget(),
              const SizedBox(height: 16),
              Expanded(child: SearchSection())
            ],
          ),
        ),
      ),
    );
  }
}
