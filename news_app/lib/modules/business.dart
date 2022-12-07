import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/cubit/states.dart';

import '../component/component.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsAppCubit,NewsStates>(
      builder: (BuildContext context, Object? state) {
        var list = NewsAppCubit.get(context).Users;
       return ConditionalBuilder(
          condition: (state is! LoadingNews),
          builder: (context) =>ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => buildArticleItem(list[index]),
              separatorBuilder: (context, index) =>
                  Container(height: 20.0,),
              itemCount: list.length),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );

      },
      listener: ( BuildContext context, Object? state){},
    );
  }
}
