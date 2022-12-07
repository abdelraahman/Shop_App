import 'package:bloc/bloc.dart';
import 'package:course_flutter/Cache_Helper.dart';
import 'package:course_flutter/Cubit/ShopLayoutStates.dart';
import 'package:course_flutter/DioHelper.dart';
import 'package:course_flutter/models/Categories_Model.dart';
import 'package:course_flutter/models/ShopLayoutModel.dart';
import 'package:course_flutter/models/ShopLoginModel.dart';
import 'package:course_flutter/modules/CategScreen.dart';
import 'package:course_flutter/modules/Fav_Screen.dart';
import 'package:course_flutter/modules/Products_Screen.dart';
import 'package:course_flutter/modules/Setting_Screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../end_points.dart';
import '../models/Fav_Model.dart';
import '../models/Fav_Model_Layout.dart';

class ShopLayoutCubit extends Cubit<ShopLayoutStates>{

  ShopLayoutCubit():super(ShopLayoutInitialState());
  static ShopLayoutCubit getObject(context) => BlocProvider.of<ShopLayoutCubit>(context);
   int currentIndex = 0;
   List<Widget> BottomNavBarScreens =
   [
     ProductsScreen(),
     CategScreen(),
     FavScreen(),
     SettingScreen(),
   ];
   List<BottomNavigationBarItem> BottomNavigationBarItems=[
     BottomNavigationBarItem(
         icon: Icon(Icons.home),
         label: 'Home'
     ),
     BottomNavigationBarItem(
         icon: Icon(Icons.apps),
         label: 'Categories'
     ),
     BottomNavigationBarItem(
         icon: Icon(Icons.favorite),
         label: 'favorite'
     ),
     BottomNavigationBarItem(
         icon: Icon(Icons.settings),
         label: 'setting'
     ),
   ];
    void ChangeIndex(index){
      currentIndex = index;
      emit(ShopLayoutChangeState());
    }
    Map<int? , bool? > favList={};
    ShopLayoutModel? ShopModel;
    void GetDataForShopLayout(){
      emit(ShopLayoutInitialState());
      DioHelper.GetData(url: HOME,token: cacheHelper.getData(key: 'token')).then((value) {
        ShopModel = ShopLayoutModel.fromJson(value.data);
        ShopModel?.data?.productsData.forEach((element) {
         favList.addAll({
            element?.id:element?.inFav
          });

        });
        print(favList.toString());
        print(ShopModel?.status);
        print(cacheHelper.getData(key: 'token'));
        emit(ShopLayoutSuccessState());
      }).catchError((onError){
        print("fe error hna $onError");
        emit(ShopLayoutErrorState(onError));
      });
    }


  FavModel? ChangeFavModel;
   void AddProdToFav(int productId){
     favList[productId!] =!(favList[productId!])!;
     emit(ShopLayoutAfterAddState());
      DioHelper.PostData(
          url: Favorites,
          data: {
            'product_id':productId,
          },
        token: cacheHelper.getData(key:'token'),
      ).then((value) {
        //print('Result After Add product');
        print(value.data['status']);
        print(value.data['message']);
        ChangeFavModel = FavModel.fromJson(value.data);
        if(!(ChangeFavModel?.status)!){
            favList[productId] = ! (favList[productId])!;
        }else{
          GetDataForFavLayout();
        }
        emit(ShopLayoutAfterAddState());
      }).catchError((error){
        print('error fe add to fav');
        print(error);
        favList[productId] = ! (favList[productId])!;
        emit(ShopLayoutErrorAddState());
      });
    }

  Fav_Model? favModel;
  void GetDataForFavLayout(){
    emit(FavLayoutLoadingState());
    DioHelper.GetData(
        url:Favorites,
        token:cacheHelper.getData(key:'token')).then((value) {
      favModel = Fav_Model.fromJson(value.data);
      print('wasl fe fav list status is ${favModel?.status}');
      print(favModel?.message);
      print(favModel?.data);
      emit(FavLayoutSuccessState());
    }).catchError((onError){
      print("fe error hna $onError");
      emit(FavLayoutErrorState());
    });
  }

  CategoriesModel? categModel;
  void GetDataForCategLayout(){
    DioHelper.GetData(
        url: Categories,
        token: cacheHelper.getData(key: 'token')).then((value) {
      categModel = CategoriesModel.fromJson(value.data);
      print(categModel?.status);
      emit(CategLayoutSuccessState());
    }).catchError((onError){
      print("fe error fe Categories $onError");
      emit(CategLayoutErrorState(onError));
    });
  }

  ShopLoginModelData? userData;
  void GetDataForProfileLayout(){
    emit(ProfileLoadingState());
    DioHelper.GetData(
        url: PROFILE,
        token: cacheHelper.getData(key: 'token'),
    ).then((value) {
      userData = ShopLoginModelData.fromJson(value.data);
      print(userData?.status);
      emit(ProfileSuccessState());
    }).catchError((onError){
      print("fe error fe Categories $onError");
      emit(ProfileErrorState());
    });
  }

  ShopLoginModelData? userDataUpdate;
  void updateProfileDataLayout(
      @required String name,
      @required String email,
      @required String phone,

      ){
    emit(UpdateProfileLoadingState());
    DioHelper.PutData(
      url: updateProfile,
      data: {
        'name':name,
        'phone':email,
        'email':phone,
      },
      token: cacheHelper.getData(key: 'token'),
    ).then((value) {
      userDataUpdate = ShopLoginModelData.fromJson(value.data);
      print(userDataUpdate?.status);
      emit(UpdateProfileSuccessState());
    }).catchError((onError){
      print("fe error fe Categories $onError");
      emit(UpdateProfileErrorState());
    });
  }


}