import 'package:flutter/material.dart';
import 'package:testptgic/module/ContactPage/model/ModelContactAll.dart'
    as modelContact;
import 'package:testptgic/module/Function/PublicFunction.dart';

class CardContactList extends StatelessWidget {
  final modelContact.Contact contact;
  const CardContactList({required this.contact, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(getInitial(contact.nama!)),
      ),
      title: Text(contact.nama!),
    );
  }
}
