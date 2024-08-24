class Task {
  String? sId;
  String? name;
  String? description;
  String? startDate;
  int? reminderTime;
  String? status;
  AssignedTo? assignedTo;
  CreatedBy? createdBy;
  int? iV;

  Task(
      {this.sId,
      this.name,
      this.description,
      this.startDate,
      this.reminderTime,
      this.status,
      this.assignedTo,
      this.createdBy,
      this.iV});

  Task.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    startDate = json['startDate'];
    reminderTime = json['reminderTime'];
    status = json['status'];
    assignedTo = json['assignedTo'] != null
        ? AssignedTo.fromJson(json['assignedTo'])
        : null;
    createdBy = json['createdBy'] != null
        ? CreatedBy.fromJson(json['createdBy'])
        : null;
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['description'] = description;
    data['startDate'] = startDate;
    data['reminderTime'] = reminderTime;
    data['status'] = status;
    if (assignedTo != null) {
      data['assignedTo'] = assignedTo!.toJson();
    }
    if (createdBy != null) {
      data['createdBy'] = createdBy!.toJson();
    }
    data['__v'] = iV;
    return data;
  }
}

class AssignedTo {
  String? sId;
  String? name;
  String? email;
  String? image;

  AssignedTo({this.sId, this.name, this.email, this.image});

  AssignedTo.fromJson(Map<String, dynamic> json) {
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

class CreatedBy {
  String? sId;
  String? name;

  CreatedBy({this.sId, this.name});

  CreatedBy.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    return data;
  }
}