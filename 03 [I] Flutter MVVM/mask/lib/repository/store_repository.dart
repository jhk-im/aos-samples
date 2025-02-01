import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:mask/model/store.dart';

class StoreRepository {
  Future<List<Store>> getStore(double lat, double lng) async {
    final List<Store> stores = [];
    var url = Uri.https('gist.githubusercontent.com',
        'junsuk5/bb7485d5f70974deee920b8f0cd1e2f0/raw/063f64d9b343120c2cb01a6555cf9b38761b1d94/sample.json');
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        final jsonResult = jsonDecode(response.body);
        final jsonStores = jsonResult['stores'];
        stores.clear();
        jsonStores.forEach((jsonStore) {
          Store store = Store.fromJson(jsonStore);
          store.km = getKm(store.lat ?? 0, store.lng ?? 0, lat, lng);
          stores.add(store);
        });

        return stores.where((element) => element.getRemainStatNum() > 0).toList()
          ..sort((a, b) => a.km!.compareTo(b.km!));
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  final distance = const Distance();
  double getKm(double sLat, double sLon, double lat, double lng) {
    return distance.as(
        LengthUnit.Kilometer, LatLng(sLat, sLon), LatLng(lat, lng));
  }
}
