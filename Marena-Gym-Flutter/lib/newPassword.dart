// Importer les packages nécessaires
// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, sort_child_properties_last, deprecated_member_use, unused_import

import 'package:flutter/material.dart';
import 'package:projetfe/ViewModel/UserViewModel.dart';
import 'package:projetfe/login.dart';


// Créer une classe pour l'écran de login
class NewPassword extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _NewPassword createState() => _NewPassword();
}

// Créer une classe pour l'état de l'écran de login
class _NewPassword extends State<NewPassword> {

  UserViewModel userViewModel = UserViewModel();
  // Déclarer les variables pour le contrôleur de texte, le focus node et la visibilité du mot de passe
  final _emailController = TextEditingController();
  final _emailFocusNode = FocusNode();

  // Déclarer une variable pour la clé du formulaire
  final _formKey = GlobalKey<FormState>();

  // Définir une méthode pour valider et soumettre le formulaire
  void _validateAndSubmit() {
    // Fermer le clavier
    FocusScope.of(context).unfocus();
    // Vérifier si le formulaire est valide
    if (_formKey.currentState!.validate()) {
      // Obtenir les valeurs des champs de texte
      String email = _emailController.text.trim();

      // Vérifier si l'email et le mot de passe correspondent à ceux définis en dur

    }
  }

  // Définir une méthode pour réinitialiser le mot de passe
  Future<void> _resetPassword() async {
    // Obtenir l'email du champ de texte
    String email = _emailController.text.trim();
    // Vérifier si l'email est valide
    if (email.isNotEmpty) {
      // Afficher un message de succès
      if(await userViewModel.ChangePasswordAfterVerification(_emailController.text))
      {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Changer avec succes'),
            backgroundColor: Colors.green,
          ),
        );

        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));


      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('L email invalid'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } else {
      // Afficher un message d'erreur si l'email est invalide
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez entrer un email valide'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Définir une méthode pour basculer la visibilité du mot de passe
  void _togglePasswordVisibility() {
    // Mettre à jour l'état
    setState(() {
      // Inverser la valeur de la variable
    });
  }

  @override
  Widget build(BuildContext context) {
    // Retourner un widget Scaffold
    return Scaffold(
      // Définir un widget AppBar
      appBar: AppBar(
        // Définir le titre
        title: const Text('Forget password',style: TextStyle(color: Color(0xFFDA6C0C),fontWeight: FontWeight.bold,),),
        centerTitle: true,
      ),

      // Définir un widget Body
      body: Padding(

        // Ajouter une marge
        padding: const EdgeInsets.all(16.0),
        // Définir un widget Form
        child: Form(
          // Passer la clé du formulaire
          key: _formKey,
          // Définir un widget Column
          child: Column(
            // Aligner les widgets au début
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,

            // Définir les widgets enfants
            children: [
              SizedBox(height: 20,),
              Center(child: Image.asset("assets/images/22.png")),

              // Définir un widget Text
              Text(
                // Définir le texte
                'Nouveau mot de passe',
                // Définir le style
                style: TextStyle(fontSize: 18.0, color: Colors.grey.shade400),
              ),
              // Définir un widget TextFormField
              TextFormField(
                // Passer le contrôleur de texte
                controller: _emailController,
                // Passer le focus node
                focusNode: _emailFocusNode,
                // Définir le type de clavier
                keyboardType: TextInputType.emailAddress,
                // Définir l'action du clavier
                textInputAction: TextInputAction.next,
                // Définir la fonction de validation
                validator: (value) {
                  // Vérifier si la valeur est vide
                  if (value!.isEmpty) return 'Veuillez entrer votre code';
                  // Retourner null si la valeur est valide
                  return null;
                },
                // Définir la fonction de soumission
                onFieldSubmitted: (value) {
                  // Passer le focus au champ de mot de passe
                },
                // Définir la décoration
                decoration: const InputDecoration(
                  // Ajouter une bordure
                  border: OutlineInputBorder(),
                  // Ajouter une marge
                  contentPadding: EdgeInsets.all(8.0),
                ),
              ),
              // Ajouter un espace
              const SizedBox(height: 20),
              // Définir un widget Text

              // Définir un widget TextFormField

              // Ajouter un espace
              const SizedBox(height: 16.0),
              // Définir un widget Align
              Align(
                // Aligner à droite
                alignment: Alignment.centerRight,
                // Définir un widget TextButton

              ),
              // Ajouter un espace
              SizedBox(height: 10),
              // Définir un widget Align
              Align(
                // Aligner au centre
                alignment: Alignment.center,
                // Définir un widget ElevatedButton
                child: ElevatedButton(
                  // Définir le texte
                  child: Text('réinitialisation',style: TextStyle(color: Colors.white),),
                  // Définir le style
                  style: ElevatedButton.styleFrom(
                    // Définir la couleur
                    backgroundColor: Colors.orange,
                    // Définir la forme
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    // Définir la taille
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                  // Définir la fonction pour valider et soumettre le formulaire
                  onPressed: _resetPassword,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}