import 'package:acazia_training/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class FireStoreService{
  final CollectionReference _usersCollectionReference =
  Firestore.instance.collection('users');
  Future<void> createUser(User user) async {
    try {
      await _usersCollectionReference.document(user.id).setData(user.toJson());
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}