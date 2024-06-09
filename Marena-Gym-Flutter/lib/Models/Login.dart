
class Login {
  late int id;
  late String username;
  late String email;
  late List<String> roles;

  late String accessToken;
  Login({
    required this.id,
    required this.accessToken,
    required this.username,
    required this.email,
    required this.roles
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'accessToken': accessToken,
      'username': username,
      'email': email,
      'roles': roles
  };
  }

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
      id: json['id'] ?? 0,
      accessToken: json['accessToken'] ?? '',
      username : json['username']??'',
      email: json['email'] ?? '',
      roles: List<String>.from(json['roles']), // Parse 'roles' as a List<String>
);
  }



}