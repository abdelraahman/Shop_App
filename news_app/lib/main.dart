import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Network/local/shared_prefrence.dart';
import 'package:news_app/Network/remote/dio_helper.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/layout/news_layout.dart';
import 'package:hexcolor/hexcolor.dart';

import 'layout/cubit/cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
   await CacheHelper.init();
   bool? isDark  = CacheHelper.getDarkMaode('dark');
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
//  final bool dark;

  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>NewsAppCubit()..changeModeTheme(),
      child: BlocConsumer<NewsAppCubit,NewsStates>(
        builder: (context,state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: AppBarTheme(
                //backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                ),
                color: Colors.white,
                elevation: 0.0,
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.orange,
                elevation: 20.0,
              ),
            ),
            darkTheme:ThemeData(
              scaffoldBackgroundColor: HexColor('#3A3B3C'),
              appBarTheme: AppBarTheme(
                //backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: HexColor('#3A3B3C'),
                  statusBarIconBrightness: Brightness.light,
                ),
                color:HexColor('#3A3B3C'),
                elevation: 0.0,
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                iconTheme: IconThemeData(
                  color: Colors.white,
                ),
              ),
              bottomNavigationBarTheme:  BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.orange,
                elevation: 20.0,
                backgroundColor: HexColor('#3A3B3C'),
                unselectedItemColor: Colors.white,
              ),
            ),
            themeMode:NewsAppCubit.get(context).modeTheme? ThemeMode.dark: ThemeMode.light,
            home: newsLayout(),
          );
        },
        listener: (context,state){},
      ),
    );

  }
}
