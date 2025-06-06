import 'package:flutter/material.dart';
import 'package:nws_app/bottomnav.dart';
import 'package:nws_app/forgot_password.dart';
import 'package:nws_app/homes.dart';
import 'package:nws_app/signup.dart';
import 'package:nws_app/other/widgets/widget_support.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
String email="", password="";

final _formKey=GlobalKey<FormState>();
TextEditingController useremailcontroller = new TextEditingController();
TextEditingController userpasswordcontroller = new TextEditingController();

userLogin() async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: useremailcontroller.text.trim(),
      password: userpasswordcontroller.text,
    );

    // If login successful
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Color.fromARGB(255, 11, 27, 206),
      content: Text(
        "Login Successful",
        style: TextStyle(fontSize: 17, fontFamily: 'Poppins', fontWeight: FontWeight.bold),
      ),
    ));

   await FirebaseFirestore.instance
    .collection('users')
    .doc(FirebaseAuth.instance.currentUser!.uid)
    .set({
      "lastLogin": FieldValue.serverTimestamp()
    }, SetOptions(merge: true));

Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (context) => BottomNav()));


  } on FirebaseAuthException catch (e) {
    if (e.code == "user-not-found") {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text(
          "User not found",
          style: TextStyle(fontSize: 17),
        ),
      ));
    } else if (e.code == "wrong-password") {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text(
          "Wrong password",
          style: TextStyle(fontSize: 17),
        ),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text(
          "Error: ${e.message}",
          style: TextStyle(fontSize: 17),
        ),
      ));
    }
  }
}




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height/2.5,
          decoration: BoxDecoration(gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
            Color.fromARGB(234, 27, 99, 182), 
            Color.fromARGB(234, 22, 98, 184), 
          ])),
        ),
Container(
  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/3),
  height: MediaQuery.of(context).size.height/2,
  width: MediaQuery.of(context).size.width,
  decoration: BoxDecoration(
    color: Colors.white, 
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(40), 
      topRight: Radius.circular(40))),
  child: Text(""),
  ),
  Container(
    margin: EdgeInsets.only(top: 60, left: 20, right: 20),
    child: Column(children: [
      Center(child: Image.asset("images/newso.png", width: MediaQuery.of(context).size.width/2.5,fit: BoxFit.cover,)),
      SizedBox(height: 10,),
      Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height/2,
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Form(
            key: _formKey,
            child: Column(children: [
              SizedBox(height: 30,),
              Text("Login", style: AppWidget.HeadlineTextFieldStyle()),
              SizedBox(height: 30,),
              TextFormField(
                controller: useremailcontroller,
                validator: (value) {
                  if(value==null || value.isEmpty){
                    return "Please enter your email";
                  }
                 return null;
                },
                decoration: InputDecoration(
                  hintText: 'Email', 
                  hintStyle: AppWidget.semiBoldTextFieldStyle(), 
                  prefixIcon: Icon(Icons.email_outlined)),
              ),
               SizedBox(height: 30,),
              TextFormField(
                controller: userpasswordcontroller,
                validator: (value) {
                  if(value==null || value.isEmpty){
                    return "Please enter your password";
                  }
                 return null;
                },
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password', 
                  hintStyle: AppWidget.semiBoldTextFieldStyle(), 
                  prefixIcon: Icon(Icons.password_outlined)),
              ),
              SizedBox(height: 20,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ForgotPassword()));
                },
                child: Container(
                  alignment: Alignment.topRight,
                  child: Text("Forgot Password?", style: AppWidget.semiBoldTextFieldStyle(),)),
              ),
                SizedBox(height: 80,),
                GestureDetector(
                  onTap: (){
                    if(_formKey.currentState!.validate()){
                     userLogin();
                    }
                  },  
                  child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 9),
                      width: 200,
                      decoration: BoxDecoration(color: Color.fromARGB(234, 31, 112, 199), borderRadius: BorderRadius.circular(20) ),
                      child: Center(child:
                       Text("LOGIN", 
                       style: TextStyle(
                        color: Colors.white, 
                        fontSize: 18.0, 
                        fontFamily: 'Poppins', 
                        fontWeight: FontWeight.bold),
                        )),
                    ),
                  ),
                ),
                
            ],),
          ),),
      ),
      SizedBox(height: 70,),
      GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> Signup()));
        },
        child: Text("Don't have an account? Sign up", style: AppWidget.semiBoldTextFieldStyle(),)),
    ],),
  )
      ],),),
    );
  }
}