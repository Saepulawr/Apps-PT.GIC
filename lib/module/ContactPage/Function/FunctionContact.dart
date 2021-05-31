import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:testptgic/module/API/Api.dart';
import 'package:testptgic/module/ContactPage/model/ModelContactAll.dart'
    as modelContact;
import 'package:testptgic/module/Function/PublicFunction.dart';

class FunctionContact {
  Future<bool> addContact({required modelContact.Contact data}) async {
    bool hasil = false;
    await API().postData(
      url: UrlApi().contactAdd,
      data: {"nama": data.nama, "telp": data.telp, "email": data.email},
      onComplete: (data, statusCode) {
        print(data);
        if (statusCode == 200) hasil = true;
      },
    );
    return hasil;
  }

  Future<bool> deleteContact({required int id}) async {
    bool hasil = false;
    await API().postData(
      url: UrlApi().contactDelete,
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
      url: UrlApi().contactUpdate,
      data: {"nama": data.nama, "telp": data.telp, "email": data.email},
      onComplete: (data, statusCode) {
        if (statusCode == 200) hasil = true;
      },
    );
    return hasil;
  }

  Future<List<String>?> showFormInputDialog(
      {required BuildContext context,
      required String title,
      String? message,
      modelContact.Contact? contact}) {
    return showTextInputDialog(
      context: context,
      title: title,
      message: message,
      textFields: [
        DialogTextField(
          hintText: "Name",
          initialText: contact != null ? contact.nama : "",
          validator: (value) {
            if (value!.isEmpty) return "Field name cannot be empty!";
          },
        ),
        DialogTextField(
          hintText: "Phone",
          initialText: contact != null ? contact.telp : "",
          keyboardType: TextInputType.phone,
          validator: (value) {
            if (value!.isEmpty) return "Field phone cannot be empty!";
          },
        ),
        DialogTextField(
          hintText: "Email",
          initialText: contact != null ? contact.email : "",
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value!.isEmpty) {
              return "Field Email cannot be empty!";
            } else if (!value.isValidEmail()) {
              return "Email not valid!";
            }
          },
        )
      ],
    );
  }
}
