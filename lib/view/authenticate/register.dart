import 'package:brew_crew/shared/constant.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../services/auth.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  const Register({super.key, required this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthServices _authServices = AuthServices();

  String email = '';
  String password = '';
  String error = '';
  bool loading = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return loading ? const Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        title: const Text('Register'),
        elevation: 0.0,
        actions: [
          IconButton(onPressed: () {
            widget.toggleView();
            },
              icon: const Icon(Icons.account_circle))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 20.0,
              ),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Enter Email'),
                validator: (String? value) {
                  if (value != null && value.isEmpty) {
                    return "Username can't be empty";
                  }
                  return null;
                },
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Enter Password'),
                validator: (String? value) {
                  if (value != null && value.isEmpty && value.length <6) {
                    return "Password length is less ";
                  }
                  return null;
                },  onChanged: (val) {
                  setState(() => password = val);
                },
                obscureText: true,
              ),
              const SizedBox(
                height: 20.0,
              ),
              InkWell(
                child: Container(
                  height: 35,
                  width: 100,
                  color: Colors.brown[400],
                  child: Center(
                    child: Text(
                      'Sign Up',
                      style: GoogleFonts.poppins(
                          color: Colors.white),
                    ),
                  ),
                ),
                onTap: () async {
                  if(_formKey.currentState!.validate()) {
                    setState(() => loading = true);
                    try {
                      dynamic result = await _authServices.registerWithEmailAndPassword(
                          email, password);
                      if(result == null){
                        setState(() {
                          error = 'Could Not Login with these credentials';
                          loading = false;
                        });
                      }
                    }
                    catch (e) {
                      if (kDebugMode) {
                        print('Sign in error: $e');
                      }
                    }
                  }
                },
              ),
              const SizedBox(
                height: 12.0,
              ),
              Text(error,style: GoogleFonts.poppins(
                color: Colors.red,
              ),)
            ],
          ),
        ),
      ),
    );
  }
}
