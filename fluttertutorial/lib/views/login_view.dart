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
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
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
                                .signInWithEmailAndPassword(
                                    email: email, password: password);
                            print(userCredential);
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found')
                              print('User Not Found.');
                            else if (e.code == 'wrong-password')
                              print('Wrong Password.');
                            print(e.runtimeType);
                            print(e.toString());
                          } on Exception catch (e) {
                            print(e.runtimeType);
                            print(e);
                          }
                        },
                        child: const Text('Login')),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Register'),
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
