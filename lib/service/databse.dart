import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nws_app/admin/add_news.dart';

class DatabaseMethods {
  Future addUserDetail(Map<String, dynamic> userInfoMap, String id) async {
   return await FirebaseFirestore.instance
        .collection("Users")
        .doc(id)
        .set(userInfoMap);
        
  }

  Future AddNews(Map<String, dynamic> userInfoMap, String name) async {
   return await FirebaseFirestore.instance
        .collection(name)
        .add(userInfoMap);
}

Future<Stream<QuerySnapshot>> getNews(String name) async {
  return await FirebaseFirestore.instance
      .collection(name)
      .snapshots();
}





}