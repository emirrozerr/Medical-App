import 'dart:convert';

UserLoginRes userLoginResJson(String str) =>
    UserLoginRes.fromJson(json.decode(str));

class UserLoginRes {
  UserLoginRes({
    required this.msg,
    required this.success,
    required this.token,
    required this.user,
  });
  late final String msg;
  late final bool success;
  late final String token;
  late final User user;

  UserLoginRes.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    success = json['success'];
    token = json['token'];
    user = User.fromJson(json['user']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['msg'] = msg;
    _data['success'] = success;
    _data['token'] = token;
    _data['user'] = user.toJson();
    return _data;
  }
}

class User {
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.surname,
    required this.phone,
    required this.lastLogin,
    this.isDoctor,
    this.major,
    this.profession,
    required this.image,
    this.hospital,
    this.school,
  });
  late final int id;
  late final String name;
  late final String email;
  late final String password;
  late final String surname;
  late final String phone;
  late final String? lastLogin;
  late final int? isDoctor;
  late final int? major;
  late final String? profession;
  late final String? school;
  late final String? hospital;
  late final String image;

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    surname = json['surname'];
    phone = json['phone'];
    lastLogin = json['last_login'];
    isDoctor = json['is_doctor'];
    major = json['major'];
    profession = json['profession'];
    image = json['image'];
    hospital = json['hospital'];
    school = json['school'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['email'] = email;
    _data['password'] = password;
    _data['surname'] = surname;
    _data['phone'] = phone;
    _data['last_login'] = lastLogin;
    _data['is_doctor'] = isDoctor;
    _data['major'] = major;
    _data['profession'] = profession;
    _data['image'] = image;
    _data['hospital'] = hospital;
    _data['school'] = school;
    return _data;
  }
}
