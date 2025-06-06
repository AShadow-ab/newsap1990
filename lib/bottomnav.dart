import 'package:flutter/material.dart';
import 'package:nws_app/homes.dart';
import 'package:nws_app/newsinfo.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:nws_app/profile.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nws_app/service/notification_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}
class _BottomNavState extends State<BottomNav> {

  Timestamp? lastLoginTime;
int newNewsCount = 0;

  int currentTabIndex = 0;

 late List<Widget> pages;
 late Widget currentPage;
 late Homes homepage;
 late Profile profile;
 late NewsInfo newsinfo;
 

 @override 
 void initState() {
    homepage=Homes();
    newsinfo=NewsInfo();
     profile=Profile();
    
    pages=[homepage, newsinfo, profile];
    fetchUnreadNewsCount(); 
  }

  Future<void> fetchUnreadNewsCount() async {
  if (lastLoginTime != null) {
  var newsSnapshot = await FirebaseFirestore.instance
      .collection("news")
      .where("timestamp", isGreaterThan: lastLoginTime)
      .get();

  if (newsSnapshot.docs.isNotEmpty) {
    NotificationService.showNotification(
      title: "New News Available!",
      body: "${newsSnapshot.docs.length} new articles since your last login.",
    );
  }

  setState(() {
    newNewsCount = newsSnapshot.docs.length;
  });
}
}
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 65,
        backgroundColor: Colors.white,
        color: Colors.black,
        animationDuration: Duration(milliseconds: 500),
        onTap: (int index) async {
          setState(() {
            currentTabIndex=index;
          });
           if (index == 1) {
    setState(() {
      newNewsCount = 0;
    });

    await FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .update({
        "lastLogin": FieldValue.serverTimestamp()
      });
  }
        },
        items: 
      [Icon(
        Icons.home_outlined,
        color: Colors.white,
      ),
      badges.Badge(
  showBadge: newNewsCount > 0,
  badgeContent: Text(
    '$newNewsCount',
    style: TextStyle(color: Colors.white, fontSize: 12),
  ),
  child: Icon(Icons.newspaper_outlined, color: Colors.white),
),

      Icon(Icons.person_3_outlined, color: Colors.white,)
      ]),
      body: pages[currentTabIndex],
    );
  }
}