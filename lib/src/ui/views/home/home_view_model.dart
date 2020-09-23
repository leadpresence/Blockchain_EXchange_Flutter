import 'package:kanyimax/src/app/generated/locator/locator.dart';
import 'package:kanyimax/src/app/models/blockchain_ticker.model.dart';
import 'package:kanyimax/src/app/services/api_service.dart';
import 'package:kanyimax/src/ui/global/custom_base_view_model.dart';

import 'package:kanyimax/src/app/generated/router/router.gr.dart';

import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends CustomBaseViewModel {
  final ApiService _apiService = locator<ApiService>();
  final NavigationService _navigationService = locator<NavigationService>();

  BlockchainTicker _blockchainTicker;
  BlockchainTicker get blockchainTicker => _blockchainTicker;
  void setBlockchainTicker(BlockchainTicker newValue) {
    _blockchainTicker = newValue;
    notifyListeners();
  }

  Future initialize() async {
    await getTickerData();
  }

  Future getTickerData() async {
    // setBusy(true);
    BlockchainTicker blockchainTicker = await _apiService.getTickerData();
    setBlockchainTicker(blockchainTicker);
    // setBusy(false);
    return blockchainTicker;
  }

  Future navigateToCalculateView() async {
    print('##calling calculateCurrencyScreen');
    await _navigationService
        .pushNamedAndRemoveUntil(Routes.calculateCurrencyScreen);
  }
}
