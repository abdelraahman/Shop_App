import 'package:course_flutter/Cache_Helper.dart';
import 'package:course_flutter/modules/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class boardingModel{
  final String image;
  final String title;
  final String body;

  boardingModel(this.image, this.title, this.body);
}
class onBoardingScreen extends StatefulWidget {
   onBoardingScreen({Key? key}) : super(key: key);

  @override
  State<onBoardingScreen> createState() => _onBoardingScreenState();
}

class _onBoardingScreenState extends State<onBoardingScreen> {
  List<boardingModel> boarding = [
    boardingModel('images/shop1.png','Screen Title 1','Screen Body'),
    boardingModel('images/shop5.png','Screen Title 2','Screen Body'),
    boardingModel('images/shop4.png','Screen Title 3','Screen Body'),
  ];

  var boardController = PageController();
  bool lastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextButton(
                onPressed: (){
                  submit();
                },
                child: Text(
                    'SKIP',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ),
            Expanded(
              child: PageView.builder(
                controller: boardController,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context,index)=> buildBoardingItem(index),
                itemCount: 3,
                onPageChanged: (index){
                  if(index == boarding.length-1){
                    setState(() {
                      lastPage = true;
                    });
                  }else{
                    setState(() {
                      lastPage = false;
                    });
                  }

                },
              ),
            ),
            SizedBox(height: 50.0,),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: boarding.length,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: Colors.deepOrange,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                    onPressed: (){
                      if(lastPage){
                        submit();

                      }
                      else{
                        lastPage = false;
                        boardController.nextPage(
                          duration: Duration(microseconds: 800),
                          curve: Curves.linear,
                        );
                      }
                    },
                  child: Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ],
        ),
      ),

    );
  }

  void submit(){
    cacheHelper.saveDataInSharedPref(key: 'onBoard', value: true).then((value){
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context)=> loginScreen()),
              (route) => false);
    });


  }

  Widget buildBoardingItem(index) =>Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
  Expanded(
  child: Image(
  image: AssetImage('${boarding[index].image}'),
  ),
  ),
  SizedBox(
  height: 10.0,
  ),
  Text(
  '${boarding[index].title}',
  style: TextStyle(
  fontSize: 25.0,
  fontWeight: FontWeight.bold,
  ),
  ),
  SizedBox(
  height: 30.0,
  ),
  Text(
  '${boarding[index].body}',
  style: TextStyle(
  fontSize: 14.0,
  fontWeight: FontWeight.bold,
  ),
  ),
  ],
  );
}
