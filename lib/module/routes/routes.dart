import 'package:flutter/material.dart';
import 'package:testptgic/module/ContactPage/ContactPage.dart';

final Map<String, Widget Function(BuildContext)> routes = {
  "/": (context) => ContactPage(),
};

enum RoutesName { contactPage }
String getRoutesName(RoutesName routesName) {
  return routes.keys.toList()[routesName.index];
}
