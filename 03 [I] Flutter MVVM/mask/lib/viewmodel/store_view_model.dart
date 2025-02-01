import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mask/model/store.dart';
import 'package:mask/repository/location_repository.dart';
import 'package:mask/repository/store_repository.dart';

class StoreViewModel extends ChangeNotifier {
  final storeRepository = StoreRepository();
  final locationRepository = LocationRepository();
  List<Store> stores = [];
  var isLoading = true;
  var storesLength = 0;

  StoreViewModel() {
    getStores();
  }

  Future getStores() async {
    isLoading = true;
    notifyListeners();

    Position position = await locationRepository.getLocation();
    stores = await storeRepository.getStore(
      position.latitude, position.longitude
    );
    storesLength = stores.where((element) => element.getRemainStatNum() > 0).length;
    isLoading = false;
    notifyListeners();
  }
}