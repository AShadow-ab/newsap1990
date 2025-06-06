import 'package:flutter/material.dart';
// import 'package:newsapp/other/signup.dart';
import 'package:nws_app/nwsapi/pages/home.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: Column(children: [
        Material(
          elevation: 3,
          borderRadius: BorderRadius.circular(20),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset("images/p.jpeg",
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height/1.7,
            fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 20,),
        Text("News from around the\n      world just for you", style: TextStyle(color: Colors.black, fontSize: 28, fontWeight: FontWeight.bold),),
          SizedBox(height: 20,),
        Text("The best time to read is now sit back and\n              enjoy quality information", style: TextStyle(color: Colors.black45, fontSize: 20, fontWeight: FontWeight.w500),),
        
        
        
        SizedBox(height: 40,),
        GestureDetector(
          onTap:() {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> Home()));
                    },
          child: Container(
            width: MediaQuery.of(context).size.width/1.2,
            child: Material(
              borderRadius: BorderRadius.circular(30),
              elevation: 5,
              child: Container(
                width: MediaQuery.of(context).size.width/1.2,
                padding: EdgeInsets.symmetric(vertical: 16.0),
                decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(30)),
                     child: Center(
               child: Text(
                "Get Started", 
                style: TextStyle(
                  color: Colors.white, 
                  fontSize: 18, 
                  fontWeight: FontWeight.w500),),
                     ),
                 ),
            ),
          ),
        ),
      ],),),
    );
  }
}