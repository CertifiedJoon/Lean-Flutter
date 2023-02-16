import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertutorial/firebase_options.dart';

import 'views/register_view.dart';
import 'views/login_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
              case ConnectionState.done:
                // working around nullable variables.
                final user = FirebaseAuth.instance.currentUser;
                if (user?.emailVerified ?? false) {
                  return const Text('You are verified');
                } else {
                  return const Text('You are not email-verified');
                }
              default:
                return const Text('loading...');
            }
          }), // textbutton is stateful widget
    ); // Scaffold is the default white space
  }
}
