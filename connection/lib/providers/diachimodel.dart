import 'package:connection/repositories/place_repository.dart';
import 'package:flutter/material.dart';

import '../models/place.dart';

class DiaChiModel with ChangeNotifier {
  List<City> listCity = [];
  List<District> listDistrict = [];
  List<Ward> listWard = [];
  int curCityiD = 0;
  int curDistId = 0;
  int curWardId = 0;
  String address = "";
  Future<void> initialize(int Cid, int Did, int Wid) async {
    curCityiD = Cid;
    curDistId = Did;
    curWardId = Wid;
    final repo = PlaceRepository();
    listCity = await repo.getListCity();
    if (curCityiD != 0) {
      listDistrict = await repo.getListDistrict(curCityiD);
    }
    if (curDistId != 0) {
      listWard = await repo.getListWard(curDistId);
    }
  }

  Future<void> setCity(int Cid) async {
    if (Cid != curCityiD) {
      curCityiD = Cid;
      curDistId = 0;
      curWardId = 0;
      final repo = PlaceRepository();
      listDistrict = await repo.getListDistrict(curCityiD);
      listWard.clear();
    }
  }

  Future<void> setDistrict(int Did) async {
    if (Did != curDistId) {
      curDistId = Did;
      curWardId = 0;
      final repo = PlaceRepository();
      listWard = await repo.getListWard(curDistId);
      listWard.clear();
    }
  }

  Future<void> setWard(int Wid) async {
    if (Wid != curDistId) {
      curWardId = Wid;
    }
  }
}
