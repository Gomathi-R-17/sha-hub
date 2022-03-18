import 'package:rcc_project/components/text_field_container.dart';
import 'package:flutter/material.dart';
import 'package:rcc_project/components/constants.dart';

class BuyerPasswordResetScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BuyerPasswordResetScreenState();
  }
}

class _BuyerPasswordResetScreenState extends State<BuyerPasswordResetScreen> {
  TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: bglight,
      appBar: AppBar(
          title: Text("Reset Password"), backgroundColor: Colors.transparent),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: size.height * 0.03),
              Image.asset('assets/images/forgot_password.png',
                  height: size.height * 0.35),
              SizedBox(height: size.height * 0.03),
              emailInputField("Email Address", size, _emailController),
              SizedBox(height: size.height * 0.03),
              button("RESET PASSWORD", size, () async {})
            ],
          ),
        ),
      ),
    );
  }

  void showMessage(String message) {
    final snackbar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
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
}
