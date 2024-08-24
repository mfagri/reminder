class User {
  String? name;
  String? email;
  String? password;
  String? image;
  List<dynamic>? friends;
  String? sId;
  int? iV;
  String? qrCode;

  User(
      {this.name,
      this.email,
      this.password,
      this.image,
      this.friends,
      this.sId,
      this.iV,
      this.qrCode});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    password = json['password'];
    image = json['image'];
    if (json['friends'] != null) {
      friends = <dynamic>[];
      json['friends'].forEach((v) {
        friends!.add(v);
      });
    }
    sId = json['_id'];
    iV = json['__v'];
    qrCode = json['qrCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['image'] = image;
    if (friends != null) {
      data['friends'] = friends!.map((v) => v).toList();
    }
    data['_id'] = sId;
    data['__v'] = iV;
    data['qrCode'] = qrCode;
    return data;
  }
}
