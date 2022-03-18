import 'package:flutter/material.dart';
import 'package:rcc_project/components/constants.dart';
import 'package:rcc_project/screens/customer/signup/body.dart';

class BuyerSignupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text(
              "Buyer Sign Up",
              textAlign: TextAlign.center,
            )),
        backgroundColor: bglight,
        body: Body());
  }
}
