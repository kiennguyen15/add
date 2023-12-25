import 'package:connection/services/api_service.dart';

import '../models/place.dart';

class PlaceRepository {
  Future<List<City>> getListCity() async {
    List<City> list = [];
    list.add(City(id: 0, name: "--Chọn--"));
    var data = await ApiService().getListCity();
    if (data != null) {
      for (var item in data) {
        var city = City.fromJson(item);
        list.add(city);
      }
    }
    return list;
  }

  Future<List<District>> getListDistrict(int id) async {
    List<District> list = [];
    list.add(District(id: 0, name: "--Chọn--", level: 0));

    var data = await ApiService().getListDistrict(id);
    if (data != null) {
      for (var item in data) {
        var city = District.fromJson(item);
        list.add(city);
      }
    }
    return list;
  }

  Future<List<Ward>> getListWard(int id) async {
    List<Ward> list = [];
    list.add(Ward(id: 0, name: "--Chọn--"));

    var data = await ApiService().getListWard(id);
    if (data != null) {
      for (var item in data) {
        var city = Ward.fromJson(item);
        list.add(city);
      }
    }
    return list;
  }
}
