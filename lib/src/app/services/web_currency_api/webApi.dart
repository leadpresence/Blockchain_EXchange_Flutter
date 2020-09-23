import '../../models/rates.model.dart';
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';
import 'dart:convert';
// import 'package:http/http.dart' as http;

@injectable
class WebApi {
  final Client httpClient = Client();
  final String baseUrl = "https://api.exchangeratesapi.io";

  List<Rate> _rateCache;

  Future<List<Rate>> getTickerData() async {
    Response response = await httpClient.get("$baseUrl/latest");

    Rate webCurrencyApi = Rate.fromJson(response.body); // for testing
    final jsonObject = json.decode(response.body); //to be used to format data
    //
    _rateCache = _createRateFromListFromRawMap(jsonObject);
    print("_rateCache:${_rateCache[0].exchangeRate}");
    print("webCurrencyApi:$webCurrencyApi");
    return _rateCache;
  }

// Convert the returned Map to a list formating it into
// the Rate data struct.

  List<Rate> _createRateFromListFromRawMap(Map jsonObject) {
    final Map rate = jsonObject['rates'];
    final String base = jsonObject['base'];
    List<Rate> list = [];

    list.add(Rate(baseCurrency: base, quoteCurrency: base, exchangeRate: 1.5));

    for (var rate in rate.entries) {
      list.add(Rate(
          baseCurrency: base,
          quoteCurrency: rate.key,
          exchangeRate: rate.value as double));
    }
    return list;
  }
  // final _host = 'api.exchangeratesapi.io';

  // final _path = 'latest';

  // final Map<String, String> _headers = {'Accept': 'application/json'};

  // List<Rate> _rateCache;

  // Future<List<Rate>> fetchExchangeRates() async {
  //   if (_rateCache == null) {
  //     print('getting rates from the web');
  //     final uri = Uri.https(_host, _path);
  //     final results = await http.get(uri, headers: _headers);
  //     final jsonObject = json.decode(results.body);
  //     _rateCache = _createRateFromListFromRawMap(jsonObject);
  //   }
  //   return _rateCache;
  // }

  // List<Rate> _createRateFromListFromRawMap(Map jsonObject) {
  //   final Map rate = jsonObject['rates'];
  //   final String base = jsonObject['base'];
  //   List<Rate> list = [];

  //   list.add(Rate(baseCurrency: base, quoteCurrency: base, exchangeRate: 1.5));

  //   for (var rate in rate.entries) {
  //     list.add(Rate(
  //         baseCurrency: base,
  //         quoteCurrency: rate.key,
  //         exchangeRate: rate.value as double));
  //   }
  //   return list;
  // }
}
