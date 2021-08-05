class PersonalSongSheet {
  bool? _hasTaste;
  int? _code;
  int? _category;
  List<Result>? _result;

  bool? get hasTaste => _hasTaste;
  int? get code => _code;
  int? get category => _category;
  List<Result>? get result => _result;

  PersonalSongSheet({
      bool? hasTaste, 
      int? code, 
      int? category, 
      List<Result>? result}){
    _hasTaste = hasTaste;
    _code = code;
    _category = category;
    _result = result;
}

  PersonalSongSheet.fromJson(dynamic json) {
    _hasTaste = json["hasTaste"];
    _code = json["code"];
    _category = json["category"];
    if (json["result"] != null) {
      _result = [];
      json["result"].forEach((v) {
        _result?.add(Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["hasTaste"] = _hasTaste;
    map["code"] = _code;
    map["category"] = _category;
    if (_result != null) {
      map["result"] = _result?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Result {
  int? _id;
  int? _type;
  String? _name;
  String? _copywriter;
  String? _picUrl;
  bool? _canDislike;
  int? _trackNumberUpdateTime;
  double? _playCount;
  int? _trackCount;
  bool? _highQuality;
  String? _alg;

  int? get id => _id;
  int? get type => _type;
  String? get name => _name;
  String? get copywriter => _copywriter;
  String? get picUrl => _picUrl;
  bool? get canDislike => _canDislike;
  int? get trackNumberUpdateTime => _trackNumberUpdateTime;
  double? get playCount => _playCount;
  int? get trackCount => _trackCount;
  bool? get highQuality => _highQuality;
  String? get alg => _alg;

  Result({
      int? id, 
      int? type, 
      String? name, 
      String? copywriter, 
      String? picUrl, 
      bool? canDislike, 
      int? trackNumberUpdateTime, 
      double? playCount, 
      int? trackCount, 
      bool? highQuality, 
      String? alg}){
    _id = id;
    _type = type;
    _name = name;
    _copywriter = copywriter;
    _picUrl = picUrl;
    _canDislike = canDislike;
    _trackNumberUpdateTime = trackNumberUpdateTime;
    _playCount = playCount;
    _trackCount = trackCount;
    _highQuality = highQuality;
    _alg = alg;
}

  Result.fromJson(dynamic json) {
    _id = json["id"];
    _type = json["type"];
    _name = json["name"];
    _copywriter = json["copywriter"];
    _picUrl = json["picUrl"];
    _canDislike = json["canDislike"];
    _trackNumberUpdateTime = json["trackNumberUpdateTime"];
    _playCount = json["playCount"];
    _trackCount = json["trackCount"];
    _highQuality = json["highQuality"];
    _alg = json["alg"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["type"] = _type;
    map["name"] = _name;
    map["copywriter"] = _copywriter;
    map["picUrl"] = _picUrl;
    map["canDislike"] = _canDislike;
    map["trackNumberUpdateTime"] = _trackNumberUpdateTime;
    map["playCount"] = _playCount;
    map["trackCount"] = _trackCount;
    map["highQuality"] = _highQuality;
    map["alg"] = _alg;
    return map;
  }
}