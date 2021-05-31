import 'package:flutter/material.dart';
import 'package:testptgic/module/ContactPage/model/ModelContactAll.dart';
import 'package:testptgic/module/Login/model/ModelLogin.dart';

class PublicProvider extends ChangeNotifier {
  ModelLogin _modelLogin = ModelLogin();
  ModelLogin get modelLogin => _modelLogin;
  void setModelLogin(ModelLogin modelLogin) {
    _modelLogin = modelLogin;
    notifyListeners();
  }

  ModelContact _modelContactAll = ModelContact();
  ModelContact get modelContactAll => _modelContactAll;
  void setModelContactAll(ModelContact modelContactAll) {
    _modelContactAll = modelContactAll;
    notifyListeners();
  }
}
