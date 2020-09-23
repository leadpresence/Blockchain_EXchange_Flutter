import 'dart:convert';
import '../../models/currency.model.dart';
import '../../models/rates.model.dart';
import 'package:injectable/injectable.dart';
import 'package:kanyimax/src/app/models/currency.model.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class StorageService {
  static const sharedPrefExchangeRateKey = 'exchange_rate_key';
  static const sharedPrefCurrencyKey = 'currency_key';
  static const sharedPrefLastCacheTimeKey = 'cache_time_key';

  Future<List<Rate>> getExchangeRateData() async {
    String data = await _getStringFromPreferences(sharedPrefExchangeRateKey);
    List<Rate> rates = _deserializeRates(data);
    return Future<List<Rate>>.value(rates);
  }

  Future<void> cacheExchangeRateData(List<Rate> data) {
    String jsonString = jsonEncode(data);
    _saveToPreferences(sharedPrefExchangeRateKey, jsonString);
    _resetCacheTimeToNow();
    return null;
  }

  Future<List<Currency>> getFavoriteCurrencies() async {
    String data = await _getStringFromPreferences(sharedPrefCurrencyKey);
    if (data == '') {
      return [];
    }
    return _deserializeCurrencies(data);
  }

  Future<void> saveFavoriteCurrencies(List<Currency> data) {
    String jsonString = _serializeCurrencies(data);
    return _saveToPreferences(sharedPrefCurrencyKey, jsonString);
  }

  Future<bool> isExpiredCache() async {
    final now = DateTime.now();
    DateTime lastUpdate = await _getLastRatesCacheTime();
    Duration difference = now.difference(lastUpdate);
    return difference.inDays > 1;
  }

  List<Rate> _deserializeRates(String data) {
    List<Map> rateList = jsonDecode(data);
    return rateList.map((rateMap) {
      Rate.fromMap(rateMap);
    }).toList();
  }

  List<Currency> _deserializeCurrencies(String data) {
    final codeList = jsonDecode(data);
    List<Currency> list = [];
    for (String code in codeList) {
      list.add(Currency(code));
    }
    return list;
  }

  String _serializeCurrencies(List<Currency> data) {
    final currencies = data.map((currency) => currency.isoCode).toList();
    return jsonEncode(currencies);
  }

  Future<void> _saveToPreferences(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  Future<String> _getStringFromPreferences(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return Future<String>.value(prefs.getString(key) ?? '');
  }

  Future<void> _resetCacheTimeToNow() async {
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(sharedPrefLastCacheTimeKey, timestamp);
  }

  Future<DateTime> _getLastRatesCacheTime() async {
    final prefs = await SharedPreferences.getInstance();
    int timestamp = prefs.getInt(sharedPrefLastCacheTimeKey) ?? 0;
    return DateTime.fromMillisecondsSinceEpoch(timestamp);
  }
}
