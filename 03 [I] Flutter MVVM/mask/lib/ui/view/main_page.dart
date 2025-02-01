import 'package:flutter/material.dart';
import 'package:mask/ui/widget/remain_stat_list_tile.dart';
import 'package:mask/viewmodel/store_view_model.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<StoreViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('마스크 재고 있는 곳 : ${viewModel.storesLength}곳'),
        actions: [
          IconButton(
            onPressed: () {
              viewModel.getStores();
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: _buildBody(viewModel),
    );
  }

  Widget _buildBody(StoreViewModel viewModel) {
    if (viewModel.isLoading) {
      return loadingWidget();
    }

    if (viewModel.stores.isEmpty) {
      return const Center(
        child: Text('검색된 매장이 없습니다.'),
      );
    }

    return ListView(
      children: viewModel.stores.map((store) {
        return RemainStatListTile(store: store,);
      }).toList(),
    );
  }

  Widget listViewWidget(StoreViewModel viewModel) {
    return ListView(
      children: viewModel.stores.map((store) {
        return RemainStatListTile(store: store,);
      }).toList(),
    );
  }

  Widget loadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text('정보를 가져오는 중'),
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}