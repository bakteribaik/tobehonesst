import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tobehonest/Screen/InboxPage.dart';

class HomePage extends StatefulWidget {
  final String docID;

  const HomePage({Key? key, required this.docID}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var link = '';
  var docid = '';

  _getData() async {
    if (widget.docID.isNotEmpty) {
      setState(() {
        docid = widget.docID;
      });
      FirebaseFirestore.instance
      .collection('users')
      .doc('${widget.docID}')
      .get()
      .then((value){
        if (value.exists) {
          var data = value.data() as Map<String, dynamic>;
          setState(() {
            link = data['page_link'];
          });
        }
      });
      setState(() {});
    }else{
      final pref = await SharedPreferences.getInstance();
      setState(() {
        docid = pref.getString('tempid').toString();
        print(docid);
      });
      FirebaseFirestore.instance
      .collection('users')
      .doc('${pref.getString('tempid')}')
      .get()
      .then((value){
        if (value.exists) {
          var data = value.data() as Map<String, dynamic>;
          setState(() {
            link = data['page_link'];
          });
        }
      });
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          Stack(children: [
            IconButton(
              onPressed: () async {
                Navigator.push(context, MaterialPageRoute(builder: (context) => InboxPages(docID: docid)));
                print(docid);
              }, 
              icon: Icon(Icons.notifications_active_outlined)
            ),
            Positioned(
              top: 6,
              right: 6,
              child: Container(
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 0, 255, 221),
                  borderRadius: BorderRadius.circular(100),
                  // border: Border.all(color: Colors.white, width: 2)
                ),
              ),
            ),
          ],)
        ],
      ),
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
              Text('Preview displayed message on inbox', style: TextStyle(color: Colors.white),),
              SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width/1.3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                  border: Border.all(width: 2, color: Color.fromARGB(255, 41, 41, 41)),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(255, 0, 238, 255),
                      blurRadius: 0,
                      offset: Offset(0, 7),
                      spreadRadius: -1
                    )
                  ]
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(radius: 15, backgroundColor: Color.fromARGB(255, 174, 229, 255),),
                        SizedBox(width: 10,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Message from anonim', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.grey),),
                          ],
                        )
                      ],
                    ),
                    Divider(thickness: 1),
                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      child: Text('This is a test message, just for preview hehehe'),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Divider(thickness: 2),
              SizedBox(height: 20,),
              Text('how to use', style: TextStyle(color: Colors.white),),
              SizedBox(height: 10,),
              Container(
                padding: EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width/1.1,
                decoration: BoxDecoration(
                  color: Color.fromARGB(38, 26, 26, 26),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Step 1: Copy this link', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                    SizedBox(height: 15,),
                    Container(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: SelectableText(link, style: TextStyle(color: Color.fromARGB(148, 255, 255, 255), fontSize: 13), textAlign: TextAlign.center,)
                    ),
                    SizedBox(height: 15,),
                    GestureDetector(
                      onTap: () async {
                        await Clipboard.setData(ClipboardData(text: link));
                        Fluttertoast.showToast(
                            msg: "success copy link",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.TOP,
                            backgroundColor: Color.fromARGB(255, 36, 36, 36),
                            textColor: Colors.white,
                            fontSize: 12.0
                        );
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width/2,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 2, color: Color.fromARGB(255, 41, 41, 41)),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 0, 238, 255),
                              blurRadius: 0,
                              offset: Offset(0, 4),
                              spreadRadius: -1
                            )
                          ]
                        ),
                        child: Center(child: Text('🔗 Copy URL', style: TextStyle(fontSize: 13),)),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width/1.1,
                decoration: BoxDecoration(
                  color: Color.fromARGB(38, 26, 26, 26),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Step 2: Paste that link into "sticker link" on instagram stories', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                    SizedBox(height: 15,),
                    GestureDetector(
                      onTap: () async {
                        await LaunchApp.openApp(
                          androidPackageName: 'com.instagram.android',
                          openStore: true
                        );
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width/2,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 2, color: Color.fromARGB(255, 41, 41, 41)),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(255, 0, 238, 255),
                                blurRadius: 0,
                                offset: Offset(0, 5),
                                spreadRadius: -1
                              )
                            ]
                        ),
                        child: Center(child: Text('📸 Open Instagram', style: TextStyle(fontSize: 13, color: Colors.white),)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}