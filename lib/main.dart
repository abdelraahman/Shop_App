import 'package:course_flutter/Cache_Helper.dart';
import 'package:course_flutter/Cubit/ShopLayoutCubit.dart';
import 'package:course_flutter/Cubit/ThemeStates.dart';
import 'package:course_flutter/DioHelper.dart';
import 'package:course_flutter/Themes.dart';
import 'package:course_flutter/modules/Shop_Layout.dart';
import 'package:course_flutter/modules/login_screen.dart';
import 'package:course_flutter/modules/on_boarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Cubit/ThemeCubit.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
   await cacheHelper.init();
   DioHelper.init();
   bool? isDark = cacheHelper.getData(key: 'isDark');
   bool? onBoard = cacheHelper.getData(key: 'onBoard');
   String? token = cacheHelper.getData(key: 'token');
   Widget? startWidget;
   print(onBoard);
   if(onBoard == true){
     if(token != null){
       startWidget = ShopLayoutScreen();
     }else{
       startWidget = loginScreen();
     }
   }else{
     startWidget = onBoardingScreen();
   }

  runApp(
    MultiBlocProvider(
        providers: [
          BlocProvider(create:(context)=>themeCubit()..changeTheme(fromShared: isDark)),
          BlocProvider(create: (context) => ShopLayoutCubit()..GetDataForShopLayout()..GetDataForCategLayout()..GetDataForFavLayout()..GetDataForProfileLayout(),),
        ],
        child: MyApp(isDark,startWidget),
    )
  );
}

class MyApp extends StatelessWidget {
  //const MyApp({super.key});
  final bool? isDark;
  final Widget startWidget;

  MyApp(this.isDark, this.startWidget);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<themeCubit,themeStates>(
      listener: (context,state){},
      builder: (context,state){
        themeCubit theme = themeCubit.getObject(context);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: theme.isDark?darkTheme:lightTheme,
          home: startWidget,
        );
      },
    );
  }
}

