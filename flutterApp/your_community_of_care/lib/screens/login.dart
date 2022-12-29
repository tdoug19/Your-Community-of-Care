import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login_and_database/screens/admin_home.dart';
import 'package:login_and_database/screens/employee_home.dart';
import 'package:login_and_database/services/auth.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);
  static String id = 'login_screen';

  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            //First check if there is a login
            if (snapshot.hasData) {
              //Now check if it is an admin
              if (snapshot.data?.email == "tdoug19@gmail.com") {
                return AdminHomeScreen();
              } else {
                return EmployeeHomeScreen();
              }
            }
            return LoginWidget();
          },
        ),
      );
}

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final AuthService _auth = AuthService();
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      minimumSize: const Size(150, 40),
      maximumSize: const Size(150, 40),
    );

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Your Community of Care'),
          backgroundColor: Colors.blue[400],
          actions: <Widget>[],
        ),
        backgroundColor: Colors.blue[100],
        body: Center(
          child: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 34.0),
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(labelText: 'Email'),
                    onChanged: (val) {
                      setState(() => email = val);
                    },
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Password',
                      ),
                      obscureText: true,
                      onChanged: (val) {
                        setState(() => password = val);
                      }),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () async {
                      print('printing email and password');
                      print(email);
                      print(password);
                      dynamic result = await _auth.signInWithEmailAndPassword(
                          email, password);
                      if (result == null) {
                        print('error signing in');
                      } else {
                        print('signed in');
                        print(result.user.email);
                      }
                    },
                    style: style,
                    child: Text('login'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
