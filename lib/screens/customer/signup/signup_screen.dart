import 'package:flutter/material.dart';
import 'package:rcc_project/components/constants.dart';
import 'package:rcc_project/screens/customer/signup/body.dart';

class CustomerSignupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text(
              "Customer Sign Up",
            )),
        backgroundColor: bglight,
        body: Body());
  }
}
