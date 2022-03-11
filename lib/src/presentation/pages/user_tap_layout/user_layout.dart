import 'package:flutter/material.dart';
import 'package:technical_test/src/core/utils/extensions/hex_color.dart';
import 'package:technical_test/src/data/sources/firebase_authentication.dart';
import 'package:technical_test/src/presentation/pages/user_tap_layout/sub_pages/case_2.dart';
import 'package:technical_test/src/presentation/widgets/animations/animated_onTap_button.dart';

class UserLayout extends StatefulWidget {
  const UserLayout({Key? key}) : super(key: key);

  @override
  _UserLayoutState createState() => _UserLayoutState();
}

class _UserLayoutState extends State<UserLayout> with SingleTickerProviderStateMixin{
  /// instance of firebase authentication
  final FirebaseAuthentication _authentication = FirebaseAuthentication();
  /// controller
  late TabController _tabBarController;

  @override
  void initState() {
    _tabBarController = TabController(length: 2, vsync: this);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor.fromHex('#EFEEEE'),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            'Technical test',
            style: TextStyle(
              color: HexColor.fromHex('#1C2938'),
              fontWeight: FontWeight.w600
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: AnimatedOnTapButton(
              onTap: (){
                _authentication.signOut();
              },
              child: Icon(
                Icons.logout,
                color: HexColor.fromHex('#1C2938'),
                size: 30,
              ),
            ),
          )
        ],
        bottom: TabBar(
          controller: _tabBarController,
          indicatorColor: Colors.red,
          tabs: <Widget>[
            Tab(
              child: Text(
                'Case #2',
                style: TextStyle(
                  color: HexColor.fromHex('#1C2938'),
                  fontSize: 15
                ),
              ),
            ),
            Tab(
              child: Text(
                'Case #3 & #4',
                style: TextStyle(
                    color: HexColor.fromHex('#1C2938'),
                    fontSize: 15
                ),
              ),
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabBarController,
        children: <Widget>[
          const Case2(),
          Container(color: Colors.orange,),
        ],
      ),
    );
  }
}
