import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model {
  bool isLoading = false;

  FirebaseAuth _auth = FirebaseAuth.instance;
  User firebaseUser;
  UserCredential credential;
  Map<String, dynamic> userData = Map();

  static UserModel of(BuildContext context) =>
      ScopedModel.of<UserModel>(context);


  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);

    _loadCurrentUser();
  }

  void signUp(
      {@required Map<String, dynamic> userData,
      @required String pass,
      @required VoidCallback onSucess,
      @required VoidCallback onFail}) {
    isLoading = true;
    notifyListeners();

    _auth.createUserWithEmailAndPassword(
            email: userData['email'], password: pass)
        .then((cred) async {
      credential = cred;
      firebaseUser = credential.user;

      await _saveUserData(userData);

      onSucess();
      isLoading = false;
      notifyListeners();
    }).catchError((e) {
      onFail();

      isLoading = false;
      notifyListeners();
    });
  }

  void signIn(
      {@required String email,
      @required String pass,
      @required VoidCallback onSucess,
      @required VoidCallback onFail}) async {
    isLoading = true;
    notifyListeners();

    _auth.signInWithEmailAndPassword(email: email, password: pass).then((cred) async {

      firebaseUser = cred.user;

      await _loadCurrentUser();

      isLoading = false;
      notifyListeners();

      onSucess();

    }).catchError((e) {
      onFail();
      isLoading = false;
      notifyListeners();
    });
  }

  void recoverPass(String email) {
    _auth.sendPasswordResetEmail(email: email);
  }

  bool isLoggedIn() {
    return firebaseUser != null;
  }

  void signOut() async {
    await _auth.signOut();

    userData = Map();
    credential = null;
    firebaseUser = null;

    notifyListeners();
  }

  Future<Null> _saveUserData(Map<String, dynamic> userData) async {
    this.userData = userData;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(credential.user.uid)
        .set(userData);
  }

  Future<Null> _loadCurrentUser() async{
    if (firebaseUser == null) {
      firebaseUser = await _auth.currentUser;
    }
    if (firebaseUser != null) {
      if (userData['name'] == null){
        DocumentSnapshot docUser =
            await FirebaseFirestore.instance.collection('users').doc(firebaseUser.uid).get();
        userData = docUser.data();
      }
    }
    notifyListeners();

  }
}
