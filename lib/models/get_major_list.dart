import 'dart:convert';

GetMajorList getMajorListJson(String str) =>
    GetMajorList.fromJson(json.decode(str));

class GetMajorList {
  GetMajorList({
    required this.success,
    required this.body,
    required this.msg,
  });
  late final bool success;
  late final List<Body> body;
  late final String msg;

  GetMajorList.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    body = List.from(json['body']).map((e) => Body.fromJson(e)).toList();
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['body'] = body.map((e) => e.toJson()).toList();
    _data['msg'] = msg;
    return _data;
  }
}

class Body {
  Body({
    required this.id,
    required this.science,
  });
  late final int id;
  late final String science;

  Body.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    science = json['science'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['science'] = science;
    return _data;
  }
}
