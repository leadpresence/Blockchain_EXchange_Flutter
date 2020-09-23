import 'package:kanyimax/src/ui/global/custom_base_view_model.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:kanyimax/src/app/generated/router/router.gr.dart';

import '../../../app/models/currency_presentation.dart';
import '../../../app/models/rates.model.dart';
import '../../../app/models/currency.model.dart';
import '../../../app/services/currency/currency_service.dart';
import '../../../app/generated/locator/locator.dart';
import '../../../app/utils/iso_data.dart';

class CalculateScreenViewModel extends CustomBaseViewModel {
  final CurrencyService _currencyService = locator<CurrencyService>();
  final NavigationService _navigationService = locator<NavigationService>();

  //initialize currency string formating
  CurrencyPresentation _baseCurrency = defaultBaseCurrency;
  CurrencyPresentation get baseCurrency => _baseCurrency;
  //initilize quoted currencies
  List<CurrencyPresentation> _quoteCurrencies = [];
  List<CurrencyPresentation> get quoteCurrencies => _quoteCurrencies;
  List<Rate> _rates = [];

  static final CurrencyPresentation defaultBaseCurrency = CurrencyPresentation(
      flag: '', alphabeticCode: '', longName: '', amount: '');

  Future initialize() async {
    loadData();
  }

  void loadData() async {
    await _loadCurrencies();
    _rates = await _currencyService.getAllExchangeRates(
        base: _baseCurrency.alphabeticCode);
    notifyListeners();
  }

  Future<void> _loadCurrencies() async {
    final currencies = await _currencyService.getFavoriteCurrencies();
    _baseCurrency = _loadBaseCurrency(currencies);
    _quoteCurrencies = _loadQuoteCurrencies(currencies);
  }

  CurrencyPresentation _loadBaseCurrency(List<Currency> currencies) {
    if (currencies.length == 0) {
      return defaultBaseCurrency;
    }
    String code = currencies[0].isoCode;
    return CurrencyPresentation(
        flag: IsoData.flagOf(code),
        alphabeticCode: code,
        longName: IsoData.longNameOf(code),
        amount: '');
  }

//format the list of currencies for the view
  List<CurrencyPresentation> _loadQuoteCurrencies(List<Currency> currencies) {
    List<CurrencyPresentation> quotes = [];
    for (int i = 1; i < currencies.length; i++) {
      String code = currencies[i].isoCode;
      quotes.add(CurrencyPresentation(
        flag: IsoData.flagOf(code),
        alphabeticCode: code,
        longName: IsoData.longNameOf(code),
        amount: currencies[i].amount.toStringAsFixed(2),
      ));
    }
    return quotes;
  }

  //calculate the exchanges rates on currencies
  void calculateExchange(String baseAmount) async {
    double amount;
    try {
      amount = double.parse(baseAmount);
    } catch (e) {
      _updateCurrenciesFor(0);
      notifyListeners();
      return null;
    }

    _updateCurrenciesFor(amount);

    notifyListeners();
  }

  void _updateCurrenciesFor(double baseAmount) {
    for (CurrencyPresentation c in _quoteCurrencies) {
      for (Rate r in _rates) {
        if (c.alphabeticCode == r.quoteCurrency) {
          c.amount = (baseAmount * r.exchangeRate).toStringAsFixed(2);
          break;
        }
      }
    }
  }

  Future refreshFavorites() async {
    await _loadCurrencies();
    notifyListeners();
  }

  Future setNewBaseCurrency(int quoteCurrencyIndex) async {
    _quoteCurrencies.add(_baseCurrency);
    _baseCurrency = _quoteCurrencies[quoteCurrencyIndex];
    _quoteCurrencies.removeAt(quoteCurrencyIndex);
    await _currencyService
        .saveFavoriteCurrencies(_convertPresentationToCurrency());
    loadData();
  }

  List<Currency> _convertPresentationToCurrency() {
    List<Currency> currencies = [];
    currencies.add(Currency(_baseCurrency.alphabeticCode));
    for (CurrencyPresentation currency in _quoteCurrencies) {
      currencies.add(Currency(currency.alphabeticCode));
    }
    return currencies;
  }

  //navigate to home
  Future navigateToHomeView() async {
    await _navigationService.pushNamedAndRemoveUntil(Routes.homeView);
  }
}
