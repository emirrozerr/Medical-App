class DoctorRegisterRequest {
  DoctorRegisterRequest({
    required this.email,
    required this.password,
    required this.name,
    required this.surname,
    required this.hospital,
    required this.school,
    required this.major,
    required this.profession,
    required this.isDoctor,
  });
  late final String email;
  late final String password;
  late final String name;
  late final String surname;
  late final String hospital;
  late final String school;
  late final String major;
  late final String profession;
  late final int isDoctor;

  DoctorRegisterRequest.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    name = json['name'];
    surname = json['surname'];
    hospital = json['hospital'];
    school = json['school'];
    major = json['major'];
    profession = json['profession'];
    isDoctor = json['isDoctor'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['email'] = email;
    _data['password'] = password;
    _data['name'] = name;
    _data['surname'] = surname;
    _data['hospital'] = hospital;
    _data['school'] = school;
    _data['major'] = major;
    _data['profession'] = profession;
    _data['isDoctor'] = isDoctor;
    return _data;
  }
}
