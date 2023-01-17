import 'dart:convert';

GetDoctorRes getDoctorResJSON(String str) =>
    GetDoctorRes.fromJson(json.decode(str));

class GetDoctorRes {
  GetDoctorRes({
    required this.success,
    required this.body,
    required this.msg,
  });
  late final bool success;
  late final List<Body> body;
  late final String msg;

  GetDoctorRes.fromJson(Map<String, dynamic> json) {
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
    required this.name,
    required this.id,
    required this.surname,
    required this.image,
    required this.science,
  });
  late final String name;
  late final int id;
  late final String surname;
  late final String image;
  late final String science;

  Body.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    surname = json['surname'];
    image = json['image'];
    science = json['science'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['id'] = id;
    _data['surname'] = surname;
    _data['image'] = image;
    _data['science'] = science;
    return _data;
  }
}
