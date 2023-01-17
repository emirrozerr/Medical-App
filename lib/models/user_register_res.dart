import 'dart:convert';

UserRegisterResModel userRegisterResModel(String str) =>
    UserRegisterResModel.fromJson(json.decode(str));

class UserRegisterResModel {
  UserRegisterResModel({
    required this.success,
    required this.msg,
  });
  late final bool success;
  late final String msg;

  UserRegisterResModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['msg'] = msg;
    return _data;
  }
}
