import 'dart:convert';

UserMessageRes userMessageResJson(String str) =>
    UserMessageRes.fromJson(json.decode(str));

class UserMessageRes {
  UserMessageRes({
    required this.success,
    required this.msg,
    required this.body,
  });
  late final bool success;
  late final String? msg;
  late final List<Body> body;

  UserMessageRes.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    msg = json['msg'];
    body = List.from(json['body']).map((e) => Body.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['msg'] = msg;
    _data['body'] = body.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Body {
  Body({
    required this.id,
    required this.duo,
    required this.source,
    required this.target,
    required this.name,
    required this.surname,
    required this.image,
    required this.lastLogin,
    required this.science,
  });
  late final int id;
  late final String duo;
  late final String source;
  late final int target;
  late final String name;
  late final String surname;
  late final String image;
  late final String lastLogin;
  late final String? science;

  Body.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    duo = json['duo'];
    source = json['source'];
    target = json['target'];
    name = json['name'];
    surname = json['surname'];
    image = json['image'];
    lastLogin = json['last_login'];
    science = json['science'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['duo'] = duo;
    _data['source'] = source;
    _data['target'] = target;
    _data['name'] = name;
    _data['surname'] = surname;
    _data['image'] = image;
    _data['last_login'] = lastLogin;
    _data['science'] = science;
    return _data;
  }
}
