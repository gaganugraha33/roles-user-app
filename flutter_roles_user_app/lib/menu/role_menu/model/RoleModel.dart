class RoleModel {
  List<Role> data;

  RoleModel({this.data});

  RoleModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Role>();
      json['data'].forEach((v) {
        data.add(new Role.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Role {
  int id;
  String dateCreated;
  String dateUpdated;
  String title;
  String description;
  String requirement;

  Role(
      {this.id,
      this.dateCreated,
      this.dateUpdated,
      this.title,
      this.description,
      this.requirement});

  Role.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateCreated = json['date_created'];
    dateUpdated = json['date_updated'];
    title = json['title'];
    description = json['description'];
    requirement = json['requirement'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date_created'] = this.dateCreated;
    data['date_updated'] = this.dateUpdated;
    data['title'] = this.title;
    data['description'] = this.description;
    data['requirement'] = this.requirement;
    return data;
  }
}
