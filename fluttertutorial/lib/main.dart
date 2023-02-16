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
    // BuildContext is packaged info passing data from one widget to another
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: FutureBuilder(
          // builder executed when it is rendered similar to useEffect.
          future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
          ),
          builder: (context, snapshot) {
            // snapshot is react equivalent of loading, success, failed etc
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                // // working around nullable variables.
                // final user = FirebaseAuth.instance.currentUser;
                // if (user?.emailVerified ?? false) {
                //   return const Text('Done');
                // } else {
                //   // Navigator cannot be inside future builder. FutureBuilder just needs widgets
                //   // Navigator.of(context).push(MaterialPageRoute(
                //   //     builder: (context) => const VerifyEmailView()));
                //   return const VerifyEmailView();
                return const LoginView();
              default:
                return const Text('loading...');
            }
          }), // textbutton is stateful widget
    ); // Scaffold is the default white space
  }
}

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    // Scaffold with AppBar cannot be const
    return Column(
      children: [
        const Text('Please verify your email address:'),
        TextButton(
            onPressed: () async {
              final user = FirebaseAuth.instance.currentUser;
              await user?.sendEmailVerification();
            },
            child: const Text('Send email verification')),
      ],
    );
  }
}

// Scaffold(
//       appBar: AppBar(title: const Text('Register')),
//       body: FutureBuilder(
//           // builder executed when it is rendered similar to useEffect.
//           future: Firebase.initializeApp(
//             options: DefaultFirebaseOptions.currentPlatform,
//           ),
//           builder: (context, snapshot) {
//             // snapshot is react equivalent of loading, success, failed etc
//             switch (snapshot.connectionState) {
//               case ConnectionState.none:
//                 return const Text('none...');
//               case ConnectionState.waiting:
//                 return const Text('waiting...');
//               case ConnectionState.active:
//                 return const Text('active...');
//               case ConnectionState.done:
//                 return 
//               default:
//                 return const Text('loading...');
//             }
//           }), // textbutton is stateful widget
//     ); // Scaffold is the default white space