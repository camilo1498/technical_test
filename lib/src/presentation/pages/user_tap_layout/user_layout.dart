import 'package:flutter/material.dart';
import 'package:technical_test/src/data/sources/firebase_authentication.dart';

class UserLayout extends StatefulWidget {
  const UserLayout({Key? key}) : super(key: key);

  @override
  _UserLayoutState createState() => _UserLayoutState();
}

class _UserLayoutState extends State<UserLayout> {
  /// instance of firebase authentication
  final FirebaseAuthentication _authentication = FirebaseAuthentication();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Center(
        child: MaterialButton(
          color: Colors.black,
          onPressed: (){
            _authentication.signOut();
          },
        ),
      ),
    );
  }
}
