import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildArticleItem(list) => Padding(
  padding: const EdgeInsets.all(10.0),
  child: Row(
    children: [
      Container(
        width: 120.0,
        height: 120.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          image: DecorationImage(image: NetworkImage("${list['urlToImage']}"),
            fit: BoxFit.cover,
          ),

        ),
      ),
      SizedBox(width: 20.0,),
      Expanded(
        child: Container(
          height: 120.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
            [
              Expanded(
                child: Text(
                  '${list['title']}',
                  maxLines: 4,
                  style: TextStyle(

                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                '${list['publishedAt']}',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),


            ],
          ),
        ),
      ),
    ],
  ),
);