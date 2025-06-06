import 'package:flutter/material.dart';
import 'package:nws_app/other/widgets/widget_support.dart';

class Details extends StatefulWidget {
  String image,name,detail,publisher;
  Details({required this.detail, required this.image, required this.name, required this.publisher});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 60, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.black,)),
          Image.network(widget.image, 
          width: MediaQuery.of(context).size.width,
           height: MediaQuery.of(context).size.height/2.5, 
           fit: BoxFit.fill,
           ),
           SizedBox(height: 15,),
           
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.name, style: AppWidget.semiBoldTextFieldStyle(),),
                
              ],
            ),
           
            Container(
              
              decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(8)),
              child: Icon(Icons.add_alert_rounded, color: Colors.white,),
            )
           ],
           ),
           SizedBox(height: 20,),
           Text(widget.detail, 
           maxLines: 4,
           style: AppWidget.LightTextFieldStyle(),
           ),
           SizedBox(height: 40,),
           Row(children: [
            
           ],),
           Spacer(),
           Padding(
             padding: const EdgeInsets.only(bottom: 40),
             child: Row(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text("Published By", style: AppWidget.semiBoldTextFieldStyle(),),
              Text(widget.publisher, style: AppWidget.HeadlineTextFieldStyle(),),
             ],)],),
           )
      ],
      ),
      ),
    );
  }
}