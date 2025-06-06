import 'package:flutter/material.dart';
import 'package:nws_app/bottomnav.dart';
import 'package:nws_app/homes.dart';
import 'package:nws_app/service/databse.dart';
import 'package:nws_app/service/shared_pref.dart';
import 'package:random_string/random_string.dart';
import 'package:nws_app/login.dart';
import 'package:nws_app/other/widgets/widget_support.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {

String email="", password="", name="", matricule="";
TextEditingController mailController= new TextEditingController();
TextEditingController passwordController=new TextEditingController(); 
TextEditingController nameController=new TextEditingController();
TextEditingController matriculeController=new TextEditingController();

final _formKey=GlobalKey<FormState>();

registration() async{
  if(password!=null){
    try{
      UserCredential userCredential=await FirebaseAuth.instance
      .createUserWithEmailAndPassword(email: email, password: password);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.blueAccent, 
        content: Text(
          "Account Created Successfully", 
      style: TextStyle(
        fontSize: 20,
        fontFamily: 'Poppins', fontWeight: FontWeight.bold
        ),),));
      String Id = randomAlphaNumeric(10);
      Map<String, dynamic> addUserInfo = {
      "Name": nameController.text,
      "Matricule": matriculeController.text,
      "Email": mailController.text,
      "Id": Id,
      };
      await DatabaseMethods().addUserDetail(addUserInfo, Id);
  await SharedPreferenceHelper().saveUserName(nameController.text);
  await SharedPreferenceHelper().saveUserEmail(mailController.text);
  await SharedPreferenceHelper().saveUserMatricule(matriculeController.text);
  await SharedPreferenceHelper().saveUserId(Id);

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> BottomNav()));
    } on FirebaseException catch(e){
      if(e.code=="weak-password"){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.redAccent, 
          content:Text(
            "Password is too weak", 
        style: TextStyle(
          fontSize: 17,
          fontFamily: 'Poppins', 
          ),),
       ));


    }
    else if(e.code=="email-already-in-use"){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.redAccent, 
        content: Text(
          "Email already in use", 
        style: TextStyle(
          fontSize: 17,
          ),),
       
       ));
  }
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
          height: MediaQuery.of(context).size.height/1.7,
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Form(
            key: _formKey,
            child: Column(children: [
              SizedBox(height: 30,),
              Text("Sign Up", style: AppWidget.HeadlineTextFieldStyle()),
              
              SizedBox(height: 30,),
              TextFormField(
                controller: nameController,
                validator: (value){
                  if(value!.isEmpty|| value==null){
                    return "Please enter your name";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: 'Name', 
                  hintStyle: AppWidget.semiBoldTextFieldStyle(), 
                  prefixIcon: Icon(Icons.person_outline_outlined)),
              ),
               SizedBox(height: 30,),
              TextFormField(
                 controller: matriculeController,
                validator: (value){
                  if(value!.isEmpty|| value==null){
                    return "Please enter your matricule";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: 'Matricule', 
                  hintStyle: AppWidget.semiBoldTextFieldStyle(), 
                  prefixIcon: Icon(Icons.developer_board_outlined)),
              ),
               
               
               SizedBox(height: 30,),
              TextFormField(
                 controller: mailController,
                validator: (value){
                  if(value!.isEmpty|| value==null){
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
                 controller: passwordController,
                validator: (value){
                  if(value!.isEmpty|| value==null){
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
             
                SizedBox(height: 80,),
                GestureDetector(
                  onTap: ()async{
                    if(_formKey.currentState!.validate()){
                     setState(() {
                        email=mailController.text;
                        password=passwordController.text;
                        name=nameController.text;
                        matricule=matriculeController.text;
                     });
                    }
                    registration();
                  },
                  child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 9),
                      width: 200,
                      decoration: BoxDecoration(color: Color.fromARGB(234, 31, 112, 199), borderRadius: BorderRadius.circular(20) ),
                      child: Center(child:
                       Text("SIGNUP", 
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
          Navigator.push(context, MaterialPageRoute(builder: (context)=> LogIn()));
        },
        child: Text("Already have an account? Log In", style: AppWidget.semiBoldTextFieldStyle(),)),
    ],),
  )
      ],),),
    );
  }
}