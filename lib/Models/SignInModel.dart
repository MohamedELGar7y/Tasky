class SignInModel {
  String? sId;
  String? accessToken;
  String? refreshToken;

  SignInModel({this.sId, this.accessToken, this.refreshToken});

  SignInModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['access_token'] = this.accessToken;
    data['refresh_token'] = this.refreshToken;
    return data;
  }
}
