import 'package:flutter/material.dart';

class MessengerScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        titleSpacing: 20.0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20.0,
              backgroundImage: NetworkImage('https://th.bing.com/th/id/OIP.nY2KOPHT4vy6gX0NPiINqgHaFh?pid=ImgDet&rs=1'),
            ),
            SizedBox(width: 10.0,),
            Text('Chats',style: TextStyle(
              color: Colors.black,
              fontSize: 23.0,
            ),),
          ],
        ),
        actions: [
         IconButton(
             onPressed: (){},
             icon: CircleAvatar(
               //radius: 10.0,
               backgroundColor: Colors.black,
               child:Icon(
                   Icons.camera_alt,
                 size: 17.0,
                 color: Colors.white,
               ) ,
             ),
         ),
          IconButton(
            onPressed: (){},
            icon: CircleAvatar(
              //radius: 10.0,
              backgroundColor: Colors.black,
              child:Icon(
                Icons.edit,
                size: 17.0,
                color: Colors.white,
              ) ,
            ),
          ),
        ],

      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(5.0,),
                  color: Colors.grey[300],
                ),
                child: Row(
                  children: [
                    Icon(Icons.search),
                    SizedBox(width: 10.0,),
                    Text("Search"),
                  ],
                ),
              ),
              SizedBox(height: 20.0,),
              Container(
                height: 100.0,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                    itemBuilder: (context,index)=> BuildStoryItem(),
                    separatorBuilder: (context,index)=> SizedBox(width: 10.0,),
                    itemCount: 10,
                ),
              ),
              SizedBox(height: 20.0,),
              ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context,index)=>BuildChatItem(),
                  separatorBuilder: (context,index)=>SizedBox(height: 10.0,),
                  itemCount: 20,
              ),


            ],
          ),
        ),
      ),
    );
  }
  Widget BuildChatItem() => Row(
    children: [
      Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          CircleAvatar(
            radius: 25.0,
            backgroundImage: NetworkImage('https://th.bing.com/th/id/OIP.nY2KOPHT4vy6gX0NPiINqgHaFh?pid=ImgDet&rs=1'),
          ),
          CircleAvatar(
            radius: 8.0,
            backgroundColor: Colors.lightGreen,
          )
        ],
      ),
      SizedBox(width: 20.0,),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Bebo Ayman",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                Expanded(child: Text("what are you doing?",style: TextStyle(color: Colors.grey),),),
                SizedBox(width: 10.0,),
                Expanded(child: Text("11.30")),
              ],
            ),
          ],
        ),
      )
    ],

  );
  Widget BuildStoryItem() => Container(
    width: 50.0,
    child: Column(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            CircleAvatar(
              radius: 25.0,
              backgroundImage: NetworkImage('https://th.bing.com/th/id/OIP.nY2KOPHT4vy6gX0NPiINqgHaFh?pid=ImgDet&rs=1'),
            ),
            CircleAvatar(
              radius: 8.0,
              backgroundColor: Colors.lightGreen,
            )
          ],
        ),
        SizedBox(height: 8.0,),
        Text("Bebo Ayman",
          maxLines: 2,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ),
  );
}
