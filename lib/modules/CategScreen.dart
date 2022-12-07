import 'package:course_flutter/Cubit/ShopLayoutCubit.dart';
import 'package:course_flutter/Cubit/ShopLayoutStates.dart';
import 'package:course_flutter/models/Categories_Model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategScreen extends StatelessWidget {
  const CategScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit,ShopLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) =>  ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => BuildCatItem((ShopLayoutCubit.getObject(context).categModel?.data?.data[index])!),
        separatorBuilder: (context, index) => Container(
            color: Colors.grey,
            child: SizedBox(height: 2.0,)),
        itemCount: (ShopLayoutCubit.getObject(context).categModel?.data?.data.length)!,
      ),
    );
  }
  Widget BuildCatItem(DataModel model){
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Row(
        children: [
          Image(
            image: NetworkImage('${model.image}'),
            width: 80.0,
            height: 80.0,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 20.0,),
          Text('${model.name}',
            style: TextStyle(
              fontSize: 23.0,
              fontWeight: FontWeight.bold,
            ),),
          Spacer(),
          Icon(Icons.arrow_forward_ios)
        ],
      ),
    );
  }
}
