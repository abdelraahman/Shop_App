import 'package:bloc/bloc.dart';
import 'package:course_flutter/Cache_Helper.dart';
import 'package:course_flutter/Cubit/ThemeStates.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class themeCubit extends Cubit<themeStates>{
  themeCubit():super(initialThemeState());
  static themeCubit getObject(context) => BlocProvider.of<themeCubit>(context);

  bool isDark = false;
  bool getIsDark(){return isDark;}
  void changeTheme({
  bool? fromShared
}){
    if(fromShared != null){
      isDark = fromShared;
    }else{
      isDark = !isDark;
      print('$isDark');
      cacheHelper.putData(key: 'isDark', value: isDark).then((value) {
        emit(themeChangeState());
      });
    }

  }



}