import 'package:testptgic/module/API/Api.dart';
import 'package:testptgic/module/ContactPage/model/ModelContactAll.dart'
    as modelContact;

class FunctionContact {
  Future<bool> addContact({required modelContact.Contact data}) async {
    bool hasil = false;
    await API().postData(
      url: UrlApi().contactAdd,
      data: {"nama": data.nama, "telp": data.telp, "email": data.email},
      onComplete: (data, statusCode) {
        if (statusCode == 200) hasil = true;
      },
    );
    return hasil;
  }

  Future<bool> deleteContact({required int id}) async {
    bool hasil = false;
    await API().postData(
      url: UrlApi().contactAdd,
      data: {"id": id},
      onComplete: (data, statusCode) {
        if (statusCode == 200) hasil = true;
      },
    );
    return hasil;
  }

  Future<bool> updateContact(
      {required int id, required modelContact.Contact data}) async {
    bool hasil = false;
    await API().postData(
      url: UrlApi().contactAdd,
      data: {"nama": data.nama, "telp": data.telp, "email": data.email},
      onComplete: (data, statusCode) {
        if (statusCode == 200) hasil = true;
      },
    );
    return hasil;
  }
}
