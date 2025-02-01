import 'package:stock/domain/model/company_info.dart';
import 'package:stock/domain/model/company_listing.dart';
import 'package:stock/domain/model/intraday_info.dart';
import 'package:stock/util/result.dart';

abstract class StockRepository {
  Future<Result<List<CompanyListing>>> getCompanyListings(
      bool fetchFromRemote, String query);

  Future<Result<CompanyInfo>> getCompanyInfo(String symbol);

  Future<Result<List<IntradayInfo>>> getIntradayInfo(String symbol);
}
