import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:social_share/social_share.dart';
import 'package:tobehonest/Screen/InboxDetailPage.dart';

class InboxPages extends StatefulWidget {
  final String docID;
  const InboxPages({Key? key, required this.docID}) : super(key: key);

  @override
  State<InboxPages> createState() => _InboxPagesState();
}

class _InboxPagesState extends State<InboxPages> { 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
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
          child: Container(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance.collection('users').doc('${widget.docID}').collection('inbox').orderBy('timestamp', descending: true).get(),
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.done){
                  if (snapshot.data!.size == 0) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('No inbox yet', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                          Text('start to share your link to get new messages', style: TextStyle(color: Colors.white),),
                        ],
                      )
                    );
                  }else{
                    return GridView.count(
                      mainAxisSpacing: 4,
                      crossAxisCount: 4,
                      children: snapshot.data!.docs.map((DocumentSnapshot document){
                        var data = document.data() as Map<String, dynamic>;
                        return GestureDetector(
                          onTap: (){
                            FirebaseFirestore.instance.collection('users').doc(widget.docID).collection('inbox').doc(document.id).update({'opened' : true});
                            Navigator.push(context, MaterialPageRoute(builder: (context) => InboxDetail(messages: data['messages'])));
                          },
                          child: Container(
                            padding: EdgeInsets.all(5),
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: data['opened'] == true ? Color.fromARGB(88, 255, 255, 255) : Colors.white
                              ),
                              child: Icon(Icons.favorite, color: data['opened'] == true ? Color.fromARGB(167, 245, 245, 245) : Colors.red, size: 40,),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  }
                }else{
                  return Center(child: CircularProgressIndicator(color: Colors.white,),);
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}