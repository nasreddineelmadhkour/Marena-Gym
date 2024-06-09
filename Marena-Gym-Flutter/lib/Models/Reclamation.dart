

class Reclamation {
  String nameUser;
  String contenu;


  Reclamation({
    required this.nameUser,
    required this.contenu,

  });


  factory Reclamation.fromJson(Map<String, dynamic> json) {
    return Reclamation(
      nameUser: json['nameUser'],
      contenu: json['contenu'],

    );
  }


}