import 'package:sembast/sembast.dart';
import 'package:stock_market_chart/helpers/http_helper.dart';
import 'package:stock_market_chart/models/search/search.dart';
import 'package:stock_market_chart/helpers/database_helper.dart';

class SearchClient extends FetchClient {
  final StoreRef<int, Map<String, dynamic>> _store =
      intMapStoreFactory.store('search_history');

  // Sembast Database.
  Future<Database> get _database async =>
      await DatabaseManager.instance.database;

  // Returns search results
  Future<List<StockSearch>> searchStock({required String symbol}) async {
    final Uri uri =
        Uri.https('query1.finance.yahoo.com', '/v1/finance/search', {
      'q': symbol,
    });

    final res = await super.fetchData(uri: uri);
    final data = res.data['quotes'];

    return StockSearch.convertToList(data);
  }

  // Gets all the symbols stored.
  Future<List<StockSearch>> fetch() async {
    final finder = Finder(sortOrders: [SortOrder(Field.key, false)]);
    final response = await _store.find(await _database, finder: finder);

    return response
        .map((snapshot) => StockSearch(
            symbol: snapshot.value['symbol'].toString(),
            name: snapshot.value['shortname'].toString()))
        .toList();
  }

  // Saves a symbol in the database.
  Future<void> save({required String symbol, required String name}) async {
    final finder = Finder(sortOrders: [SortOrder(Field.key, false)]);
    final response = await _store.find(await _database, finder: finder);
    if (response.any((element) => element.value['symbol'] == symbol)) return;

    await _store.add(await _database, {'symbol': symbol, 'shortname': name});
  }

  // Deletes a symbol from the database.
  Future<void> delete({required String symbol}) async {
    final finder = Finder(filter: Filter.matches('symbol', symbol));
    final response = await _store.findKey(await _database, finder: finder);
    final deleteFinder = Finder(filter: Filter.byKey(response));

    await _store.delete(await _database, finder: deleteFinder);
  }
}
