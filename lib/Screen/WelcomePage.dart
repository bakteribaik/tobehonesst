import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tobehonest/Screen/InputTag.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end:  Alignment.bottomCenter,
            colors: [
              Colors.red, 
              Color.fromARGB(255, 243, 170, 33)
            ]
          )
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Welcome', style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.width/25),),
              Text('ToBeHonest', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width/15),),
              SizedBox(height: 10,),
              Text('knowing what their thinking 😊', style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.width/35),),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 80,
        decoration: BoxDecoration(
        ),
        child: Center(
          child: GestureDetector(
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => InputInstagram()));
            },
            child: Container(
              width: MediaQuery.of(context).size.width/1.3,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25)
              ),
              child: Center(child: Text('Create a question', style: TextStyle(color: Colors.orange),)),
            ),
          ),
        ),
      ),
    );
  }
}