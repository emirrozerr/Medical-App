class UserRegisterReqModel {
  UserRegisterReqModel({
    required this.email,
    required this.password,
    required this.name,
    required this.phone,
    required this.surname,
  });
  late final String email;
  late final String password;
  late final String name;
  late final String phone;
  late final String surname;

  UserRegisterReqModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    name = json['name'];
    phone = json['phone'];
    surname = json['surname'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['email'] = email;
    _data['password'] = password;
    _data['name'] = name;
    _data['phone'] = phone;
    _data['surname'] = surname;
    return _data;
  }
}
