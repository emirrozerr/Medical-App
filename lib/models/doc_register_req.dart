class DoctorRegisterRequest {
  DoctorRegisterRequest({
    required this.email,
    required this.password,
    required this.name,
    required this.phone,
    required this.surname,
    required this.hospital,
    required this.school,
    required this.major,
    required this.profession,
  });
  late final String email;
  late final String password;
  late final String name;
  late final String phone;
  late final String surname;
  late final String hospital;
  late final String school;
  late final String major;
  late final String profession;

  DoctorRegisterRequest.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    name = json['name'];
    phone = json['phone'];
    surname = json['surname'];
    hospital = json['hospital'];
    school = json['school'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['email'] = email;
    _data['password'] = password;
    _data['name'] = name;
    _data['phone'] = phone;
    _data['surname'] = surname;
    _data['hospital'] = hospital;
    _data['school'] = school;
    _data['major'] = major;
    _data['profession'] = profession;
    return _data;
  }
}
