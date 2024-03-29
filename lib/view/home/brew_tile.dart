import 'package:flutter/material.dart';
import 'package:brew_crew/model/brew.dart';
class BrewTile extends StatelessWidget {
  final BrewModel brew;
  const BrewTile({super.key, required this.brew});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 20.0),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: const AssetImage('assets/images/coffee_icon.png'),
            radius: 25.0,
             backgroundColor: Colors.brown[brew.strengths],
          ),
          title: Text(brew.name),
          subtitle: Text("Takes ${brew.sugars} sugar(s)"),
        ),
      ),
    );
  }
}
