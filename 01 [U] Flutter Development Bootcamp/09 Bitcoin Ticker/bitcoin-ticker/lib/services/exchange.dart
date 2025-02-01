import 'networking.dart';

const apiKey = '4D02AD0C-3106-46C4-9298-78BFC7055264';
class ExchangeModel {

  Future<Map<String, dynamic>> getExchange(String currency) async {
    var url = Uri.https('rest.coinapi.io', 'v1/exchangerate/BTC/$currency', {
      'apikey': apiKey,
    });

    NetworkHelper networkHelper = NetworkHelper();
    Map<String, dynamic> exchangeData = await networkHelper.getData(url);

    return exchangeData;
  }
}
