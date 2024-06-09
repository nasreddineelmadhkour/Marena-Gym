import 'package:flutter/material.dart';
import 'package:projetfe/Models/StaticUser.dart';
import 'package:projetfe/Models/User.dart';
import 'package:projetfe/User.dart';
import 'package:projetfe/ViewModel/UserViewModel.dart';
import 'package:projetfe/deshbordEnt.dart';
import 'package:projetfe/forgetPass.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  bool _isPasswordVisible = false;
  DateTime? currentBackPressTime;

  final _formKey = GlobalKey<FormState>();




  Future<void> _validateAndSubmit(UserViewModel viewModel) async {
    // Fermer le clavier


    FocusScope.of(context).unfocus();
    // Vérifier si le formulaire est valide
    if (_formKey.currentState!.validate()) {
      viewModel.usernameController=_emailController;
      viewModel.passwordController=_passwordController;
      bool loginSuccess = await viewModel.login();


      if (loginSuccess) {

        if(StaticUser.staticLogin.roles[0]=="Role_client"){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Utilisateur(),
            ),
          );

        }
        else{
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Dashboard(),
            ),
          );

        }
      } else {
        // Afficher un message d'erreur si la connexion échoue
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Nom ou mot de passe incorrect'),
            backgroundColor: Colors.red,
          ),
        );
        /*
        // Show error message for unsuccessful login
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Erreur de connexion'),
              content: Text(
                'Veuillez vérifier votre nom d\'utilisateur ou mot de passe.',
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );*/
      }


      /*

      // Obtenir les valeurs des champs de texte
      String email = _emailController.text.trim();
      String password = _passwordController.text;
      // Vérifier si l'email et le mot de passe correspondent à ceux définis en dur
      if (email == "lahbibhiba1@gmail.com" && password == "06082002") {
        // Naviguer vers l'écran d'accueil si la connexion réussit
       Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => Utilisateur()));
      } else {
        // Afficher un message d'erreur si la connexion échoue
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email ou mot de passe incorrect'),
            backgroundColor: Colors.red,
          ),
        );
      }
      */

    }
  }

  // Définir une méthode pour réinitialiser le mot de passe
  void _resetPassword() {
    // Obtenir l'email du champ de texte
    String email = _emailController.text.trim();
    // Vérifier si l'email est valide
    if (email.isNotEmpty) {
      // Afficher un message de succès
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Un email de réinitialisation du mot de passe a été envoyé à $email'),
          backgroundColor: Colors.green,
        ),
      );
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
      _isPasswordVisible = !_isPasswordVisible;
    });
  }


  @override
  Widget build(BuildContext context) {

    final viewModel = Provider.of<UserViewModel>(context);
    if(_emailController.text !="" ) {
      setState(() {
        viewModel.usernameController.text =_emailController.text;
        viewModel.passwordController.text =_passwordController.text;
      });

    }

    // Retourner un widget Scaffold
    return 
    WillPopScope(
      onWillPop: () async {
        // Minimize the app instead of going back
        if (currentBackPressTime == null ||
            DateTime.now().difference(currentBackPressTime!) >
                Duration(seconds: 2)) {
          currentBackPressTime = DateTime.now();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Appuyez de nouveau pour quitter"),
            ),
          );
          return false;
        }
        SystemNavigator.pop();
        return false;
      },
      child:  Scaffold(
      // Définir un widget AppBar
      appBar: AppBar(
        // Définir le titre
        title: const Text('Login with MARENA-GYM',style: TextStyle(color: Color(0xFFDA6C0C),fontWeight: FontWeight.bold,),),
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
            // Définir les widgets enfants
            children: [
              Center(child: Image.asset("assets/images/22.png")),
              // Définir un widget Text
              Text(
                // Définir le texte
                'Nom',
                // Définir le style
                style: TextStyle(fontSize: 18.0, color: Colors.grey.shade400),
              ),
              // Définir un widget TextFormField
              TextFormField(
                onChanged: (value) => 
                {_emailController.text=value,
                },
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
                  if (value!.isEmpty) return 'Veuillez entrer votre email';
                  // Vérifier si la valeur contient un @
                  //if (!value.contains('@')) return 'Veuillez entrer un email valide';
                  // Retourner null si la valeur est valide
                  return null;
                },
                // Définir la fonction de soumission
                onFieldSubmitted: (value) {
                  // Passer le focus au champ de mot de passe
                  _passwordFocusNode.requestFocus();
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
              Text(
                // Définir le texte
                'Mot de passe',
                // Définir le style
                style: TextStyle(fontSize: 18.0, color: Colors.grey.shade400),
              ),
              // Définir un widget TextFormField
              TextFormField(
                onChanged: (value) => print(_passwordController.text),
                // Passer le contrôleur de texte
                controller: _passwordController,
                // Passer le focus node
                focusNode: _passwordFocusNode,
                // Définir le type de clavier
                keyboardType: TextInputType.text,
                // Définir l'action du clavier
                textInputAction: TextInputAction.done,
                // Définir la fonction de validation
                validator: (value) {
                  // Vérifier si la valeur est vide
                  if (value!.isEmpty) return 'Veuillez entrer votre mot de passe';
                  // Retourner null si la valeur est valide
                  return null;
                },
                // Définir la fonction de soumission
                onFieldSubmitted: (value) {
                  // Valider et soumettre le formulaire
                  _validateAndSubmit(viewModel);
                },
                // Définir la propriété pour masquer le mot de passe
                obscureText: !_isPasswordVisible,
                // Définir la décoration
                decoration: InputDecoration(
                  // Ajouter une bordure
                  border: const OutlineInputBorder(),
                  // Ajouter une marge
                  contentPadding: const EdgeInsets.all(8.0),
                  // Ajouter une icône pour basculer la visibilité du mot de passe
                  suffixIcon: IconButton(
                    icon: Icon(
                      // Changer l'icône selon la visibilité du mot de passe
                      _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                    // Définir la fonction pour basculer la visibilité du mot de passe
                    onPressed: _togglePasswordVisibility,
                  ),
                ),
              ),
              // Ajouter un espace
              const SizedBox(height: 16.0),
              // Définir un widget Align
              Align(
                // Aligner à droite
                alignment: Alignment.centerRight,
                // Définir un widget TextButton
                child: TextButton(
                  // Définir le texte
                  child: Text('Mot de passe oublié ?',style: TextStyle(color: Colors.grey.shade400),),
                  // Définir la fonction pour réinitialiser le mot de passe
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>ForgetPassword(),));
                  }
                  
                ),
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
                  child: Text('Se connecter',style: TextStyle(color: Colors.white),),
                  // Définir le style
                  style: ElevatedButton.styleFrom(
                    // Définir la couleur
                    primary: Colors.orange,
                    // Définir la forme
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    // Définir la taille
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                  // Définir la fonction pour valider et soumettre le formulaire
                  onPressed: () => _validateAndSubmit(viewModel),
                ),
              ),
            ],
          ),
        ),
      ),
    ),);
 
    
    }
}