import 'package:flutter/material.dart';
import 'package:nws_app/nwsapi/pages/home.dart';
import 'package:nws_app/other/widgets/widget_support.dart';

class NewsInfo extends StatefulWidget {
  const NewsInfo({super.key});

  @override
  State<NewsInfo> createState() => _NewsInfoState();
}

class _NewsInfoState extends State<NewsInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 70),
        child: Column(children: [
        Material(
          elevation: 2,
          child: Container(

            padding: EdgeInsets.only(bottom: 10),
            child: Center(child: Text("International News",style: AppWidget.HeadlineTextFieldStyle(),)))),
            SizedBox(height: 30,),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Color(0xFFF2F2F2)
              ),
              child: Row(children: [
Image.asset("images/n.jpg", height: 100, width: 100, fit: BoxFit.cover
               ),
               SizedBox(width: 40,),
               Column(children: [
                Text("Daily News", style: AppWidget.boldTextFieldStyle(),),
               ],)
              ],
              ),

            ),
            SizedBox(height: 80,),
            Row(children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
                  },
                  child: Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      padding: EdgeInsets.symmetric(vertical: 12),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(8)
                      ),
                                 child: Center(child: Text("Read Now", style: TextStyle(color: Colors.white, fontSize: 16, fontFamily: 'Poppins', fontWeight: FontWeight.bold),),), ),
                  ),
                ),
              )
            ],)

      ],),),
      );
  }
}