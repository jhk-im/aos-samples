import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:stock/data/repository/stock_repository_impl.dart';
import 'package:stock/domain/repository/stock_repository.dart';
import 'package:stock/presentation/company_info/company_info_screen.dart';
import 'package:stock/presentation/company_info/company_info_view_model.dart';
import 'package:stock/presentation/company_listings/company_listings_action.dart';
import 'package:stock/presentation/company_listings/company_listings_view_model.dart';
import 'package:stock/util/constants.dart';
import 'package:provider/provider.dart';

class CompanyListingsScreen extends StatelessWidget {
  const CompanyListingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<CompanyListingsViewModel>();
    final state = viewModel.state;
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (query) {
                viewModel
                    .onAction(CompanyListingsAction.onSearchQueryChange(query));
              },
              decoration: InputDecoration(
                focusedBorder: cOutlineInputBorder(context),
                enabledBorder: cOutlineInputBorder(context),
                labelText: 'Search...',
                labelStyle:
                    TextStyle(color: Theme.of(context).colorScheme.secondary),
              ),
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                viewModel.onAction(const CompanyListingsAction.refresh());
              },
              child: ListView.builder(
                itemCount: state.companies.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        title: Text(state.companies[index].name),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              final repository =
                                  GetIt.instance<StockRepository>();
                              final symbol = state.companies[index].symbol;
                              return ChangeNotifierProvider(
                                create: (_) =>
                                    CompanyInfoViewModel(repository, symbol),
                                child: const CompanyInfoScreen(),
                              );
                            }),
                          );
                        },
                      ),
                      Divider(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
