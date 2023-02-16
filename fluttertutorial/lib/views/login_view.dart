import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertutorial/firebase_options.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _email =
      TextEditingController(); // late means that value assigned post-initialization
  final TextEditingController _password = TextEditingController();

  // we must define initState and dispose for our class variables we've defined.
  @override
  void dispose() {
    // dispose() is used to dispose the memory after the web page is no longer used.
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          // assign TextEditingController
          controller: _email,
          enableSuggestions: false,
          autocorrect: false,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(hintText: 'Enter your email here'),
        ),
        TextField(
          // assign TextEditingController
          controller: _password,
          // three characteristics of password field
          obscureText: true,
          enableSuggestions: false,
          autocorrect: false,
          decoration:
              const InputDecoration(hintText: 'Enter your password here'),
        ),
        TextButton(
            onPressed: () async {
              // access text via TextEditingController
              final email = _email.text;
              final password = _password.text;
              try {
                final userCredential = await FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                        email: email, password: password);
                print(userCredential);
              } on FirebaseAuthException catch (e) {
                if (e.code == 'user-not-found')
                  print('User Not Found.');
                else if (e.code == 'wrong-password') print('Wrong Password.');
                print(e.runtimeType);
                print(e.toString());
              } on Exception catch (e) {
                print(e.runtimeType);
                print(e);
              }
            },
            child: const Text('Login')),
        TextButton(
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil('/register/',
                (route) {
              return false;
            });
          },
          child: const Text('Register'),
        ),
      ],
    );
  }
}
