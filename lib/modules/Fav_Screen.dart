import 'package:course_flutter/Cubit/ShopLayoutStates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Cubit/ShopLayoutCubit.dart';
import '../models/Fav_Model_Layout.dart';

class FavScreen extends StatelessWidget {
  const FavScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit,ShopLayoutStates>(
      listener:(context, state) {},
      builder: (context, state) {
        int? len = ShopLayoutCubit.getObject(context).favModel?.data?.data.length;
        return ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) =>  buildFavItem((ShopLayoutCubit.getObject(context).favModel)!,index,context),
          separatorBuilder: (context, index) => Container(
              color: Colors.grey,
              child: SizedBox(height: 2.0,)),
          itemCount: len!,
        );

      }
    //  buildFavItem((ShopLayoutCubit.getObject(context).favModel)!,index,context),
    );
  }
  Widget buildFavItem(Fav_Model favModel, index,context)=> Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
     // color: Colors.white,
      child: Container(
        height: 120.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              //height: 100.0,
              child: Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                      width: 120.0,
                      height: 120.0,
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        '${favModel.data?.data[index].product?.image}',
                      )
                  ),
                 if(favModel.data?.data[index].product?.discount != 0)
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
            ),
            SizedBox(width: 20.0,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${favModel.data?.data[index].product?.name}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,

                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        '${favModel.data?.data[index].product?.price}\$',
                        style: TextStyle(
                          color: Colors.deepOrange,
                          fontWeight: FontWeight.bold,
                        ),

                      ),
                      SizedBox(width: 5.0,),
                      if(favModel.data?.data[index].product?.discount!= 0)
                        Text(
                          '${favModel.data?.data[index].product?.price}\$',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.lineThrough,
                          ),

                        ),
                      Spacer(),
                      IconButton(
                        color: Colors.deepOrange,
                        onPressed: (){
                          int? id = favModel.data?.data[index].product?.id;
                          print(id);
                          ShopLayoutCubit.getObject(context).AddProdToFav(id!);
                          print('fav prod is....');
                          // print(ShopLayoutCubit.getObject(context).favList[ShopModel?.data?.productsData[index].id]);
                        },
                        icon:(ShopLayoutCubit.getObject(context).favList[favModel.data?.data[index].product?.id])!? Icon(Icons.favorite,):Icon(Icons.favorite_border,),

                      ),
                    ],
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    ),
  );
}
