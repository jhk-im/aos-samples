import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock/presentation/company_info/company_info_state.dart';
import 'package:stock/presentation/company_info/company_info_view_model.dart';
import 'package:stock/presentation/company_info/components/stock_chart.dart';
import 'package:stock/util/constants.dart';

class CompanyInfoScreen extends StatelessWidget {
  const CompanyInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<CompanyInfoViewModel>();
    final state = viewModel.state;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Stack(
          children: [
            if (state.errorMessage != null)
              Center(
                child: Text(
                  state.errorMessage!,
                ),
              ),
            if (state.isLoading)
              const Center(
                child: CircularProgressIndicator(),
              ),
            if (!state.isLoading && state.errorMessage == null)
              _buildBody(context, state),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, CompanyInfoState state) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            state.companyInfo?.name ?? '',
            style: cLargeTextStyle,
          ),
          Text(
            state.companyInfo?.symbol ?? '',
            style: cMediumItalicTextStyle,
          ),
          const Divider(),
          Text(
            'Industry: ${state.companyInfo?.industry ?? ''}',
            style: cMediumTextStyle,
          ),
          const Divider(),
          Text(
            'Country: ${state.companyInfo?.country ?? ''}',
            style: cMediumTextStyle,
          ),
          const Divider(),
          Text(
            state.companyInfo?.description ?? '',
            style: cSmallTextStyle,
          ),
          const SizedBox(
            height: 16.0,
          ),
          const Text(
            'Market Summary',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 16.0,
          ),
          if (state.intradayInfo.isNotEmpty)
            StockChart(
              intradayInfo: state.intradayInfo,
              graphColor: Theme.of(context).colorScheme.primary,
              textColor: Theme.of(context).colorScheme.onSurface,
            ),
        ],
      ),
    );
  }
}
