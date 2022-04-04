class Kota {
  String? kota;
  String? lokasi;

  Kota({
    this.kota,
    this.lokasi,
  });

  Kota.fromJson(Map<String, dynamic> json) {
    kota = json['kota'];
    lokasi = json['lokasi'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['kota'] = kota;
    data['lokasi'] = lokasi;
    return data;
  }

  static List<Kota> fromJsonList(List data) {
    if (data == null || data.length == 0) return [];
    return data.map((e) => Kota.fromJson(e)).toList();
  }

  @override
  String toString() => lokasi!;
}
