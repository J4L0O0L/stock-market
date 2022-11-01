enum ListType { searchHistory, searchResults }

class StockSearch {
  final String symbol;
  final String name;

  StockSearch({
    required this.symbol,
    required this.name,
  });

  static List<StockSearch> convertToList(List<dynamic> items) {
    return items.map((item) => StockSearch.fromJson(item)).toList();
  }

  factory StockSearch.fromJson(Map<String, dynamic> json) {
    return StockSearch(symbol: json['symbol'], name: json['shortname']);
  }
}
