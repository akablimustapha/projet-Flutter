import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/profile_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_login/register_screen.dart';
import 'package:flutter_login/main.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Future<void> registerWithEmailAndPassword() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    try {
      UserCredential userCredential =
          await auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      User? user = userCredential.user;
      print("User registered: $user");

      // Redirection vers la page de profil
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const ProfileScreen()),
      );
    } on FirebaseAuthException catch (e) {
      print("Error: ${e.message}");
    }
  }

 

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text("Register"),
    ),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Register for MyApp",
            style: TextStyle(
              color: Colors.black,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 44.0,
          ),
          _buildTextField(
            controller: _emailController,
            hintText: "Email",
            prefixIcon: Icons.mail,
          ),
          SizedBox(
            height: 26.0,
          ),
          _buildTextField(
            controller: _passwordController,
            hintText: "Password",
            prefixIcon: Icons.lock,
            obscureText: true,
          ),
          SizedBox(
            height: 48.0,
          ),
          _buildRegisterButton(),
        ],
      ),
    ),
  );
}

Widget _buildTextField({
  required TextEditingController controller,
  required String hintText,
  required IconData prefixIcon,
  bool obscureText = false,
}) {
  return TextField(
    controller: controller,
    obscureText: obscureText,
    style: TextStyle(color: Colors.black),
    decoration: InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.grey[600]),
      prefixIcon: Icon(prefixIcon, color: Colors.black),
      filled: true,
      fillColor: Colors.grey[200],
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: Colors.transparent),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: Colors.blue),
      ),
    ),
  );
}

Widget _buildRegisterButton() {
  return SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      onPressed: () async {
        await registerWithEmailAndPassword();
         Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                              builder: (context) => const HomePage(),
                ),
            );
      },
      style: ElevatedButton.styleFrom(
        primary: Color(0xFF0069FE),
        elevation: 0.0,
        padding: EdgeInsets.symmetric(vertical: 20.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      child: Text(
        "Register",
        style: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

}
