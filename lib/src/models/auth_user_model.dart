import 'user_model.dart';

class AuthUser {
  int statusCode;
  Body body;

  AuthUser({this.statusCode, this.body});

  AuthUser.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    body = json['body'] != null ? new Body.fromJson(json['body']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    if (this.body != null) {
      data['body'] = this.body.toJson();
    }
    return data;
  }
}

class Body {
  String oauthToken;
  String oauthSecret;
  User user;
  Tabs tabs;
  String pmAccessToken;
  String chAccessTokenv2;

  Body(
      {this.oauthToken,
      this.oauthSecret,
      this.user,
      this.tabs,
      this.pmAccessToken,
      this.chAccessTokenv2});

  Body.fromJson(Map<String, dynamic> json) {
    oauthToken = json['oauth_token'];
    oauthSecret = json['oauth_secret'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    tabs = json['tabs'] != null ? new Tabs.fromJson(json['tabs']) : null;
    pmAccessToken = json['pmAccessToken'];
    chAccessTokenv2 = json['chAccessTokenv2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['oauth_token'] = this.oauthToken;
    data['oauth_secret'] = this.oauthSecret;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.tabs != null) {
      data['tabs'] = this.tabs.toJson();
    }
    data['pmAccessToken'] = this.pmAccessToken;
    data['chAccessTokenv2'] = this.chAccessTokenv2;
    return data;
  }
}



class Tabs {
  int primemessenger;

  Tabs({this.primemessenger});

  Tabs.fromJson(Map<String, dynamic> json) {
    primemessenger = json['primemessenger'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['primemessenger'] = this.primemessenger;
    return data;
  }
}
