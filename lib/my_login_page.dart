import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'my_home_page.dart';
import 'package:restaurant_application/color_schemes.g.dart';

class MyLoginPage extends StatefulWidget {
  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  final _formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";

  Future<void> authenticate(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

    /*  ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Authentication successful")),
      );
*/
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    backgroundColor: lightColorScheme.tertiaryContainer, // Background color
    content: Row(
      children: [
        Icon(
          Icons.check_circle,
          color: lightColorScheme.onSecondary,
        ),
        SizedBox(width: 10),
        Text(
          "Authentication successful",
          style: TextStyle(color: lightColorScheme.onSecondary),
        ),
      ],
    ),
    action: SnackBarAction(
      label: 'Close',
      textColor: lightColorScheme.onSecondary,
      onPressed: () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      },
    ),
  ),
);
      // Navigate to the home page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MyHomePage(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage =
          "No user found with this email or password!! Please verify your credentials.";
      if (e.code == 'user-not-found') {
        errorMessage = 'User not found. Please check your email.';
      }

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Authentication Error'),
            content: Text(errorMessage),
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
      );
    }
  }

  void onSubmit() {
    if (_formKey.currentState!.validate()) {
      authenticate(email, password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome To Our Restaurant',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: lightColorScheme.surfaceTint,
              ),
            ),
            SizedBox(height: 16),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    onChanged: (value) {
                      setState(() {
                        email = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter an email";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    onChanged: (value) {
                      setState(() {
                        password = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter a password";
                      }
                      return null;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: onSubmit,
                    child: Text("Login"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}