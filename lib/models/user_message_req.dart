class UserMessageReq {
  UserMessageReq({
    required this.id,
  });
  late final int id;

  UserMessageReq.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    return _data;
  }
}
