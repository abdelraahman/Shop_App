import 'package:course_flutter/Cubit/ShopLoginStates.dart';
import 'package:course_flutter/Cubit/ShopRegisterStates.dart';
import 'package:course_flutter/DioHelper.dart';
import 'package:course_flutter/end_points.dart';
import 'package:course_flutter/models/ShopLoginModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopRegCubit extends Cubit<ShopRegState>{
  ShopRegCubit(): super(ShopRegInitialState());
  static ShopRegCubit getObject(context) => BlocProvider.of<ShopRegCubit>(context);

  ShopLoginModelData ?loginModel;

  void userReg({
    required String email,
    required String userName,
    required String password,
    required String phone,
  }){
    emit(ShopRegLoadingState());
    DioHelper.PostData(
        url: REGISTER,
        data: {
          'email':email,
          'password':password,
          'name':userName,
          'phone':phone,
        }).then((value){
      //print(value.data);
      loginModel =  ShopLoginModelData.fromJson(value.data);
      emit(ShopRegsuccessState(loginModel));
    }).catchError((onError){
      print(onError.toString());
      emit(ShopRegErrorState(onError.toString()));
    });

  }

}