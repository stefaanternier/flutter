import 'dart:ui';

class Account {
  String email;
  String name;

  Account({this.email, this.name});

  Map toJson() {
    Map map = new Map();
    if (this.email != null) map["email"] = this.email;
    if (this.name != null) map["name"] = this.name;
    return map;
  }
}

// {
// "email": "",
// "name": ""
// }
