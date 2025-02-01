import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:stock/data/source/remote/dto/company_info_dto.dart';
import 'package:stock/data/source/remote/dto/intraday_info_dto.dart';

class StockApi {
  static final baseUrl = dotenv.env['BASE_URL'];
  static final apiKey = dotenv.env['API_KEY'];
  final http.Client _client;

  StockApi({http.Client? client}) : _client = (client ?? http.Client());

  // https://www.alphavantage.co/query?function=LISTING_STATUS&apikey=demo
  Future<http.Response> getListings() async {
    var url = Uri.https(baseUrl ?? '', 'query',
        {'function': 'LISTING_STATUS', 'apikey': apiKey ?? ''});
    return await _client.get(url);
  }

  // https://www.alphavantage.co/query?function=OVERVIEW&symbol=IBM&apikey=demo
  Future<CompanyInfoDto> getCompanyInfo({required String symbol}) async {
    var url = Uri.https(baseUrl ?? '', 'query', {
      'function': 'OVERVIEW',
      'symbol': symbol,
      'apikey': apiKey ?? ''
    });
    final response = await _client.get(url);
    return CompanyInfoDto.fromJson(jsonDecode(response.body));
  }

  // https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=IBM&interval=5min&apikey=demo&datatype=csv
  Future<http.Response> getIntradayInfo({required String symbol}) async {
    var url = Uri.https(baseUrl ?? '', 'query', {
      'function': 'TIME_SERIES_INTRADAY',
      'symbol': symbol,
      'interval': '5min',
      'apikey': apiKey ?? '',
      'datatype': 'csv',
    });
    return await _client.get(url);
  }
}
