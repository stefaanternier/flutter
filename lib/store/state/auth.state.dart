
class AuthenticationState {
  bool authenticated;

//  String idToken;
  String userId;
  String email;
  String name;
  String pictureUrl;
  bool anon;

  AuthenticationState(
      {this.authenticated = false,
//    this.idToken,
      required this.userId,
      required this.email,
      required this.name,
      this.anon = true})
      : this.pictureUrl =
            "https://storage.googleapis.com/arlearn-eu.appspot.com/avatar.png";

  factory AuthenticationState.unauthenticated() => new AuthenticationState(
      authenticated: false, userId: '', email: '', name: '');

  static AuthenticationState fromJson(dynamic json) => AuthenticationState(
        authenticated: json["authenticated"] as bool,
        userId: json["userId"] as String,
        email: json["email"] as String,
        name: json["name"] as String,
      );

  dynamic toJson() => {
        'authenticated': authenticated,
        'userId': userId,
        'email': email,
        'name': name,
      };
}
