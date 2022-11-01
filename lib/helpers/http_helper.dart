import 'package:dio/dio.dart';

class FetchClient {
  Future<Response> fetchData({required Uri uri}) async {
    return await Dio().getUri(uri);
  }

  Future<Response> post({required Uri uri, Map<String, dynamic>? data}) async {
    return await Dio().postUri(uri, data: data);
  }

  // Makes an HTTP request to any endpoint from Financial Modeling Prep API.
  Future<Response> financialModelRequest(String endpoint) async {
    final Uri uri = Uri.https('financialmodelingprep.com', endpoint,
        {'apikey': "848035903ef42a6708718ff5c995a41f"});

    return await Dio().getUri(uri);
  }
}
