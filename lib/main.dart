import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text('Auth User(Logged ' + (user == null ? 'out' : 'in') + ')'),
      ),
      body: Center(
        child: Column(
          children: [
            TextField(controller: emailController),
            TextField(controller: passwordController),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    child: Text('Sign Up'),
                    onPressed: () async {
                      await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text,
                      );
                      setState(() {});
                    }),
                ElevatedButton(
                    child: Text('Sign In'),
                    onPressed: () async {
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text,
                      );
                      setState(() {});
                    }),
                ElevatedButton(
                    child: Text('Log Out'),
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      setState(() {});
                    }),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
