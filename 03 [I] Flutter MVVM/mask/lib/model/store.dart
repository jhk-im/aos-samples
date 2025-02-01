class Store {
  String? addr;
  String? code;
  String? createdAt;
  double? lat;
  double? lng;
  num? km;
  String? name;
  String? remainStat;
  String? stockAt;
  String? type;

  Store(
      {this.addr,
        this.code,
        this.createdAt,
        this.lat,
        this.lng,
        this.name,
        this.remainStat,
        this.stockAt,
        this.type});

  Store.fromJson(Map<String, dynamic> json) {
    addr = json['addr'];
    code = json['code'];
    createdAt = json['created_at'];
    lat = json['lat'];
    lng = json['lng'];
    name = json['name'];
    remainStat = json['remain_stat'];
    stockAt = json['stock_at'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['addr'] = addr;
    data['code'] = code;
    data['created_at'] = createdAt;
    data['lat'] = lat;
    data['lng'] = lng;
    data['name'] = name;
    data['remain_stat'] = remainStat;
    data['stock_at'] = stockAt;
    data['type'] = type;
    return data;
  }

  int getRemainStatNum() {
    switch (remainStat) {
      case 'plenty' : // 100 <= plenty
        return 1;
      case 'some' : // 30 <= some < 100
        return 2;
      case 'few' : // 2 <= few < 30
        return 3;
      case 'empty' : // empty <= 1
        return 4;
    }
    return 0; // null
  }
}

enum RemainStat { plenty, some, few }