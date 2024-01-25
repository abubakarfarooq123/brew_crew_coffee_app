import 'package:brew_crew/model/brew.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/view/home/settings_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/services/database.dart';

import 'brewlist.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthServices _authServices = AuthServices();
  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel(){
      showModalBottomSheet(context: context, builder:(context){
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: const FormSettings(),
        );
      });
    }
    return StreamProvider<List<BrewModel>>.value(
      initialData: const [],
      value: DataServices().brews,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          title: const Text('Brew Crew'),
          actions: [
            IconButton(
                onPressed: () async{
                  await _authServices.signOut();
            },
                icon: const Icon(Icons.logout)),
            IconButton(
                onPressed: () => _showSettingsPanel(),
                icon: const Icon(Icons.settings)),
          ],
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/coffee_bg.png'),
              fit: BoxFit.cover
            )
          ),
            child: const BrewList()
        ),
      ),
    );
  }
}
