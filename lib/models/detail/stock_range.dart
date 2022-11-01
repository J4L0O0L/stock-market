enum StockRange {
  oneDay,
  oneWeek,
  oneMonth,
  threeMonth,
  oneYear,
  fiveYear,
}

final Map<StockRange, String> rangeMap = {
  StockRange.oneDay: "1D",
  StockRange.oneWeek: "1W",
  StockRange.oneMonth: "1M",
  StockRange.threeMonth: "3M",
  StockRange.oneYear: "1Y",
  StockRange.fiveYear: "5Y"
};

extension RangeHandler on StockRange {
  DateTime get getFromDate {
    var date = DateTime.now();
    switch (this) {
      case StockRange.oneDay:
        return DateTime(date.year, date.month, date.day - 1);
      case StockRange.oneWeek:
        return DateTime(date.year, date.month, date.day - 7);
      case StockRange.oneMonth:
        return DateTime(date.year, date.month - 1, date.day);
      case StockRange.threeMonth:
        return DateTime(date.year, date.month - 3, date.day);
      case StockRange.oneYear:
        return DateTime(date.year - 1, date.month, date.day);
      case StockRange.fiveYear:
        return DateTime(date.year - 5, date.month, date.day);
      default:
        return date;
    }
  }

  String get getQueryPath {
    switch (this) {
      case StockRange.oneDay:
        return "5/minute";
      case StockRange.oneWeek:
        return "10/minute";
      case StockRange.oneMonth:
        return "1/hour";
      case StockRange.threeMonth:
      case StockRange.oneYear:
        return "1/day";
      case StockRange.fiveYear:
        return "3/day";
      default:
        return "";
    }
  }
}
