import 'package:hive/hive.dart';
import 'package:stock/data/source/local/company_listing_entity.dart';

class StockDao {
  static const companyListing = 'companyListing';

  // 추가
  Future<void> insertCompanyListings(
      List<CompanyListingEntity> companyListingEntities) async {
    final box = await Hive.openBox<CompanyListingEntity>('stock.db');
    await box.addAll(companyListingEntities);
  }

  // 클리어
  Future clearCompanyListings() async {
    final box = await Hive.openBox<CompanyListingEntity>('stock.db');
    await box.clear();
  }

  // 검색
  Future<List<CompanyListingEntity>> searchCompanyListing(String query) async {
    final box = await Hive.openBox<CompanyListingEntity>('stock.db');
    List<CompanyListingEntity> companyListing = box.values.toList();
    return companyListing
        .where((element) =>
            element.name.toLowerCase().contains(query.toLowerCase()) ||
            query.toUpperCase() == element.symbol)
        .toList();
  }
}
