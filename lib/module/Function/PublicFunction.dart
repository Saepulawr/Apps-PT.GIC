import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:testptgic/module/widget/Loader.dart';

String getInitial(String name) {
  List<String> r = name.split(" ");
  if (r.isEmpty) {
    return "";
  } else {
    return r.length == 1
        ? r[0][0].toUpperCase()
        : r[0][0].toUpperCase() + r[1][0].toUpperCase();
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

void snackbar() {}

extension Tools on SnackBar {
  void show(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(this);
  }
}

void showOverlayLoading(BuildContext context) {
  Loader.show(
    context,
    isAppbarOverlay: true,
    isBottomBarOverlay: true,
    progressIndicator: SpinKitCubeGrid(
      color: Theme.of(context).primaryColor,
    ),
    overlayColor: Colors.black38,
  );
}

void hideOverlayLoading() {
  Loader.hide();
}
