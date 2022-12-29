import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tobehonest/Screen/HomePage.dart';

class InputInstagram extends StatefulWidget {
  const InputInstagram({Key? key}) : super(key: key);

  @override
  State<InputInstagram> createState() => _InputInstagramState();
}

class _InputInstagramState extends State<InputInstagram> {

  TextEditingController _controller = TextEditingController();

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
              Color.fromRGBO(244, 67, 54, 1), 
              Color.fromARGB(255, 243, 170, 33)
            ]
          )
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Add your instagram tag', style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.width/30, fontWeight: FontWeight.bold),),
              SizedBox(height: 20,),
              Container(
                width: MediaQuery.of(context).size.width/1.4,
                padding: EdgeInsets.only(left: 20, right: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25)
                ),
                child: TextField(
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9_]'))],
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: '@instagram',
                    border: InputBorder.none,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 10,),
              Container(
                width: MediaQuery.of(context).size.width/2,
                child: Text('make sure you include the following tag same as instagram (optional)', style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.width/35), textAlign: TextAlign.center,),
              ),
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
            onTap: () async {
              if (_controller.text.isEmpty) {
                Fluttertoast.showToast(
                    msg: "you need to input instagram tag first!!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.TOP,
                    backgroundColor: Color.fromARGB(255, 36, 36, 36),
                    textColor: Colors.white,
                    fontSize: 12.0
                );
              }else{
                FirebaseFirestore.instance.collection('users')
                  .add({
                    'instagram_id' : _controller.text,
                    'page_link' : ''
                  })
                  .then((value) async {
                    final pref = await SharedPreferences.getInstance();
                    pref.setString('tempid', value.id);

                    //update page_link lalu navigasi ke home pages
                    FirebaseFirestore.instance.collection('users')
                      .doc(value.id)
                      .update({
                        'page_link' : 'https://tobehonest.vercel.app/?id=${value.id}&user=${_controller.text}'
                    });

                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(docID: value.id,)));
                  })
                  .catchError((e){
                    Fluttertoast.showToast(
                        msg: e.toString(),
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.TOP,
                        backgroundColor: Color.fromARGB(255, 36, 36, 36),
                        textColor: Colors.white,
                        fontSize: 12.0
                    );
                  });
              }
            },
            child: Container(
              width: MediaQuery.of(context).size.width/1.3,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25)
              ),
              child: Center(child: Text('Continue', style: TextStyle(color: Colors.orange),)),
            ),
          ),
        ),
      ),
    );
  }
}