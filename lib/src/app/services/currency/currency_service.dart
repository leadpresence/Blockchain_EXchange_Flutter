import '../../models/currency.model.dart';
import '../../models/rates.model.dart';
import 'package:injectable/injectable.dart';
import 'package:kanyimax/src/app/models/currency.model.dart';
import '../storage/storage_service.dart';
import '../../../app/generated/locator/locator.dart';
import '../../services/web_currency_api/webApi.dart';

@injectable
class CurrencyService {
  StorageService _storageService = locator<StorageService>();
  WebApi _webApi = locator<WebApi>();
  static final defaultFavorites = [Currency('EUR'), Currency('USD')];

  Future<List<Rate>> getAllExchangeRates({String base}) async {
    List<Rate> webData = await _webApi.getTickerData();
    if (base != null) {
      return _convertBaseCurrency(base, webData);
    }
    return webData;
  }

  Future<List<Currency>> getFavoriteCurrencies() async {
    final favorites = await _storageService.getFavoriteCurrencies();
    if (favorites == null || favorites.length <= 1) {
      return defaultFavorites;
    }
    return favorites;
  }

  List<Rate> _convertBaseCurrency(String base, List<Rate> remoteData) {
    if (remoteData[0].baseCurrency == base) {
      return remoteData;
    }
    double divisor = remoteData
        .firstWhere((rate) => rate.quoteCurrency == base)
        .exchangeRate;
    return remoteData
        .map((rate) => Rate(
              baseCurrency: base,
              quoteCurrency: rate.quoteCurrency,
              exchangeRate: rate.exchangeRate / divisor,
            ))
        .toList();
  }

  Future<void> saveFavoriteCurrencies(List<Currency> data) async {
    if (data == null || data.length == 0) return;
    await _storageService.saveFavoriteCurrencies(data);
  }
}
