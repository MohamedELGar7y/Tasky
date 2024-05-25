class SignUpModel {
  String? sId;
  String? displayName;
  String? accessToken;
  String? refreshToken;

  SignUpModel(
      {this.sId, this.displayName, this.accessToken, this.refreshToken});

  SignUpModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    displayName = json['displayName'];
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['displayName'] = this.displayName;
    data['access_token'] = this.accessToken;
    data['refresh_token'] = this.refreshToken;
    return data;
  }
}
