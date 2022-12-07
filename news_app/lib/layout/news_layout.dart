import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Network/remote/dio_helper.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/cubit/states.dart';

class newsLayout extends StatelessWidget {
  const newsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>NewsAppCubit()..getDataFromApi() ,
      child: BlocConsumer<NewsAppCubit,NewsStates>(
        listener: (BuildContext context, state) {  },
        builder: (BuildContext context, Object? state) {
          var cubit = NewsAppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text('News App'),
              actions: [
                IconButton(onPressed: (){}, icon: Icon(Icons.search)),
                IconButton(onPressed: (){
                  NewsAppCubit.get(context).changeModeTheme();
                  print('dark Mode ${NewsAppCubit.get(context).modeTheme}');
               //   print(NewsAppCubit.get(context).modeTheme);
                }, icon:NewsAppCubit.get(context).modeTheme? Icon(Icons.brightness_2):Icon(Icons.brightness_4_outlined)),
              ],
            ),
            body: cubit.Screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              items:cubit.bottomItems,
              currentIndex: cubit.currentIndex,
              onTap: (index){
                cubit.SetCurrentIndex(index);
              },
            ),
          );
        },

      ),
    );
  }
}
