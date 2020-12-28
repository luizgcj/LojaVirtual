import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:loja_virtual/screens/login_screen.dart';
import 'package:loja_virtual/screens/signup_screen.dart';
import 'package:scoped_model/scoped_model.dart';
import 'models/cart_model.dart';
import 'screens/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    return ScopedModel<UserModel>(
        model: UserModel(),
        child: ScopedModelDescendant<UserModel>( //coloca dentro deste metodo para sempre que mudar o usuario, alterar o carrinho na hora
          builder: (context, child, model){ //este model é o UserModel
            return ScopedModel<CartModel>(
              model: CartModel(model),
              child: MaterialApp(
                title: "Shopping's Louis",
                theme: ThemeData(
                    primarySwatch: Colors.blue,
                    primaryColor: Color.fromARGB(255, 4, 125, 141)),
                debugShowCheckedModeBanner: false,
                home: HomeScreen(), //HomeScreen(),
              ),
            );
          },
        )
    );
  }
}
