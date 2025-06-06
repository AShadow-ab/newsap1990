import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:nws_app/nwsapi/model/article_model.dart';
import 'package:nws_app/nwsapi/model/category_model.dart';
import 'package:nws_app/nwsapi/model/slider_data.dart';
import 'package:nws_app/nwsapi/model/slider_model.dart';
import 'package:nws_app/nwsapi/pages/all_news.dart';
import 'package:nws_app/nwsapi/pages/article_view.dart';
import 'package:nws_app/nwsapi/pages/category_news.dart';
import 'package:nws_app/nwsapi/services/data.dart';
import 'package:nws_app/nwsapi/services/news.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

List<CategoryModel> categories = [];
List<sliderModel> sliders=[];
List<ArticleModel> articles = [];
bool _loading=true;


int activeIndex = 0;
@override
  void initState() {
    categories= getCategories();
    getSlider();
    getNews();
    super.initState();
  }

  getNews()async{
    News newsclass = News();
    await newsclass.getNews();
    //articles = newsclass.news;
    articles = newsclass.news.where((a) {
  final img = a.urlToImage;
  return img != null &&
         img.startsWith("http") &&
         !img.contains("biztoc.com");
}).toList();

    setState(() {
      _loading = false;
    });
  }

getSlider()async{
  Sliders slider = Sliders();
  await slider.getSlider();
  sliders = slider.sliders;
}






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text("Info"), Text("Update", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        )
        ],
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: _loading? Center(child: CircularProgressIndicator()): SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Container(
              margin: EdgeInsets.only(left: 10.0),
              height: 70,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,  itemBuilder: (context, index){
              return CategoryTile(
                image: categories[index].image,
                 CategoryName: categories[index].categoryName,
                 );
            }),
            ),
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.only(left:10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Breaking News!", style: TextStyle(color: Colors.black,fontSize: 20, fontWeight: FontWeight.bold),),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> AllNews(news: "Breaking",)));
                    },
                    child: Text(
                      "See Now", 
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 18,
                         fontWeight: FontWeight.w500),
                         ),
                  ),
                ],
              ),
            ),
           SizedBox(height: 20,),
            CarouselSlider.builder(
              itemCount: 5,
             itemBuilder: (context, index, realIndex) {
              String? res = sliders[index].urlToImage;
              String? res1 = sliders[index].title;
              return buildImage(res!, index, res1!);
             },
             options: CarouselOptions(
              height: 250, 
              
              autoPlay: true,
              enlargeCenterPage: true, 
              enlargeStrategy: CenterPageEnlargeStrategy.height,
              onPageChanged: (index, reason){
                setState(() {
                  activeIndex = index;
                });
              })),
              SizedBox(height: 20,),
              Center(child: buildIndicator()),
              SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.only(left:10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Trending News!", 
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20, 
                      fontWeight: FontWeight.bold),
                      ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> AllNews(news: "Trending",)));
                    },
                    child: Text(
                      "View All",
                     style: TextStyle(
                      color: Colors.blue,
                      fontSize: 18, 
                      fontWeight: FontWeight.w500),
                      ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
           Container(
            child: ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: articles.length,
              itemBuilder: (context, index){
              return BlogTile(
                // 
                url: articles[index].url ?? '',
  desc: articles[index].description ?? 'No description',
  imageUrl: articles[index].urlToImage ?? 'https://via.placeholder.com/150',
  title: articles[index].title ?? 'No title',
                  );
            
            }),
           )



          ],),
        ),
      ),
    );
  }
   Widget buildImage(String image, int index, String name)=>Container(
    margin: EdgeInsets.symmetric(horizontal: 5),
    child: Stack(
      children: [
       ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: CachedNetworkImage(
          
          height: 250,
          fit: BoxFit.cover, 
          width: MediaQuery.of(context).size.width, imageUrl: image,)
          ),
          Container(
            height: 250,
            padding: EdgeInsets.only(left: 10),
            margin: EdgeInsets.only(top: 170),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.black26,
               borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10), 
                bottomRight: Radius.circular(10)
                )),
        child: Text(
          name, 
          maxLines: 2,
          style: TextStyle(
            color: Colors.white, 
            fontSize: 25, 
            fontWeight: FontWeight.bold),), 
         )
      ],
   ));
Widget buildIndicator()=>AnimatedSmoothIndicator(
    activeIndex: activeIndex,
    count: 5,
    effect: JumpingDotEffect(
      dotHeight: 15,
      dotWidth: 15,
      activeDotColor: Colors.blue,
      dotColor: Colors.black26,
      spacing: 6,
    ),
  );

}
 








class CategoryTile extends StatelessWidget {
 final image, CategoryName;
 CategoryTile({this.image, this.CategoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> CategoryNews(name: CategoryName,)));
      },
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              image, 
              width: 120, 
              height: 70,
              fit: BoxFit.cover,),
          ),
          Container(
             width: 120, 
              height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.black38,
            ),
            
            child: Center(
              child: Text(
                CategoryName, 
                style: TextStyle(
                  color: Colors.white, 
                  fontSize: 16, 
                  fontWeight: FontWeight.w500),)),
          )
        ],),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  String imageUrl, title, desc, url; 

 BlogTile({required this.imageUrl, required this.title, required this.desc, required this.url});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
              onTap:(){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> ArticleView(blogUrl: url,)));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Material(
                  elevation: 3,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Container(  
                         child:  ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage (
                            imageUrl: imageUrl,
                          height: 150, width: 150, 
                          fit: BoxFit.cover, 
                          
                          ))),
                          SizedBox(width: 7,),
                          Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width/1.8,
                                child: Text(
                                  title,
                                  maxLines: 2,
                                 style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 19, 
                                  fontWeight: FontWeight.w500),
                                  ),
                              ),
                              SizedBox(height: 5,),
                               Container(
                                width: MediaQuery.of(context).size.width/1.8,
                                child: Text(
                                  desc,
                                  maxLines: 3,
                                 style: TextStyle(
                                  color: Colors.black38,
                                  fontSize: 17, 
                                  fontWeight: FontWeight.w500),
                                  ),
                              ),
                            ],
                          ),
                      ],),
                    ),
                  ),
                ),
              ),
            );
        
           
  }
}