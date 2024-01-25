import 'package:brew_crew/model/userModel.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/shared/constant.dart';
import 'package:provider/provider.dart';

import '../../services/database.dart';

class FormSettings extends StatefulWidget {
  const FormSettings({super.key});

  @override
  State<FormSettings> createState() => _FormSettingsState();
}

class _FormSettingsState extends State<FormSettings> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  // form values

  String? _currentName;
  String? _currentSugars;
  dynamic _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    return StreamBuilder<UserData>(
        stream: DataServices(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData? userData = snapshot.data;
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  const Text(
                    'Update your brew settings.',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),

                  // Name TextFormField

                  TextFormField(
                    initialValue: userData!.name,
                    decoration: textInputDecoration,
                    validator: (val) =>
                        val!.isEmpty ? 'please enter a name' : null,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),

                  // Sized box

                  const SizedBox(
                    height: 20.0,
                  ),

                  // Sugar Dropdown

                  DropdownButtonFormField<String>(
                    decoration: textInputDecoration,
                    value: _currentSugars ?? userData.sugars,
                    items: sugars.map((sugar) {
                      return DropdownMenuItem(
                        value: sugar,
                        child: Text("$sugar sugars"),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => _currentSugars = val),
                  ),

                  // Strength Slider

                  Slider(
                    activeColor: Colors.brown[_currentStrength ?? userData.strength],
                    inactiveColor: Colors.brown[_currentStrength ?? userData.strength],
                    min: 100.0,
                    max: 900.0,
                    value: (_currentStrength ?? userData.strength).toDouble(),
                    divisions: 8,
                    onChanged: (val) =>
                        setState(() => _currentStrength = val.round()),
                  ),

                  // Update Button

                  InkWell(
                    child: Container(
                        height: 40,
                        width: 120,
                        color: Colors.pink[400],
                        child: const Center(
                            child: Text(
                          'Update',
                          style: TextStyle(color: Colors.white),
                        ))),
                    onTap: () async {
                     if(_formKey.currentState!.validate()){
                       await DataServices(uid: user.uid).updateUserData(
                         _currentSugars ?? userData.sugars,
                         _currentName ?? userData.name,
                         _currentStrength ?? userData.strength
                       );
                       Navigator.pop(context);
                     }
                    },
                  ),
                ],
              ),
            );
          } else {
            return const Loading();
          }
        });
  }
}
