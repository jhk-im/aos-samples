import 'package:stock/data/csv/company_listings_parser.dart';
import 'package:stock/data/csv/intraday_info_parser.dart';
import 'package:stock/data/mapper/company_mapper.dart';
import 'package:stock/data/source/local/stock_dao.dart';
import 'package:stock/data/source/remote/stock_api.dart';
import 'package:stock/domain/model/company_info.dart';
import 'package:stock/domain/model/company_listing.dart';
import 'package:stock/domain/model/intraday_info.dart';
import 'package:stock/domain/repository/stock_repository.dart';
import 'package:stock/util/result.dart';

class StockRepositoryImpl implements StockRepository {
  final StockApi _api;
  final StockDao _dao;
  final _companyParser = CompanyListingsParser();
  final _intradayParser = IntradayInfoParser();

  StockRepositoryImpl(this._api, this._dao);

  @override
  Future<Result<List<CompanyListing>>> getCompanyListings(
      bool fetchFromRemote, String query) async {
    // 캐시에서 찾기
    final localListings = await _dao.searchCompanyListing(query);

    // 캐시에 있는지 확인
    final isDbEmpty = localListings.isEmpty && query.isEmpty;
    final shouldJustLoadFromCache = !isDbEmpty && !fetchFromRemote;

    // 캐시에서 가져옴
    if (shouldJustLoadFromCache) {
      return Result.success(localListings.map((e) => e.toCompanyListing()).toList());
    }

    // 없는 경우 리모트에서 가져옴
    try {
      final response = await _api.getListings();
      final remoteListings = await _companyParser.parse(response.body);

      // 캐시 비우기
      await _dao.clearCompanyListings();

      // 캐시 추가
      await _dao.insertCompanyListings(
        remoteListings.map((e) => e.toCompanyListingEntity()).toList()
      );

      return Result.success(remoteListings);
    } catch(e) {
      return Result.error(Exception('주식 리스트 로드 실패 : ${e.toString()}'));
    }
  }

  @override
  Future<Result<CompanyInfo>> getCompanyInfo(String symbol) async {
    try {
      final dto = await _api.getCompanyInfo(symbol: symbol);
      return Result.success(dto.toCompanyInfo());
    } catch(e) {
      return Result.error(Exception('회사정보 로드 실패 : ${e.toString()}'));
    }
  }

  @override
  Future<Result<List<IntradayInfo>>> getIntradayInfo(String symbol) async {
    try {
      final response = await _api.getIntradayInfo(symbol: symbol);
      final results = await _intradayParser.parse(response.body);
      return Result.success(results);
    } catch(e) {
      return Result.error(Exception('Intraday 로드 실패 : ${e.toString()}'));
    }
  }
}
