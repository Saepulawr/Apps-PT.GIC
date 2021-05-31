import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:testptgic/module/ContactPage/ContactPage.dart';
import 'package:testptgic/module/ContactPage/Function/FunctionContact.dart';
import 'package:testptgic/module/ContactPage/model/ModelContactAll.dart'
    as modelContact;
import 'package:testptgic/module/Function/PublicFunction.dart';

class CardContactList extends StatefulWidget {
  final modelContact.Contact contact;
  CardContactList({Key? key, required this.contact}) : super(key: key);

  @override
  _CardContactListState createState() => _CardContactListState();
}

class _CardContactListState extends State<CardContactList> {
  bool showDetail = false;
  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Container(
        color: Colors.white,
        child: ListTile(
          leading: CircleAvatar(
            child: Text(getInitial(widget.contact.nama!)),
          ),
          title: Text(
            widget.contact.nama!,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: showDetail
              ? Text(widget.contact.telp! + " - " + widget.contact.email!)
              : null,
          onTap: () {
            setState(() {
              showDetail = !showDetail;
            });
          },
        ),
      ),
      actions: <Widget>[
        IconSlideAction(
            closeOnTap: true,
            foregroundColor: Colors.white,
            caption: 'Edit',
            color: Colors.amber,
            icon: Icons.edit,
            onTap: () {
              FunctionContact().showFormContact(
                  context: context,
                  isEdit: true,
                  idOldData: int.parse(widget.contact.id!),
                  contact: widget.contact,
                  onSuccess: () => keyContact.currentState!.handleRefresh());
            }),
        IconSlideAction(
            caption: 'Delete',
            color: Colors.red,
            icon: Icons.delete,
            onTap: () async {
              final hasil = await showOkCancelAlertDialog(
                  context: context,
                  title: "Delete this contact ?",
                  message: "This action cannot undone");
              if (hasil == OkCancelResult.ok) {
                showOverlayLoading(context);
                if (await FunctionContact()
                    .deleteContact(id: int.parse(widget.contact.id!))) {
                  //sukses
                  SnackBar(
                    backgroundColor: Colors.green,
                    content: Text("Delete data success"),
                  ).show(context);
                  keyContact.currentState!.handleRefresh();
                } else {
                  //gagal
                  SnackBar(
                    backgroundColor: Colors.red,
                    content: Text("Error when delete data!"),
                  ).show(context);
                }
                hideOverlayLoading();
              }
            }),
      ],
    );
  }
}
