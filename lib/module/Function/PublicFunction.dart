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
