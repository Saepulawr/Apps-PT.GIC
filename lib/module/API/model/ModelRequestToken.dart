class ModelRequestToken {
  bool? status;
  String? message;
  Data? data;

  ModelRequestToken({this.status, this.message, this.data});

  ModelRequestToken.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? token;
  Expiration? expiration;

  Data({this.token, this.expiration});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    expiration = json['expiration'] != null
        ? new Expiration.fromJson(json['expiration'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    if (this.expiration != null) {
      data['expiration'] = this.expiration!.toJson();
    }
    return data;
  }
}

class Expiration {
  int? seconds;
  int? hours;

  Expiration({this.seconds, this.hours});

  Expiration.fromJson(Map<String, dynamic> json) {
    seconds = json['seconds'];
    hours = json['hours'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['seconds'] = this.seconds;
    data['hours'] = this.hours;
    return data;
  }
}
