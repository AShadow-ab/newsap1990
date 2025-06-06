import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:nws_app/other/widgets/widget_support.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:nws_app/service/notification_service.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:nws_app/service/databse.dart';
import 'package:random_string/random_string.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class AddNews extends StatefulWidget {
  const AddNews({super.key});

  @override
  State<AddNews> createState() => _AddNewsState();
}

class _AddNewsState extends State<AddNews> {
  final List<String>items=['cots','fets','laws','favm'];
  String? value;
TextEditingController namecontroller = new TextEditingController();
TextEditingController publishcontroller = new TextEditingController();
TextEditingController detailcontroller = new TextEditingController();
final ImagePicker _picker = ImagePicker();
File? selectedImage;

Future getImage() async {
  var image = await _picker.pickImage(source: ImageSource.gallery);

  selectedImage = File(image!.path);
  setState(() {
    
  });
}


uploadItem() async {
    if (selectedImage != null &&
        namecontroller.text != "" &&
        publishcontroller.text != "" &&
        detailcontroller.text != "" ) {
      String addId = randomAlphaNumeric(10);

      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child("blogImages").child(addId);
      final UploadTask task = firebaseStorageRef.putFile(selectedImage!);

      var downloadUrl = await (await task).ref.getDownloadURL();

      Map<String, dynamic> addItem = {
        "Image": downloadUrl,
        "Name": namecontroller.text,
        "Publisher": publishcontroller.text,
        "Detail": detailcontroller.text,
        "timestamp": FieldValue.serverTimestamp()
      };
      await DatabaseMethods().AddNews(addItem, value!).then((value) {
         NotificationService.showNotification(
    title: "New News Uploaded!",
    body: namecontroller.text,
  );
  
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.blueAccent,
            content: Text(
              "News has been added Successfully",
              style: TextStyle(fontSize: 18.0),
            )));
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios_new, color: Color(0xFF373866),)),
          centerTitle: true,
          title: Text("Add News",style: AppWidget.HeadlineTextFieldStyle()),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20,top:20, bottom: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Upload News Picture", style: AppWidget.semiBoldTextFieldStyle(),),
              SizedBox(height: 20,),
             selectedImage==null?   GestureDetector(
              onTap: () {
                getImage();
              },
               child: Center(
                  child: Material(
                    elevation: 4.0,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(Icons.add_a_photo_outlined, color: Colors.black,),
                    )
                  ),
                ),
             ): Center(
                child: Material(
                  elevation: 4.0,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.file(
                        selectedImage!, 
                        fit: BoxFit.cover,
                        ),
                    ),
                  )
                ),
              ),
              SizedBox(height: 30,),
              Text("News Title", style: AppWidget.semiBoldTextFieldStyle(),),
              SizedBox(height: 10,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xFFececf8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: namecontroller,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter News Name",
                    hintStyle: AppWidget.LightTextFieldStyle()
                  ),
                ),
              ),
              SizedBox(height: 30,),
              Text("News Publisher", style: AppWidget.semiBoldTextFieldStyle(),),
              SizedBox(height: 30,),
               Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xFFececf8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: publishcontroller,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter News Publisher",
                    hintStyle: AppWidget.LightTextFieldStyle()
                  ),
                ),
              ),
              SizedBox(height: 30,),
              Text("News Detail", style: AppWidget.semiBoldTextFieldStyle(),),
              SizedBox(height: 30,),
               Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xFFececf8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  maxLines: 6,
                  controller: detailcontroller,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter News Detail",
                    hintStyle: AppWidget.LightTextFieldStyle()
                  ),
                ),
              ),
               SizedBox(height:20,),
              Text("Select Faculty", style: AppWidget.semiBoldTextFieldStyle(),),
              
              SizedBox(height: 20,),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Color(0xFFececf8),
                      borderRadius: BorderRadius.circular(10)),
                  child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                    items: items
                        .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style:
                                  TextStyle(fontSize: 18.0, color: Colors.black),
                            )))
                        .toList(),
                    onChanged: ((value) => setState(() {
                          this.value = value;
                        })),
                    dropdownColor: Colors.white,
                    hint: Text("Select Faculty", style: TextStyle(fontFamily: 'Poppins'),),
                    iconSize: 36,
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                    ),
                    value: value,
                  )),
             
                       ),
                        SizedBox(height: 30,),
                       GestureDetector(
                        onTap:(){
                          uploadItem();
                        },
                         child: Center(
                           child: Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(10),
                             child: Container(
                              padding: EdgeInsets.symmetric(vertical: 5.0),
                              width: 150,
                              decoration: BoxDecoration(color: Colors.black,
                                borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: Text("Upload", style: 
                                  TextStyle(
                                    color: Colors.white, 
                                    fontSize: 22, 
                                    fontFamily: 'Poppins', 
                                    fontWeight: FontWeight.bold),
                                    ),
                                ), 
                                    ),
                           ),
                         ),
                       )
              
        
        
        
        ],
        ),
        ),
      ),
    );
  }
}