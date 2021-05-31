class ContactModel {
  bool? status;
  String? message;
  Data? data;
  int? total;

  ContactModel({this.status, this.message, this.data, this.total});

  ContactModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['total'] = this.total;
    return data;
  }
}

class Data {
  List<Contact>? contact;

  Data({this.contact});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['contact'] != null) {
      contact = [];
      json['contact'].forEach((v) {
        contact!.add(new Contact.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.contact != null) {
      data['contact'] = this.contact!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Contact {
  String? id;
  String? nama;
  String? telp;
  String? email;

  Contact({this.id, this.nama, this.telp, this.email});

  Contact.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    telp = json['telp'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama'] = this.nama;
    data['telp'] = this.telp;
    data['email'] = this.email;
    return data;
  }
}
