import 'dart:convert';


class AuthenticationState {
  bool authenticated;
//  String idToken;
  String userId;
  String email;
  String name;
  String pictureUrl;
  bool anon;

  AuthenticationState({
    this.authenticated=false,
//    this.idToken,
    this.userId,
    this.email = '',
    this.name = "",
    this.anon = true
  }) : this.pictureUrl = "https://storage.googleapis.com/arlearn-eu.appspot.com/avatar.png";

  factory AuthenticationState.unauthenticated() =>
      new AuthenticationState(authenticated: false);

  static AuthenticationState fromJson(dynamic json) => AuthenticationState(
        authenticated: json["authenticated"] as bool,
        userId: json["userId"] as String,
      );

  dynamic toJson() => {
        'authenticated': authenticated,
//        'idToken': idToken,
        'userId': userId,
      };
}

