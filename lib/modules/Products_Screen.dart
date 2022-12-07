import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:course_flutter/Cubit/ShopLayoutCubit.dart';
import 'package:course_flutter/Cubit/ShopLayoutStates.dart';
import 'package:course_flutter/models/ShopLayoutModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit,ShopLayoutStates>(
        listener: (context, state) {},
         builder: (context, state){
          ShopLayoutModel? ShopModel =  ShopLayoutCubit.getObject(context).ShopModel;
          int? len = ShopModel?.data?.productsData.length;
          int? lenBan = ShopModel?.data?.bannersdata.length;
          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: ConditionalBuilder(
                condition: ShopModel != null,
                builder:(context) => ProductItem(ShopModel,len,lenBan,context) ,
                fallback:(context) =>  Center(child: CircularProgressIndicator()),
            ),
          );
         },
    );
  }
  Widget ProductItem(ShopLayoutModel? ShopModel,int? len, int? lenBan,context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
            items: List.generate(lenBan!, (index) =>Image(
              image: NetworkImage('${ShopModel?.data?.bannersdata[index].image}'),
              width: double.infinity,
              fit: BoxFit.cover,
            ) ),

         /*   ShopModel?.data?.bannersdata.map((e) =>  Image(
              image: NetworkImage('${e.image}'),
              width: double.infinity,
              fit: BoxFit.cover,
            )).toList(),*/
            options: CarouselOptions(
              height: 250.0,
              initialPage: 0,
              viewportFraction: 1.0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(seconds: 3),
              autoPlayCurve: Curves.fastLinearToSlowEaseIn,
              scrollDirection: Axis.horizontal,

            )
        ),
        SizedBox(height: 20.0,),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Categories',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),),
              SizedBox(height: 10.0,),
              Container(
                height: 100.0,
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => buildCategItem(context,index),
                    separatorBuilder: (context, index) => SizedBox(width: 10.0,),
                    itemCount: (ShopLayoutCubit.getObject(context).categModel?.data?.data.length)!
                ),
              ),
              SizedBox(height: 12.0,),
              Text('New Products',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),),
            ],
          ),
        ),
        SizedBox(height: 5.0,),
        Container(
         // color:HexColor('333739'),
          color: Colors.grey[300],
          child: GridView.count(
            shrinkWrap: true,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            childAspectRatio: 1/1.7,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            children: List.generate(len!, (index) => GridViewItem(ShopModel, index,context)),
    ),

    ),
    ]
    );

  }
  Widget buildCategItem(context,index)=>Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children: [
      Image(
        image: NetworkImage(
          '${(ShopLayoutCubit.getObject(context).categModel?.data?.data[index].image)}',
        ),
        width: 100.0,
        height: 100.0,
        fit: BoxFit.cover,
      ),
      Container(
        color: Colors.black.withOpacity(.8),
        width: 100.0,
        child: Text(
          '${(ShopLayoutCubit.getObject(context).categModel?.data?.data[index].name)}',
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    ],
  );
  Widget GridViewItem(ShopLayoutModel? ShopModel,int index,context){
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                width: double.infinity,
                  height: 200.0,
                  image: NetworkImage('${ShopModel?.data?.productsData[index].image}',
              )
              ),
              if(ShopModel?.data?.productsData[index].discount != 0)
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text("Discount",
                style: TextStyle(
                  backgroundColor: Colors.red,
                  color: Colors.white,
                  fontSize: 15.0,
                ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${ShopModel?.data?.productsData[index].name}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,

                ),
                SizedBox(height: 8.0),
                Row(
                  children: [
                    Text(
                      '${ShopModel?.data?.productsData[index].price}\$',
                      style: TextStyle(
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.bold,
                      ),

                    ),
                    SizedBox(width: 5.0,),
                    if(ShopModel?.data?.productsData[index].discount != 0)
                    Text(
                      '${ShopModel?.data?.productsData[index].oldPrice}\$',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.lineThrough,
                      ),

                    ),
                  ],
                ),
                IconButton(
                  color: Colors.deepOrange,
                  onPressed: (){
                    int? id = ShopModel?.data?.productsData[index].id;
                    print(id);
                    ShopLayoutCubit.getObject(context).AddProdToFav(id!);
                    print('fav prod is....');
                    print(ShopLayoutCubit.getObject(context).favList[ShopModel?.data?.productsData[index].id]);
                  },
                  icon:(ShopLayoutCubit.getObject(context).favList[ShopModel?.data?.productsData[index].id])!? Icon(Icons.favorite,):Icon(Icons.favorite_border,),

                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
