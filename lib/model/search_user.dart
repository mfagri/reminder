class Searchuser {
  String? sId;
  String? name;
  String? email;
  String? image;

  Searchuser({this.sId, this.name, this.email, this.image});

  Searchuser.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['email'] = email;
    data['image'] = image;
    return data;
  }
}
