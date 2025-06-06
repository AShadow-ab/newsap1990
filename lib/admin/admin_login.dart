import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:nws_app/admin/home_admin.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
 TextEditingController usernamecontroller = new TextEditingController();
  TextEditingController userpasswordcontroller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFededeb),
      body: Container(
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/2,),
              padding: EdgeInsets.only(top:45, left:20, right:20),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color.fromARGB(255, 53, 51, 51), Colors.black],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight),
                  borderRadius: BorderRadius.vertical(
                    top:Radius.elliptical(MediaQuery.of(context).size.width,110))),
            ),
            Container(
              margin:EdgeInsets.only(left: 30, right: 30,top:60),
              child: Form(key: _formKey, child: Column(
                children: [
                  Text("Welcome Administrator", 
                  style: TextStyle(
                    color: Colors.black,
                     fontSize: 25.0, 
                     fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins'),),
                      SizedBox(height: 30,),
                      Material(
                        elevation: 3,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          height: MediaQuery.of(context).size.height/2.2,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(children: [
                            SizedBox(height: 50,),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 12.0),
                              margin: EdgeInsets.symmetric(horizontal: 20.0),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color.fromARGB(255, 160, 160, 147)),
                                borderRadius: BorderRadius.circular(10),
                                
                              ),
                            child: Center(
                              child: TextFormField(
                                controller: usernamecontroller,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please Enter Your Name';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: "Username",
                                   hintStyle: TextStyle( color: Color.fromARGB(
                                                255, 160, 160, 147)),
                                  border: InputBorder.none,
                                  prefixIcon: Icon(Icons.person),
                                ),
                              ),
                            ),
                            ),
                            SizedBox(height: 40,),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 12.0),
                              margin: EdgeInsets.symmetric(horizontal: 20.0),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color.fromARGB(255, 160, 160, 147)),
                                borderRadius: BorderRadius.circular(10),
                                
                              ),
                            child: Center(
                              child: TextFormField(
                                controller: userpasswordcontroller,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please Enter Your Password';
                                  }
                                  return null;
                                },
                                 decoration: InputDecoration(
                                  hintText: "Password",
                                  hintStyle: TextStyle( color: Color.fromARGB(
                                                255, 160, 160, 147)),
                                  border: InputBorder.none,
                                  prefixIcon: Icon(Icons.password),
                                ),
                              ),
                            ),
                            ),
                            SizedBox(height: 40,),
                            GestureDetector(
                              onTap: (){
                                LoginAdmin();
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 12.0),
                                margin: EdgeInsets.symmetric(horizontal: 20.0),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(10),
                                ), child: Center(
                                  child: Text("LogIn", style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins'
                                  ),),
                                ),
                              ),
                            )
                          ],),
                        ),
                      )
                ],
              ) 
              ),
              )
          ],
        ),
        )
    );
  }




  LoginAdmin(){
    FirebaseFirestore.instance.collection("Admin").get().then((snapshot) {
snapshot.docs.forEach((result) {
  if(result.data()['id']!=usernamecontroller.text.trim()){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.redAccent, 
          content:Text(
            "Incorrect Username", 
        style: TextStyle(
          fontSize: 17,
          fontFamily: 'Poppins', ),
          )));
  }
  else if(result.data()['password']!=userpasswordcontroller.text.trim()){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.redAccent, 
          content:Text(
            "Incorrect Password", 
        style: TextStyle(
          fontSize: 17,
          fontFamily: 'Poppins', ),
          )));
  } else {
    Route route = MaterialPageRoute(builder: (context) => HomeAdmin());
    Navigator.pushReplacement(context, route);
  }
});
    });
  }
}
