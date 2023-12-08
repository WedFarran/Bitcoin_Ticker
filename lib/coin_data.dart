import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  Future<String> getCoinData(String currency, String cryptoCurrency) async {
    var url = Uri.parse(
        'https://rest.coinapi.io/v1/exchangerate/$cryptoCurrency/$currency?apikey=${dotenv.env['KEY']}');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      double rate = convert.jsonDecode(response.body)['rate'];
      String roundedRate = rate.round().toString();

      return roundedRate;
    } else {
      return 'Request failed with status: ${response.statusCode}.';
    }
  }
}
// https://rest.coinapi.io/v1/exchangerate/:asset_id_base/:asset_id_quote

