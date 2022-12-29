import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:social_share/social_share.dart';

class InboxDetail extends StatefulWidget {
  final String messages;
  const InboxDetail({Key? key, required this.messages}) : super(key: key);

  @override
  State<InboxDetail> createState() => _InboxDetailState();
}

class _InboxDetailState extends State<InboxDetail> {

   final _screenshotController = ScreenshotController();


  Future saveAndShare(Uint8List bytes) async {
    final dir = await getApplicationDocumentsDirectory();
    final image = File('${dir.path}/capture.png');
    image.writeAsBytesSync(bytes);

    await SocialShare.shareInstagramStory(imagePath: image.path, appId: 'com.instagram.android', backgroundTopColor: "#F44336", backgroundBottomColor: "#F3AA21");
  } 
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end:  Alignment.bottomCenter,
            colors: [
              Color(0xFFF44336), 
              Color(0xFFF3AA21)
            ]
          )
        ),
        child: Center(
          child: Screenshot(
            controller: _screenshotController,
            child: Container(
              padding: EdgeInsets.only(left:50, top: 10, bottom: 10, right: 50),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
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
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(20),
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                        color: Color.fromARGB(255, 238, 238, 238),
                      ),
                      child: Text('Message from anonim', style: TextStyle(fontWeight: FontWeight.bold),),
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Text('${widget.messages}'),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        onPressed: () async{
                          final image = await _screenshotController.captureFromWidget(
                            Container(
                              padding: EdgeInsets.only(left:50, top: 10, bottom: 10, right: 50),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
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
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(20),
                                      alignment: Alignment.center,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                                        color: Color.fromARGB(255, 238, 238, 238),
                                      ),
                                      child: Text('Message from anonim', style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 48, 48, 48), fontSize: 17),),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(20),
                                      child: Text('${widget.messages}', style: TextStyle(fontWeight: FontWeight.bold,color: Color.fromARGB(255, 32, 32, 32), fontSize: 17), textAlign: TextAlign.center,),
                                    ),
                                    Divider(),
                                    Text('made with ToBeHonest App', style: TextStyle(color: Colors.grey, fontSize: 9),),
                                    SizedBox(height: 10,)
                                  ],
                                )
                              )
                            ),
                          );
                          saveAndShare(image);
                        }, 
                        icon: Icon(Icons.share)
                      ),
                    )
                  ],
                )
              )
            ),
          ),
        )
      ),
    );
  }
}