import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.menu,
        ),
        title: Text('Bebo',
          // style: TextStyle(color: Colors.limeAccent),
        ),
        actions: [
          IconButton(onPressed: (){print('notification');}, icon: Icon(Icons.notifications)),
          IconButton(onPressed: (){print('search');}, icon:  Icon(Icons.search),),
        ],
        backgroundColor: Colors.indigo ,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
              ),
             // clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Image(image: NetworkImage('https://th.bing.com/th/id/OIP.nY2KOPHT4vy6gX0NPiINqgHaFh?pid=ImgDet&rs=1'),),
                  Container(
                    color: Colors.black.withOpacity(0.7),
                    width: double.infinity,
                    child: Text(
                        'AUDI',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize:25.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
              ),
             // clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Image(image: NetworkImage('https://images.carid.com/inspiration/bmw/3-series/251/1.jpg'),),
                  Container(
                    color: Colors.black.withOpacity(0.7),
                    width: double.infinity,
                    child: Text(
                      'BMW',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize:25.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //Image(image: NetworkImage('https://th.bing.com/th/id/OIP.nY2KOPHT4vy6gX0NPiINqgHaFh?pid=ImgDet&rs=1'),),
           // Image(image: NetworkImage('https://th.bing.com/th/id/OIP.nY2KOPHT4vy6gX0NPiINqgHaFh?pid=ImgDet&rs=1'),),

          ],
        ),
      ),
    );
  }
}
