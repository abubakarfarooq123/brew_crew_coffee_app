import 'package:brew_crew/view/authenticate/login_screen.dart';
import 'package:brew_crew/view/authenticate/register.dart';
import 'package:flutter/material.dart';
class AuthenticateScreen extends StatefulWidget {
  const AuthenticateScreen({super.key});

  @override
  State<AuthenticateScreen> createState() => _AuthenticateScreenState();
}

class _AuthenticateScreenState extends State<AuthenticateScreen> {

  bool showSignIn = true;
  void toggleView (){
    setState(() => showSignIn = !showSignIn);
    print(showSignIn);
  }
  @override
  Widget build(BuildContext context) {
    if(showSignIn){
      return Login(toggleView: toggleView);
    }
    else{
      return Register(toggleView: toggleView);
    }
  }
}
