import 'package:kanyimax/src/app/models/blockchain_ticker.model.dart';
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';

@injectable
class ApiService {
  final Client httpClient = Client();
  final String baseUrl = "https://www.blockchain.com";

  Future getTickerData() async {
    try {
      Response response = await httpClient.get("$baseUrl/ticker");
      BlockchainTicker blockchainTicker =
          BlockchainTicker.fromJson(response.body);

      return blockchainTicker;
    } on Exception catch (e) {
      print('error=> [ $e ] reaching $baseUrl');
    }
  }
}
