class CreateRoleModel {
  CreateRole data;

  CreateRoleModel({this.data});

  CreateRoleModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new CreateRole.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class CreateRole {
  int id;
  String dateCreated;
  Null dateUpdated;
  String title;
  String description;
  String requirement;

  CreateRole(
      {this.id,
      this.dateCreated,
      this.dateUpdated,
      this.title,
      this.description,
      this.requirement});

  CreateRole.fromJson(Map<String, dynamic> json) {
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
