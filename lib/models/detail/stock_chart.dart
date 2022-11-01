class StockChart {
  final int date;
  final double price;

  StockChart({required this.date, required this.price});

  static List<StockChart> toList(List<dynamic> items) {
    return items.map((item) => StockChart.fromJson(item)).toList();
  }

  factory StockChart.fromJson(Map<dynamic, dynamic> json) {
    return StockChart(
      date: json['t'],
      price: double.parse(json['c'].toString()),
    );
  }
}
