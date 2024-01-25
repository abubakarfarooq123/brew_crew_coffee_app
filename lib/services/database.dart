import 'package:brew_crew/model/brew.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/userModel.dart';

class DataServices {
  String? uid;
  DataServices({this.uid});

  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('brews');

  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  // list from snapshot

  List<BrewModel> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return BrewModel(
          name: doc.get('name') ?? '',
          sugars: doc.get('sugars') ?? '0',
          strengths: doc.get('strength') ?? 0);
    }).toList();
  }

  // user data from snapshot

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid!,
        name: snapshot.get('name'),
        sugars: snapshot.get('sugars'),
        strength: snapshot.get('strength'));
  }

  // get Stream

  Stream<List<BrewModel>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  // get user doc Stream

  Stream<UserData> get userData {
    return brewCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

}

