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

  Future<void> showFormContact(
      {required BuildContext context,
      required bool isEdit,
      int idOldData = -1,
      modelContact.Contact? contact}) async {
    final hasil = await _showFormInputDialog(
        context: context,
        title: isEdit ? "Edit Contact" : "Add Contact",
        contact: contact);
    if (hasil != null) {
      modelContact.Contact newData = modelContact.Contact(
        nama: hasil[0],
        telp: hasil[1],
        email: hasil[2],
      );
      showOverlayLoading(context);
      bool hasilAction = false;
      if (isEdit) {
        //edit data
        hasilAction = await this.updateContact(id: idOldData, data: newData);
      } else {
        //tambah data
        hasilAction = await this.addContact(data: newData);
      }
      if (hasilAction) {
        //berhasil menyimpan data
        SnackBar(
          backgroundColor: Colors.green,
          content: Text("Save data success"),
        ).show(context);
      } else {
        //gagal menyimpan data

        SnackBar(
          backgroundColor: Colors.red,
          content: Text("Error when save data!"),
        ).show(context);
        //show again dialog
        this.showFormContact(
            context: context,
            isEdit: isEdit,
            contact: newData,
            idOldData: idOldData);
      }

      hideOverlayLoading();
    }
  }

  Future<List<String>?> _showFormInputDialog(
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
