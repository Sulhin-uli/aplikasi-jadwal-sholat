import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:schedule_app/application/models/kota_model.dart';

class JadwalSholatProvider with ChangeNotifier {
  List<dynamic> _data = [];

  List<dynamic> get data => _data;

  bool isLoading = true;

  String time_now = DateFormat("yyyy-MM-dd", "id_ID").format(DateTime.now());

  String? kota = "";

  String bulan = DateFormat("MM").format(DateTime.now());

  String dialogError = "Loading";

  void showBaseCity(String? id) {
    kota = id;
    fetchData();
    notifyListeners();
    // print(kota);
  }

  void fetchData() async {
    isLoading = true;
    try {
      Uri url =
          Uri.parse("https://imsak.jokiallgames.com/api/jadwal/?kota=$kota");
      var reponse = await http.get(url);
      _data = (json.decode(reponse.body)["data"]);
    } on SocketException {
      dialogError = 'No Internet connection';
    } on HttpException {
      dialogError = "Couldn't find the post";
    } on FormatException {
      dialogError = "Bad response format";
    }
    notifyListeners();
  }
}
