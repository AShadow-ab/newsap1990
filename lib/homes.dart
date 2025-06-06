import 'package:flutter/material.dart';
import 'package:nws_app/details.dart';
import 'package:nws_app/other/widgets/widget_support.dart';
import 'package:nws_app/service/databse.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Homes extends StatefulWidget {
  const Homes({super.key});

  @override
  State<Homes> createState() => _HomesState();
}

class _HomesState extends State<Homes> {

bool cots=false, fets=false, laws=false, favm=false;

Stream? newsStream;

ontheload()async{
  newsStream= await DatabaseMethods().getNews("cots");
  setState(() {
    
  });
}

@override
  void initState() {
  ontheload();
    super.initState();
  }

  Widget allItemsVertically(){

    return StreamBuilder(stream: newsStream, builder: (context, AsyncSnapshot snapshot){
      return snapshot.hasData? ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: snapshot.data.docs.length,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index){
          DocumentSnapshot ds= snapshot.data.docs[index];
return GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> Details(detail: ds["Detail"],name: ds["Name"], publisher: ds["Publisher"],image: ds["Image"],)));
            },
            child: Container(
        margin: EdgeInsets.only(right: 20, bottom: 20),
        child: Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: EdgeInsets.all(5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  ds["Image"], 
                  height: 130, 
                  width: 130, fit: BoxFit.cover,),
              ),
              SizedBox(width: 20,),
              Column(children: [
                Container(
                  width: MediaQuery.of(context).size.width/2,
                  child: Text(
                    ds["Name"], style: AppWidget.boldTextFieldStyle(),)),
                   SizedBox(height: 5,),
                   Container(
                  width: MediaQuery.of(context).size.width/2,
                  child: Text("Read More........", style: AppWidget.LightTextFieldStyle(),))
              ],)
            ],
          ),),
        ),
      ),
          );
      }):CircularProgressIndicator();
    });
  }

  Widget allItems(){

    return StreamBuilder(stream: newsStream, builder: (context, AsyncSnapshot snapshot){
      return snapshot.hasData? ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: snapshot.data.docs.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index){
          DocumentSnapshot ds= snapshot.data.docs[index];
return GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> Details(detail: ds["Detail"],name: ds["Name"], publisher: ds["Publisher"],image: ds["Image"],)));
            },
            child: Container(
              margin: EdgeInsets.all(4),
              child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        ds["Image"], 
                        height: 180,
                         width: 180, 
                         fit: BoxFit.cover,),
                    ),
                    Text(ds["Name"], style:AppWidget.HeadlineTextFieldStyle() ,),
                    SizedBox(height: 5,),
                     Text("Read More........", style:AppWidget.LightTextFieldStyle() ,),
                     Text(ds["Publisher"], style:AppWidget.boldTextFieldStyle() ,)
                  ],),
                ),
              ),
            ),
          );
      }):CircularProgressIndicator();
    });
  }

















  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 50.0, left: 20.0,),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Hello Student", 
                style: AppWidget.boldTextFieldStyle()
              ),
               Container(
                margin: EdgeInsets.only(right: 20.0),
                padding: EdgeInsets.all(3),
            decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(8)),
            child: Icon(Icons.newspaper, color: Colors.white,),
          ),
            ],
          ),
          SizedBox(height: 20,),
          Text("Curated News", 
                style: AppWidget.HeadlineTextFieldStyle()
              ),
           Text("Discover and Read News", 
                style: AppWidget.LightTextFieldStyle()
              ),
              SizedBox(height: 20.0,),
              
        
         Container(
          margin: EdgeInsets.only(right: 20),
          child: showItem()
          ),
        
         SizedBox(height: 30,),
         Container(
          height: 330,
          child: allItems()),
          SizedBox(height: 30,),
             allItemsVertically()
        
        
        
        
        
        
        
        
        
        
        
        ],
        ),
        ),
      ),
    );
  }

  Widget showItem(){
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        GestureDetector(
          onTap: ()async{
            cots=true;
            fets=false;
            laws=false;
            favm=false;
            newsStream= await DatabaseMethods().getNews("cots");
            setState(() {
              
            });
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
             decoration: BoxDecoration(color: cots?Colors.black:Colors.white, borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(8),
              child: Image.asset("images/cots.jpg", height: 50, width:50, fit: BoxFit.cover,),
            ),
          ),
        ),

       GestureDetector(
          onTap: ()async{
            cots=false;
            fets=true;
            laws=false;
            favm=false;
            newsStream= await DatabaseMethods().getNews("fets");
            setState(() {
              
            });
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
             decoration: BoxDecoration(color: fets?Colors.black:Colors.white, borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(8),
              child: Image.asset("images/fets.jpg", height: 50, width:50, fit: BoxFit.cover,),
            ),
          ),
        ),
        
        GestureDetector(
          onTap: ()async{
            cots=false;
            fets=false;
            laws=true;
            favm=false;
            newsStream= await DatabaseMethods().getNews("laws");
            setState(() {
              
            });
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
             decoration: BoxDecoration(color: laws?Colors.black:Colors.white, borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(8),
              child: Image.asset("images/trans.png", height: 50, width:50, fit: BoxFit.cover,),
            ),
          ),
        ),

       GestureDetector(
          onTap: ()async{
            cots=false;
            fets=false;
            laws=false;
            favm=true;
            newsStream= await DatabaseMethods().getNews("favm");
            setState(() {
              
            });
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
             decoration: BoxDecoration(color: favm?Colors.black:Colors.white, borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(8),
              child: Image.asset("images/favm.jpg", height: 50, width:50, fit: BoxFit.cover, ),
            ),
          ),
        ),

       ],);
  }
}