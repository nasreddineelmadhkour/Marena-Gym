import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _passwordObscure = true;

  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nomController,
      _prenomController,
      _emailController,
      _passwordController;

  @override
  void initState() {
    super.initState();
    _nomController = TextEditingController();
    _prenomController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _nomController.dispose();
    _prenomController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Sign Up with MARENA-GYM',
          style: TextStyle(
            color: Color(0xFFDA6C0C),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(child: Image.asset("assets/images/22.png")),
                  SizedBox(height: 25,),
                  Text(
                    'Nom d\'utilisateur',
                    style: TextStyle(fontSize: 18.0, color: Colors.grey.shade400),
                  ),
                  TextFormField(
                    controller: _nomController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(8.0),
                    ),
                    validator: (value) {
                      if (value!.isEmpty || !RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                        return 'Entrez un nom alphabétique';
                      }
                      return null;
                    },
                    onSaved: (value) => _nomController.text = value!,
                  ),
                  SizedBox(height: 20,),
                  Text(
                    'Prénom d\'utilisateur',
                    style: TextStyle(fontSize: 18.0, color: Colors.grey.shade400),
                  ),
                  TextFormField(
                    controller: _prenomController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(8.0),
                    ),
                    validator: (value) {
                      if (value!.isEmpty || !RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                        return 'Entrez un prénom alphabétique';
                      }
                      return null;
                    },
                    onSaved: (value) => _prenomController.text = value!,
                  ),
                  SizedBox(height: 20,),
                  Text(
                    'Email',
                    style: TextStyle(fontSize: 18.0, color: Colors.grey.shade400),
                  ),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(8.0),
                    ),
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return 'Entrez une adresse email valide';
                      }
                      return null;
                    },
                    onSaved: (value) => _emailController.text = value!,
                  ),
                  SizedBox(height: 20,),
                  Text(
                    'Mot de passe',
                    style: TextStyle(fontSize: 18.0, color: Colors.grey.shade400),
                  ),
                  TextFormField(
                    controller: _passwordController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    obscureText: _passwordObscure,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(8.0),
                      suffixIcon: IconButton(
                        icon: _passwordObscure ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _passwordObscure = !_passwordObscure;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty || value.length < 8) {
                        return 'Le mot de passe doit contenir au moins 8 caractères';
                      }
                      return null;
                    },
                    onSaved: (value) => _passwordController.text = value!,
                  ),
                  SizedBox(height: 20,),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState?.save();
                          print('Nom: ${_nomController.text}, Prénom: ${_prenomController.text}, Email: ${_emailController.text}, Mot de passe: ${_passwordController.text}');
                        }
                      },
                      child: Text('S\'inscrire', style: TextStyle(color: Colors.white),),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
