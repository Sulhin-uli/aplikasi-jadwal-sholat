import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schedule_app/application/jadwal_sholat_provider.dart';
import 'package:schedule_app/application/models/kota_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  initState() {
    super.initState();
    Provider.of<JadwalSholatProvider>(context, listen: false).fetchData();
    // Provider.of<JadwalSholatProvider>(context, listen: false).dataCity();
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider =
        Provider.of<JadwalSholatProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("Title Application"),
        elevation: 0,
      ),
      backgroundColor: Colors.grey[100],
      body: Consumer<JadwalSholatProvider>(
        builder: (context, value, child) => (value.isLoading == false)
            ? CircularProgressIndicator()
            : SingleChildScrollView(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(16),
                      child: DropdownSearch<Kota>(
                        showSearchBox: true,
                        popupItemBuilder: (context, item, isSelected) =>
                            ListTile(
                          title: Text("${item.lokasi}"),
                        ),
                        dropdownSearchDecoration: InputDecoration(
                          labelText: "Kabupaten/Kota",
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 15,
                          ),
                          border: OutlineInputBorder(),
                        ),
                        onFind: (text) async {
                          var response = await Dio()
                              .get("https://imsak.jokiallgames.com/api/kota");
                          return Kota.fromJsonList(response.data["data"]);
                        },
                        // onChanged: (value) => print(value?.toJson()["kota"]),
                        onChanged: (e) {
                          value.showBaseCity(e?.toJson()["kota"]);
                        },
                      ),
                    ),
                    Container(
                      child: value.kota == ""
                          ? Text("Pilih Kabupaten/Kota")
                          : SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              // Data table widget in not scrollable so we have to wrap it in a scroll view when we have a large data set..
                              child: value.data.isEmpty
                                  ? Center(
                                      child: Column(
                                        children: [
                                          CircularProgressIndicator(),
                                          Text(value.dialogError)
                                        ],
                                      ),
                                    )
                                  : Column(
                                      children: [
                                        DataTable(
                                          headingRowColor:
                                              MaterialStateColor.resolveWith(
                                                  (states) => Colors.teal),
                                          columns: [
                                            DataColumn(
                                              label: Text(
                                                'Tanggal',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            DataColumn(
                                              label: Text(
                                                'Imsyak',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            DataColumn(
                                              label: Text(
                                                'Shubuh',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            DataColumn(
                                              label: Text(
                                                'Dzuhur',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            DataColumn(
                                              label: Text(
                                                'Ashar',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            DataColumn(
                                              label: Text(
                                                'Maghrib',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            DataColumn(
                                              label: Text(
                                                'Isa',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                          rows: value.data
                                              .map(
                                                (data) => DataRow(
                                                  cells: [
                                                    DataCell(
                                                      Text(
                                                        data["tanggal"],
                                                        style: TextStyle(
                                                            fontSize: 14),
                                                      ),
                                                    ),
                                                    DataCell(
                                                      Text(
                                                        data["imsak"],
                                                        style: TextStyle(
                                                            fontSize: 14),
                                                      ),
                                                    ),
                                                    DataCell(
                                                      Text(
                                                        data["subuh"],
                                                        style: TextStyle(
                                                            fontSize: 14),
                                                      ),
                                                    ),
                                                    DataCell(
                                                      Text(
                                                        data["dzuhur"],
                                                        style: TextStyle(
                                                            fontSize: 14),
                                                      ),
                                                    ),
                                                    DataCell(
                                                      Text(
                                                        data["ashar"],
                                                        style: TextStyle(
                                                            fontSize: 14),
                                                      ),
                                                    ),
                                                    DataCell(
                                                      Text(
                                                        data["maghrib"],
                                                        style: TextStyle(
                                                            fontSize: 14),
                                                      ),
                                                    ),
                                                    DataCell(
                                                      Text(
                                                        data["isya"],
                                                        style: TextStyle(
                                                            fontSize: 14),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                              .toList(),
                                        ),
                                      ],
                                    ),
                            ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
