import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertutorial/firebase_options.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _email =
      TextEditingController(); // late means that value assigned post-initialization
  final _password = TextEditingController();

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
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: FutureBuilder(
          // builder executed when it is rendered similar to useEffect.
          future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
          ),
          builder: (context, snapshot) {
            // snapshot is react equivalent of loading, success, failed etc
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return const Text('none...');
              case ConnectionState.waiting:
                return const Text('waiting...');
              case ConnectionState.active:
                return const Text('active...');
              case ConnectionState.done:
                return Column(
                  children: [
                    TextField(
                      // assign TextEditingController
                      controller: _email,
                      enableSuggestions: false,
                      autocorrect: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                          hintText: 'Enter your email here'),
                    ),
                    TextField(
                      // assign TextEditingController
                      controller: _password,
                      // three characteristics of password field
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: const InputDecoration(
                          hintText: 'Enter your password here'),
                    ),
                    TextButton(
                        onPressed: () async {
                          // access text via TextEditingController
                          final email = _email.text;
                          final password = _password.text;
                          try {
                            final userCredential = await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                    email: email, password: password);
                            print(userCredential);
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password')
                              print('Password too weak');
                            else if (e.code == 'email-already-in-use')
                              print('Email is already in use');
                            else if (e.code == 'invalid-email')
                              print('Invalid Email');
                          }
                        },
                        child: const Text('Register')),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Login'),
                    )
                  ],
                );
              default:
                return const Text('loading...');
            }
          }), // textbutton is stateful widget
    ); // Scaffold is the default white space
  }
}
