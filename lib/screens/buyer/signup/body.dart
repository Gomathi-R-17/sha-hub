import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rcc_project/components/already_have_an_account.dart';
import 'package:rcc_project/components/constants.dart';
import 'package:rcc_project/components/text_field_container.dart';
import 'package:rcc_project/screens/buyer/login/login_screen.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TextEditingController emailController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController cPasswordController = TextEditingController();

  TextEditingController mobileNoController = TextEditingController();

  bool obscureText = true;

  bool cobscureText = true;

  final formKey = GlobalKey<FormState>();
  String errorText = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Center(
      child: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: size.height * 0.02),
              Image.asset("assets/images/signup.png",
                  height: size.height * 0.25, width: size.width * 0.35),
              SizedBox(height: size.height * 0.03),
              Text("Create your Account",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700)),
              SizedBox(height: size.height * 0.04),
              Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(children: <Widget>[
                  userInputField("Username", size, nameController),
                  SizedBox(height: size.height * 0.02),
                  phoneNoInputField("Mobile Number", size, mobileNoController),
                  SizedBox(height: size.height * 0.02),
                  emailInputField("Email Address", size, emailController),
                  SizedBox(height: size.height * 0.02),
                  passwordInputField("Password", size, passwordController),
                  SizedBox(height: size.height * 0.02),
                  CpasswordInputField(
                      "Confirm Password", size, cPasswordController),
                  SizedBox(height: size.height * 0.04),
                  button("SIGN UP", size, () async {
                    final isValid = formKey.currentState!.validate();
                    String name = nameController.text;
                    String email = emailController.text;
                    String password = passwordController.text;
                    String mobileNo = mobileNoController.text;

                    FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: email, password: password)
                        .then((value) {
                      String id = value.user!.uid;
                      final user = User(
                          id: id,
                          name: name,
                          mobileNo: mobileNo,
                          email: email,
                          password: password);
                      createUser(user);
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                            title: const Text("Account Created Successfully"),
                            actions: [
                              TextButton(
                                  child: const Text("Okay"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                BuyerLoginScreen()));
                                  })
                            ]),
                      );
                    }).onError((error, stackTrace) {
                      setState(() {
                        errorText = "Email Address is already in use";
                      });
                    });
                  }),
                ]),
              ),
              SizedBox(height: size.height * 0.04),
              AlreadyHaveAnAccount(
                  login: false,
                  press: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BuyerLoginScreen()));
                  })
            ]),
      ),
    );
  }

  Widget userInputField(
      String hint, Size size, TextEditingController controller) {
    return Container(
      width: size.width * 0.75,
      height: 50.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [0.0, 1.0],
              colors: [Color(0xFFc4cbf0), Color(0xFF8f9de4)])),
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (value!.length < 2) {
            return "Enter atleast Two Characters";
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.person, color: iconcolor),
            hintText: hint,
            hintStyle: TextStyle(color: iconcolor),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 3.0),
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 3.0),
                borderRadius: BorderRadius.all(Radius.circular(10.0)))),
      ),
    );
  }

  Widget phoneNoInputField(
      String hint, Size size, TextEditingController controller) {
    return TextFieldContainer(
      child: TextFormField(
        validator: (value) {
          if (value!.length < 10 || value.length > 10) {
            return "Phone Number should contain 10 digits";
          } else {
            return null;
          }
        },
        controller: controller,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.phone, color: iconcolor),
            hintText: hint,
            hintStyle: TextStyle(color: iconcolor),
            border: InputBorder.none),
      ),
    );
  }

  Widget emailInputField(
      String hint, Size size, TextEditingController controller) {
    return Container(
      width: size.width * 0.75,
      height: 50.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [0.0, 1.0],
              colors: [Color(0xFFc4cbf0), Color(0xFF8f9de4)])),
      child: TextFormField(
        controller: controller,
        validator: (email) => email != null && !EmailValidator.validate(email)
            ? 'Enter a Valid Email'
            : null,
        keyboardType: TextInputType.emailAddress,
        autofillHints: [AutofillHints.email],
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.email, color: iconcolor),
            hintText: hint,
            hintStyle: TextStyle(color: iconcolor),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 3.0),
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 3.0),
                borderRadius: BorderRadius.all(Radius.circular(10.0)))),
      ),
    );
  }

  Widget passwordInputField(
      String hint, Size size, TextEditingController controller) {
    return Container(
      width: size.width * 0.75,
      height: 50.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [0.0, 1.0],
              colors: [Color(0xFFc4cbf0), Color(0xFF8f9de4)])),
      child: TextFormField(
        controller: controller,
        validator: (value) {
          RegExp regex = RegExp(
              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
          if (value!.isEmpty) {
            return 'Please Enter the Password';
          } else {
            if (!regex.hasMatch(value)) {
              return 'Include LowerCase, UpperCase, Nos & Special Characters';
            } else {
              return null;
            }
          }
        },
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
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 3.0),
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 3.0),
                borderRadius: BorderRadius.all(Radius.circular(10.0)))),
      ),
    );
  }

  Widget CpasswordInputField(
      String hint, Size size, TextEditingController controller) {
    return Container(
      width: size.width * 0.75,
      height: 50.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [0.0, 1.0],
              colors: [Color(0xFFc4cbf0), Color(0xFF8f9de4)])),
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (value != passwordController.text) {
            return "Enter Correct Password";
          } else if (value!.isEmpty) {
            return "Please Enter the Password";
          } else {
            return null;
          }
        },
        obscureText: cobscureText,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock, color: iconcolor),
            suffixIcon: IconButton(
                onPressed: () => setState(() => cobscureText = !cobscureText),
                icon: cobscureText
                    ? Icon(Icons.visibility_off, color: iconcolor)
                    : Icon(Icons.visibility, color: iconcolor)),
            hintText: hint,
            hintStyle: TextStyle(color: iconcolor),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 3.0),
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 3.0),
                borderRadius: BorderRadius.all(Radius.circular(10.0)))),
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

  Future createUser(User user) async {
    final docUser = FirebaseFirestore.instance.collection("BuyerData").doc();

    final json = user.toJson();
    await docUser.set(json);
  }
}

class User {
  final String? id;
  final String? name;
  final String? mobileNo;
  final String? email;
  final String? password;

  User(
      {this.id,
      required this.name,
      required this.mobileNo,
      required this.email,
      required this.password});

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'mobileNo': mobileNo,
        'email': email,
        'password': password
      };
}
