import 'package:flutter/material.dart';
import 'package:nws_app/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
TextEditingController mailController = new TextEditingController();

String email="";
final _formKey=GlobalKey<FormState>();

resetPassword()async{
  try{
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.blueAccent,
      content: Text("Password reset email sent", style: TextStyle(fontSize: 18),),
    ));
  } on FirebaseAuthException catch(e){
    if(e.code=="user-not-found"){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text("User not found", style: TextStyle(fontSize: 18),),
      ));
    }
  }
}




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(child: Column(children: [
        SizedBox(height: 70,),
        Container(
          alignment: Alignment.topCenter,
          child: Text(
            "Password Recovery", 
            style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),),
        ),
        SizedBox(height: 10,),
        Text("Enter your email",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),),
        Expanded(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.only(left: 10),
        child: ListView(children: [
          Container(
            padding: EdgeInsets.only(left: 20,),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2),
              borderRadius: BorderRadius.circular(30),
            ),
            child: TextFormField(
              controller: mailController,
              validator: (value) {
                if(value==null || value.isEmpty){
                  return "Please enter your email address";
                }
                return null;
              },
              style: TextStyle(
                color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Email",
                  hintStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.white,),
                  prefixIcon: Icon(Icons.person, color: Colors.white70,size: 30,
                  ), border: InputBorder.none
                ),
            ),
          ),
          SizedBox(height: 40,),
          
                GestureDetector(
                  onTap: () {
                    if(_formKey.currentState!.validate()){
                      setState(() {
                        email=mailController.text;
                      });
                      resetPassword();
                    }
                  },
                  child: Container(
                    width: 140,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "Send Email",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),),
                    ),
                  ),
                ),
   SizedBox(height: 50,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text("Don't have an account?",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            ),),
            SizedBox(width: 10,),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Signup()));
              },
              child: Text("Create", style: TextStyle(
                color: Color.fromARGB(225, 184, 166, 6),
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),),
            )
        ],
        )
              ],
            ),
          )
       
        
        )),
       
      ],
      ),
      ),
    );
  }
}