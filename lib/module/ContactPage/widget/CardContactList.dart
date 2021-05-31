import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:testptgic/module/ContactPage/model/ModelContactAll.dart'
    as modelContact;
import 'package:testptgic/module/Function/PublicFunction.dart';

class CardContactList extends StatelessWidget {
  final modelContact.Contact contact;
  const CardContactList({required this.contact, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Container(
        color: Colors.white,
        child: ListTile(
          leading: CircleAvatar(
            child: Text(getInitial(contact.nama!)),
          ),
          title: Text(contact.nama!),
          onTap: () {},
        ),
      ),
      actions: <Widget>[
        IconSlideAction(
            closeOnTap: true,
            foregroundColor: Colors.white,
            caption: 'Edit',
            color: Colors.amber,
            icon: Icons.edit,
            onTap: () {}),
        IconSlideAction(
            caption: 'Delete',
            color: Colors.red,
            icon: Icons.delete,
            onTap: () {}),
      ],
    );
  }
}
