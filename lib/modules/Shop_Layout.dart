import 'package:course_flutter/Cache_Helper.dart';
import 'package:course_flutter/Cubit/ShopLayoutCubit.dart';
import 'package:course_flutter/Cubit/ShopLayoutStates.dart';
import 'package:course_flutter/modules/Search_Screen.dart';
import 'package:course_flutter/modules/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Cubit/ThemeCubit.dart';


class ShopLayoutScreen extends StatelessWidget {
  //const ShopLayoutScreen({Key? key, this.ShopLoginModelData}) : super(key: key);
  //final ShopLoginModelData shop;

 ShopLayoutScreen();

  @override
  Widget build(BuildContext context) {
    themeCubit theme = themeCubit.getObject(context);
    ShopLayoutCubit shopCubit = ShopLayoutCubit.getObject(context);
    return BlocConsumer<ShopLayoutCubit,ShopLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: Text('Bebo Shop',style: TextStyle(color: Colors.deepOrange),),
          actions: [
            IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen(),));
            }, icon: Icon(Icons.search_outlined),color: Colors.deepOrange,),
            IconButton(onPressed: (){
              theme.changeTheme();
            }, icon:cacheHelper.getData(key: 'isDark')? Icon(Icons.brightness_2_outlined):Icon(Icons.brightness_2),color: Colors.deepOrange,),
            IconButton(onPressed: (){
              cacheHelper.clearDataFromSharedPref(key: 'token').then((value) {
                Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: (context) => loginScreen(),),
                        (route) => false);
              });
            },
                icon: Icon(Icons.logout),color: Colors.deepOrange,),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items:shopCubit.BottomNavigationBarItems,
          currentIndex:shopCubit.currentIndex ,
          onTap: (index){
            shopCubit.ChangeIndex(index);
          },
        ),
        body: shopCubit.BottomNavBarScreens[shopCubit.currentIndex],
      ),

    );
  }
}
