import 'dart:convert';

import 'package:nws_app/nwsapi/model/article_model.dart';
import 'package:http/http.dart' as http;

class News{
  List<ArticleModel> news = [];

  Future<void> getNews() async{
    String url=
    "https://newsapi.org/v2/everything?q=tesla&from=2025-05-05&sortBy=publishedAt&apiKey=fd4bf6c586ff4ebabae3a7663c50e09e";
    var response = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(response.body);
    if(jsonData['status']== 'ok'){
      jsonData["articles"].forEach((element){
        if(element["urlToImage"]!=null && element['description']!=null){
          ArticleModel articleModel = ArticleModel(
            title: element["title"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],  
            content: element["content"],
            author: element["author"],
          );
          news.add(articleModel);
        }
      });
    }
  }
}