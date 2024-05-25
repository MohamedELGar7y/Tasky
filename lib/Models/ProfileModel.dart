class ProfileModel {
  String? sId;
  String? displayName;
  String? username;
  List<String>? roles;
  bool? active;
  int? experienceYears;
  String? address;
  String? level;
  String? createdAt;
  String? updatedAt;
  int? iV;

  ProfileModel(
      {this.sId,
      this.displayName,
      this.username,
      this.roles,
      this.active,
      this.experienceYears,
      this.address,
      this.level,
      this.createdAt,
      this.updatedAt,
      this.iV});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    displayName = json['displayName'];
    username = json['username'];
    roles = json['roles'].cast<String>();
    active = json['active'];
    experienceYears = json['experienceYears'];
    address = json['address'];
    level = json['level'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['displayName'] = this.displayName;
    data['username'] = this.username;
    data['roles'] = this.roles;
    data['active'] = this.active;
    data['experienceYears'] = this.experienceYears;
    data['address'] = this.address;
    data['level'] = this.level;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
