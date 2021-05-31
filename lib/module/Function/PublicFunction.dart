import 'dart:math';

String generateName({int length = 5}) {
  String r = "";
  for (int i = 0; i < length; i++) {
    r += String.fromCharCode(Random().nextInt(255));
  }
  r += " ";
  for (int i = 0; i < length; i++) {
    r += String.fromCharCode(Random().nextInt(255));
  }
  return r;
}

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
