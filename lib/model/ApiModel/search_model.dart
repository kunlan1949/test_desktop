// class SearchModel {
//   Result? _result;
//   int? _code;
//
//   Result? get result => _result;
//   int? get code => _code;
//
//   SearchModel({
//       Result? result,
//       int? code}){
//     _result = result;
//     _code = code;
// }
//
//   SearchModel.fromJson(dynamic json) {
//     _result = json["result"] != null ? Result.fromJson(json["result"]) : null;
//     _code = json["code"];
//   }
//
//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     if (_result != null) {
//       map["result"] = _result?.toJson();
//     }
//     map["code"] = _code;
//     return map;
//   }
//
// }
//
// class Result {
//   List<Songs>? _songs;
//   bool? _hasMore;
//   int? _songCount;
//
//   List<Songs>? get songs => _songs;
//   bool? get hasMore => _hasMore;
//   int? get songCount => _songCount;
//
//   Result({
//       List<Songs>? songs,
//       bool? hasMore,
//       int? songCount}){
//     _songs = songs;
//     _hasMore = hasMore;
//     _songCount = songCount;
// }
//
//   Result.fromJson(dynamic json) {
//     if (json["songs"] != null) {
//       _songs = [];
//       json["songs"].forEach((v) {
//         _songs?.add(Songs.fromJson(v));
//       });
//     }
//     _hasMore = json["hasMore"];
//     _songCount = json["songCount"];
//   }
//
//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     if (_songs != null) {
//       map["songs"] = _songs?.map((v) => v.toJson()).toList();
//     }
//     map["hasMore"] = _hasMore;
//     map["songCount"] = _songCount;
//     return map;
//   }
//
// }
//
// class Songs {
//   int? _id;
//   String? _name;
//   List<Artists>? _artists;
//   Album? _album;
//   int? _duration;
//   int? _copyrightId;
//   int? _status;
//   List<dynamic>? _alias;
//   int? _rtype;
//   int? _ftype;
//   int? _mvid;
//   int? _fee;
//   dynamic? _rUrl;
//   int? _mark;
//
//   int? get id => _id;
//   String? get name => _name;
//   List<Artists>? get artists => _artists;
//   Album? get album => _album;
//   int? get duration => _duration;
//   int? get copyrightId => _copyrightId;
//   int? get status => _status;
//   List<dynamic>? get alias => _alias;
//   int? get rtype => _rtype;
//   int? get ftype => _ftype;
//   int? get mvid => _mvid;
//   int? get fee => _fee;
//   dynamic? get rUrl => _rUrl;
//   int? get mark => _mark;
//
//   Songs({
//       int? id,
//       String? name,
//       List<Artists>? artists,
//       Album? album,
//       int? duration,
//       int? copyrightId,
//       int? status,
//       List<dynamic>? alias,
//       int? rtype,
//       int? ftype,
//       int? mvid,
//       int? fee,
//       dynamic? rUrl,
//       int? mark}){
//     _id = id;
//     _name = name;
//     _artists = artists;
//     _album = album;
//     _duration = duration;
//     _copyrightId = copyrightId;
//     _status = status;
//     _alias = alias;
//     _rtype = rtype;
//     _ftype = ftype;
//     _mvid = mvid;
//     _fee = fee;
//     _rUrl = rUrl;
//     _mark = mark;
// }
//
//   Songs.fromJson(dynamic json) {
//     _id = json["id"];
//     _name = json["name"];
//     if (json["artists"] != null) {
//       _artists = [];
//       json["artists"].forEach((v) {
//         _artists?.add(Artists.fromJson(v));
//       });
//     }
//     _album = json["album"] != null ? Album.fromJson(json["album"]) : null;
//     _duration = json["duration"];
//     _copyrightId = json["copyrightId"];
//     _status = json["status"];
//     if (json["alias"] != null) {
//       _alias = [];
//       json["alias"].forEach((v) {
//         _alias?.add(dynamic.fromJson(v));
//       });
//     }
//     _rtype = json["rtype"];
//     _ftype = json["ftype"];
//     _mvid = json["mvid"];
//     _fee = json["fee"];
//     _rUrl = json["rUrl"];
//     _mark = json["mark"];
//   }
//
//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["id"] = _id;
//     map["name"] = _name;
//     if (_artists != null) {
//       map["artists"] = _artists?.map((v) => v.toJson()).toList();
//     }
//     if (_album != null) {
//       map["album"] = _album?.toJson();
//     }
//     map["duration"] = _duration;
//     map["copyrightId"] = _copyrightId;
//     map["status"] = _status;
//     if (_alias != null) {
//       map["alias"] = _alias?.map((v) => v.toJson()).toList();
//     }
//     map["rtype"] = _rtype;
//     map["ftype"] = _ftype;
//     map["mvid"] = _mvid;
//     map["fee"] = _fee;
//     map["rUrl"] = _rUrl;
//     map["mark"] = _mark;
//     return map;
//   }
//
// }
//
// class Album {
//   int? _id;
//   String? _name;
//   Artist? _artist;
//   int? _publishTime;
//   int? _size;
//   int? _copyrightId;
//   int? _status;
//   int? _picId;
//   int? _mark;
//
//   int? get id => _id;
//   String? get name => _name;
//   Artist? get artist => _artist;
//   int? get publishTime => _publishTime;
//   int? get size => _size;
//   int? get copyrightId => _copyrightId;
//   int? get status => _status;
//   int? get picId => _picId;
//   int? get mark => _mark;
//
//   Album({
//       int? id,
//       String? name,
//       Artist? artist,
//       int? publishTime,
//       int? size,
//       int? copyrightId,
//       int? status,
//       int? picId,
//       int? mark}){
//     _id = id;
//     _name = name;
//     _artist = artist;
//     _publishTime = publishTime;
//     _size = size;
//     _copyrightId = copyrightId;
//     _status = status;
//     _picId = picId;
//     _mark = mark;
// }
//
//   Album.fromJson(dynamic json) {
//     _id = json["id"];
//     _name = json["name"];
//     _artist = json["artist"] != null ? Artist.fromJson(json["artist"]) : null;
//     _publishTime = json["publishTime"];
//     _size = json["size"];
//     _copyrightId = json["copyrightId"];
//     _status = json["status"];
//     _picId = json["picId"];
//     _mark = json["mark"];
//   }
//
//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["id"] = _id;
//     map["name"] = _name;
//     if (_artist != null) {
//       map["artist"] = _artist?.toJson();
//     }
//     map["publishTime"] = _publishTime;
//     map["size"] = _size;
//     map["copyrightId"] = _copyrightId;
//     map["status"] = _status;
//     map["picId"] = _picId;
//     map["mark"] = _mark;
//     return map;
//   }
//
// }
//
// class Artist {
//   int? _id;
//   String? _name;
//   dynamic? _picUrl;
//   List<dynamic>? _alias;
//   int? _albumSize;
//   int? _picId;
//   String? _img1v1Url;
//   int? _img1v1;
//   dynamic? _trans;
//
//   int? get id => _id;
//   String? get name => _name;
//   dynamic? get picUrl => _picUrl;
//   List<dynamic>? get alias => _alias;
//   int? get albumSize => _albumSize;
//   int? get picId => _picId;
//   String? get img1v1Url => _img1v1Url;
//   int? get img1v1 => _img1v1;
//   dynamic? get trans => _trans;
//
//   Artist({
//       int? id,
//       String? name,
//       dynamic? picUrl,
//       List<dynamic>? alias,
//       int? albumSize,
//       int? picId,
//       String? img1v1Url,
//       int? img1v1,
//       dynamic? trans}){
//     _id = id;
//     _name = name;
//     _picUrl = picUrl;
//     _alias = alias;
//     _albumSize = albumSize;
//     _picId = picId;
//     _img1v1Url = img1v1Url;
//     _img1v1 = img1v1;
//     _trans = trans;
// }
//
//   Artist.fromJson(dynamic json) {
//     _id = json["id"];
//     _name = json["name"];
//     _picUrl = json["picUrl"];
//     if (json["alias"] != null) {
//       _alias = [];
//       json["alias"].forEach((v) {
//         _alias?.add(dynamic.fromJson(v));
//       });
//     }
//     _albumSize = json["albumSize"];
//     _picId = json["picId"];
//     _img1v1Url = json["img1v1Url"];
//     _img1v1 = json["img1v1"];
//     _trans = json["trans"];
//   }
//
//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["id"] = _id;
//     map["name"] = _name;
//     map["picUrl"] = _picUrl;
//     if (_alias != null) {
//       map["alias"] = _alias?.map((v) => v.toJson()).toList();
//     }
//     map["albumSize"] = _albumSize;
//     map["picId"] = _picId;
//     map["img1v1Url"] = _img1v1Url;
//     map["img1v1"] = _img1v1;
//     map["trans"] = _trans;
//     return map;
//   }
//
// }
//
// class Artists {
//   int? _id;
//   String? _name;
//   dynamic? _picUrl;
//   List<dynamic>? _alias;
//   int? _albumSize;
//   int? _picId;
//   String? _img1v1Url;
//   int? _img1v1;
//   dynamic? _trans;
//
//   int? get id => _id;
//   String? get name => _name;
//   dynamic? get picUrl => _picUrl;
//   List<dynamic>? get alias => _alias;
//   int? get albumSize => _albumSize;
//   int? get picId => _picId;
//   String? get img1v1Url => _img1v1Url;
//   int? get img1v1 => _img1v1;
//   dynamic? get trans => _trans;
//
//   Artists({
//       int? id,
//       String? name,
//       dynamic? picUrl,
//       List<dynamic>? alias,
//       int? albumSize,
//       int? picId,
//       String? img1v1Url,
//       int? img1v1,
//       dynamic? trans}){
//     _id = id;
//     _name = name;
//     _picUrl = picUrl;
//     _alias = alias;
//     _albumSize = albumSize;
//     _picId = picId;
//     _img1v1Url = img1v1Url;
//     _img1v1 = img1v1;
//     _trans = trans;
// }
//
//   Artists.fromJson(dynamic json) {
//     _id = json["id"];
//     _name = json["name"];
//     _picUrl = json["picUrl"];
//     if (json["alias"] != null) {
//       _alias = [];
//       json["alias"].forEach((v) {
//         _alias?.add(dynamic.fromJson(v));
//       });
//     }
//     _albumSize = json["albumSize"];
//     _picId = json["picId"];
//     _img1v1Url = json["img1v1Url"];
//     _img1v1 = json["img1v1"];
//     _trans = json["trans"];
//   }
//
//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["id"] = _id;
//     map["name"] = _name;
//     map["picUrl"] = _picUrl;
//     if (_alias != null) {
//       map["alias"] = _alias?.map((v) => v.toJson()).toList();
//     }
//     map["albumSize"] = _albumSize;
//     map["picId"] = _picId;
//     map["img1v1Url"] = _img1v1Url;
//     map["img1v1"] = _img1v1;
//     map["trans"] = _trans;
//     return map;
//   }
//
// }