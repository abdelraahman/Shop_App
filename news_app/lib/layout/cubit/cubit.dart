import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Network/local/shared_prefrence.dart';
import 'package:news_app/Network/remote/dio_helper.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/modules/settings.dart';

import '../../modules/business.dart';
import '../../modules/sciences.dart';
import '../../modules/sports.dart';

class NewsAppCubit extends Cubit<NewsStates>{
  NewsAppCubit():super(NewsinitialState());
  static NewsAppCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> Screens=[
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
    SettingScreen(),
  ];
  List<BottomNavigationBarItem> bottomItems =[
    BottomNavigationBarItem(
        label: "Business",
        icon: Icon(Icons.business_center),
    ),
    BottomNavigationBarItem(
      label: "Sports",
      icon: Icon(Icons.sports),
    ),
    BottomNavigationBarItem(
      label: "Science",
      icon: Icon(Icons.science),
    ),
    BottomNavigationBarItem(
      label: "Setting",
      icon: Icon(Icons.settings),
    ),
  ];

  List <dynamic> Users = [];

  void SetCurrentIndex(index){
    currentIndex = index;
    emit(NewsBottomNavBar());
  }

  void getDataFromApi(){
    emit(LoadingNews());
      DioHelper.getData().then((value) {
      Users = value.data['articles'];
      print(Users[1]['title']);
      emit(GetNewsDataSuccess());
    }).catchError((error){
      print("error hna");
      emit(GetNewsDataError());
      print(error.toString());}
    );
  }
  bool modeTheme = false;
  void changeModeTheme({fromShared}){
    if(fromShared != null){
      modeTheme = fromShared;
    }else{
      modeTheme = !modeTheme;
    }
    CacheHelper.setDarkMode('dark', modeTheme).then((value) {
      emit(ChangeModeLight());
    });

    //print('dark Mode $modeTheme');
    emit(ChangeModeLight());
  }

}