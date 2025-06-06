import 'package:flutter/material.dart';
import 'package:nws_app/admin/add_news.dart';
import 'package:nws_app/other/widgets/widget_support.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({super.key});

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Container(
        margin: EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
        child: Column(
          children: [
            Center(child: Text("Admin Home", style: AppWidget.HeadlineTextFieldStyle(),),),
            SizedBox(height: 50.0,),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> AddNews()));
              },
              child: Material(
                elevation: 10.0,
                borderRadius: BorderRadius.circular(10),
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                      
                    ),
                    child: Row(children: [
                      Padding(padding: EdgeInsets.all(6.0),
                      child: Image.asset("images/n.jpg", height: 100, width: 100, fit: BoxFit.cover,),),
                  SizedBox(width: 30.0,) ,
                  Text("Upload News", style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),) ],),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}