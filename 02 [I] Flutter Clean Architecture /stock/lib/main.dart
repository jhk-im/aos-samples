import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:stock/data/repository/stock_repository_impl.dart';
import 'package:stock/data/source/local/company_listing_entity.dart';
import 'package:stock/data/source/local/stock_dao.dart';
import 'package:stock/data/source/remote/stock_api.dart';
import 'package:stock/domain/repository/stock_repository.dart';
import 'package:stock/presentation/company_listings/company_listings_screen.dart';
import 'package:stock/presentation/company_listings/company_listings_view_model.dart';
import 'package:stock/util/color_schemes.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // dotenv
  await dotenv.load(fileName: 'assets/.env');
  // hive
  await Hive.initFlutter();
  Hive.registerAdapter(CompanyListingEntityAdapter());
  // repository
  final repository = StockRepositoryImpl(
    StockApi(),
    StockDao(),
  );
  GetIt.instance.registerSingleton<StockRepository>(repository);
  // provider
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CompanyListingsViewModel(
            repository,
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stock',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: darkColorScheme,
      ),
      themeMode: ThemeMode.system,
      home: const CompanyListingsScreen(),
    );
  }
}
