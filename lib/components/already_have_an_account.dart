import 'package:flutter/material.dart';
import 'package:rcc_project/components/constants.dart';

class AlreadyHaveAnAccount extends StatelessWidget {
  final bool login;
  final Function()? press;
  const AlreadyHaveAnAccount({
    Key? key,
    this.login = true,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      Text(login ? "Don't have an Account ? " : "Already have an Account ? ",
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 15.0,
              color: Colors.white)),
      GestureDetector(
          onTap: press,
          child: Text(login ? "Sign Up" : "Log in",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15.0,
                  color: Colors.white)))
    ]);
  }
}
