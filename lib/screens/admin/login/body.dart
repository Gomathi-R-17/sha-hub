import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rcc_project/components/already_have_an_account.dart';
import 'package:rcc_project/components/constants.dart';
import 'package:rcc_project/components/text_field_container.dart';
import 'package:rcc_project/screens/admin/admin_home_screen/admin_home_screen.dart';
import 'package:rcc_project/screens/admin/login/forgot_password.dart';
import 'package:rcc_project/screens/admin/login/login_screen.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController CpasswordController = TextEditingController();

  bool obscureText = true;

  bool cobscureText = true;

  @override
  Widget build(BuildContext context) {
    String errorText = "";

    Size size = MediaQuery.of(context).size;
    return Center(
      child: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <
            Widget>[
          SizedBox(height: size.height * 0.02),
          Image.asset("assets/images/login.png",
              height: size.height * 0.30, width: size.width * 0.35),
          SizedBox(height: size.height * 0.03),
          Text("Welcome Back !",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700)),
          SizedBox(height: size.height * 0.03),
          Text(errorText,
              style: TextStyle(
                color: Colors.white,
              )),
          SizedBox(height: size.height * 0.01),
          emailInputField("Email Address", size, emailController),
          SizedBox(height: size.height * 0.02),
          passwordInputField("Password", size, passwordController),
          SizedBox(height: size.height * 0.03),
          Row(children: <Widget>[
            Container(
              width: size.width * 0.85,
              child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AdminPasswordResetScreen()));
                  },
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Text("Forgot Password?",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w700)),
                  )),
            )
          ]),
          SizedBox(height: size.height * 0.04),
          button("LOGIN", size, () async {
            String email = emailController.text;
            String password = passwordController.text;

            if (await doesUserExists(email)) {
              FirebaseAuth.instance
                  .signInWithEmailAndPassword(email: email, password: password)
                  .then((value) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AdminHomeScreen()));
              }).onError((error, stackTrace) {
                setState(() => errorText = "Invalid Email Address/Password");
              });
            } else {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                    title: Text(
                        "Only Admins can Login. If you don't have an admin account, please create an account and login !"),
                    actions: [
                      TextButton(
                          child: Text("Okay"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          })
                    ]),
              );
            }
          }),
          SizedBox(height: size.height * 0.04),
          AlreadyHaveAnAccount(
              login: true,
              press: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AdminLoginScreen()));
              }),
        ]),
      ),
    );
  }

  Widget emailInputField(
      String hint, Size size, TextEditingController controller) {
    return TextFieldContainer(
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.email, color: iconcolor),
            hintText: hint,
            hintStyle: TextStyle(color: iconcolor),
            border: InputBorder.none),
      ),
    );
  }

  Widget passwordInputField(
      String hint, Size size, TextEditingController controller) {
    return TextFieldContainer(
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock, color: iconcolor),
            suffixIcon: IconButton(
                onPressed: () => setState(() => obscureText = !obscureText),
                icon: obscureText
                    ? Icon(Icons.visibility_off, color: iconcolor)
                    : Icon(Icons.visibility, color: iconcolor)),
            hintText: hint,
            hintStyle: TextStyle(color: iconcolor),
            border: InputBorder.none),
      ),
    );
  }

  Widget button(String buttonName, Size size, VoidCallback press) {
    return ElevatedButton(
      onPressed: press,
      child: Text(buttonName,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0)),
      style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(300)),
          primary: bgcolor,
          fixedSize: Size(size.width * 0.75, 50.0)),
    );
  }

  Future<bool> doesUserExists(email) async {
    var query = await FirebaseFirestore.instance
        .collection("AdminData")
        .where('email', isEqualTo: email)
        .get();

    var snapshot = query.docs[0];
    var data = snapshot.data();

    String userEmail = data['email'];

    if (email == userEmail) {
      return true;
    } else {
      return false;
    }
  }
}
