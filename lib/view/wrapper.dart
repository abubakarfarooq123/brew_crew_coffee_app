import 'package:brew_crew/model/userModel.dart';
import 'package:brew_crew/view/authenticate/authentication.dart';
import 'package:brew_crew/view/home/homeScreen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);
    if(user == null){
      return const AuthenticateScreen();
    }
    else{
      return const HomeScreen();

    }
  }
}
