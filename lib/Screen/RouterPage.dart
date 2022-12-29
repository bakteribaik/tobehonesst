import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tobehonest/Screen/HomePage.dart';
import 'package:tobehonest/Screen/WelcomePage.dart';

class RouterPage extends StatefulWidget {
  const RouterPage({Key? key}) : super(key: key);

  @override
  State<RouterPage> createState() => _RouterPageState();
}

class _RouterPageState extends State<RouterPage> {

  _navigate() async {
    final pref = await SharedPreferences.getInstance();
    var id = pref.getString('tempid');

    if (id != null) {
      Future.delayed(Duration.zero,() => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(docID: id))));
    }else{
      Future.delayed(Duration.zero,() => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => WelcomePage())));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _navigate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}