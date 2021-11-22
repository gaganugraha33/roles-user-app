class UserModel {
  List<User> data;

  UserModel({this.data});

  UserModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<User>();
      json['data'].forEach((v) {
        data.add(new User.fromJson(v));
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

class User {
  int id;
  String dateCreated;
  String dateUpdated;
  String fullname;
  String phone;
  String email;
  String address;
  String type;
  List<int> userExperiences;
  List<int> userEducations;

  User(
      {this.id,
      this.dateCreated,
      this.dateUpdated,
      this.fullname,
      this.phone,
      this.email,
      this.address,
      this.type,
      this.userExperiences,
      this.userEducations});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateCreated = json['date_created'];
    dateUpdated = json['date_updated'];
    fullname = json['fullname'];
    phone = json['phone'];
    email = json['email'];
    address = json['address'];
    type = json['type'];
    userExperiences = json['user_experiences'].cast<int>();
    userEducations = json['user_educations'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date_created'] = this.dateCreated;
    data['date_updated'] = this.dateUpdated;
    data['fullname'] = this.fullname;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['address'] = this.address;
    data['type'] = this.type;
    data['user_experiences'] = this.userExperiences;
    data['user_educations'] = this.userEducations;
    return data;
  }
}
