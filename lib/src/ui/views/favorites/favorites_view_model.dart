import 'package:kanyimax/src/ui/global/custom_base_view_model.dart';
import 'package:kanyimax/src/app/generated/locator/locator.dart';
import 'package:kanyimax/src/app/services/api_service.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../app/models/rates.model.dart';
import '../../../app/models/currency.model.dart';
import '../../../app/services/currency/currency_service.dart';
import '../../../app/generated/locator/locator.dart';
import '../../../app/utils/iso_data.dart';
import 'package:kanyimax/src/app/generated/router/router.gr.dart';

class FavoritesViewModel extends CustomBaseViewModel {
  /**
   * IMPORT NECESSARY SERVICES NEED FOR THIS CLASS
   */
  final ApiService _apiService = locator<ApiService>();
  final CurrencyService _currencyService = locator<CurrencyService>();
  final NavigationService _navigationService = locator<NavigationService>();

  List<FavoritePresentation> _choices = [];
  List<Currency> _favorites = [];

  List<FavoritePresentation> get choices => _choices;

  Future initialize() async {
    loadData();
  }

  void loadData() async {
    final rates = await _currencyService.getAllExchangeRates();
    _favorites = await _currencyService.getFavoriteCurrencies();
    _prepareChoicePresentation(rates);
    notifyListeners();
  }

  void _prepareChoicePresentation(List<Rate> rates) {
    List<FavoritePresentation> list = [];
    for (Rate rate in rates) {
      String code = rate.quoteCurrency;
      bool isFavorite = _getFavoriteStatus(code);
      list.add(FavoritePresentation(
        flag: IsoData.flagOf(code),
        alphabeticCode: code,
        longName: IsoData.longNameOf(code),
        isFavorite: isFavorite,
      ));
    }
    _choices = list;
  }

  bool _getFavoriteStatus(String code) {
    for (Currency currency in _favorites) {
      if (code == currency.isoCode) return true;
    }
    return false;
  }

  void toggleFavoriteStatus(int choiceIndex) {
    final isFavorite = !_choices[choiceIndex].isFavorite;
    final code = _choices[choiceIndex].alphabeticCode;

    // update display
    _choices[choiceIndex].isFavorite = isFavorite;

    // update favorite list
    if (isFavorite) {
      _addToFavorites(code);
    } else {
      _removeFromFavorites(code);
    }

    notifyListeners();
  }

  void _addToFavorites(String alphabeticCode) {
    _favorites.add(Currency(alphabeticCode));
    _currencyService.saveFavoriteCurrencies(_favorites);
  }

  void _removeFromFavorites(String alphabeticCode) {
    for (final currency in _favorites) {
      if (currency.isoCode == alphabeticCode) {
        _favorites.remove(currency);
        break;
      }
    }
    _currencyService.saveFavoriteCurrencies(_favorites);
  }

  Future navigateToHomeView() async {
    print('##calling calculateCurrencyScreen');
    await _navigationService.pushNamedAndRemoveUntil(Routes.homeView);
  }
}

class FavoritePresentation {
  final String flag;
  final String alphabeticCode;
  final String longName;
  bool isFavorite;

  FavoritePresentation({
    this.flag,
    this.alphabeticCode,
    this.longName,
    this.isFavorite,
  });
}
