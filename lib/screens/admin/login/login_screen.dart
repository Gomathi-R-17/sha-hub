import 'package:flutter/material.dart';
import 'package:rcc_project/components/constants.dart';
import 'package:rcc_project/screens/admin/login/body.dart';

class AdminLoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Admin Login",
          ),
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: bglight,
        body: Body());
  }
}
