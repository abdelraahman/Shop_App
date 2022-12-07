import 'package:course_flutter/Cubit/ShopLoginStates.dart';
import 'package:course_flutter/DioHelper.dart';
import 'package:course_flutter/end_points.dart';
import 'package:course_flutter/models/ShopLoginModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopLoginCubit extends Cubit<ShopLoginState>{
  ShopLoginCubit(): super(ShopLoginInitialState());
  static ShopLoginCubit getObject(context) => BlocProvider.of<ShopLoginCubit>(context);

   ShopLoginModelData ?loginModel;

  void userLogin({
    required String email,
    required String password,
}){
    emit(ShopLoginLoadingState());
    DioHelper.PostData(
        url: LOGIN,
        data: {
          'email':email,
          'password':password,
        }).then((value){
           //print(value.data);
          loginModel =  ShopLoginModelData.fromJson(value.data);
           emit(ShopLoginsuccessState(loginModel));
    }).catchError((onError){
      print(onError.toString());
      emit(ShopLoginErrorState(onError.toString()));
    });

  }

}