import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stock/domain/repository/stock_repository.dart';
import 'package:stock/presentation/company_listings/company_listings_action.dart';
import 'package:stock/presentation/company_listings/company_listings_state.dart';
import 'package:rxdart/rxdart.dart';

class CompanyListingsViewModel with ChangeNotifier {
  final StockRepository _repository;

  var _state = const CompanyListingsState();
  CompanyListingsState get state => _state;

  final _debouncedText = BehaviorSubject<String>();

  CompanyListingsViewModel(this._repository) {
    _getCompanyListings();
  }

  void onAction(CompanyListingsAction action) {
    action.when(
      refresh: () => _getCompanyListings(fetchFromRemote: true),
      onSearchQueryChange: (query) {
        // 텍스트 필드 생성
        _debouncedText.add(query);
        _debouncedText
            .debounceTime(const Duration(milliseconds: 500))
            .listen((event) {
          _getCompanyListings(query: event);
        });
      },
    );
  }

  Future _getCompanyListings(
      {bool fetchFromRemote = false, String query = ''}) async {
    _state = state.copyWith(
      isLoading: true,
    );
    notifyListeners();

    final result = await _repository.getCompanyListings(fetchFromRemote, query);
    result.when(success: (listings) {
      _state = state.copyWith(companies: listings);
    }, error: (e) {
      // TODO : error 처리
      // print(e.toString());
    });

    _state = state.copyWith(
      isLoading: false,
    );
    notifyListeners();
  }
}
