import 'package:course_flutter/Cache_Helper.dart';
import 'package:course_flutter/Cubit/SearchStates.dart';
import 'package:course_flutter/DioHelper.dart';
import 'package:course_flutter/models/SearchModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchState>{
  SearchCubit(): super(SearchInitialState());
  static SearchCubit getObject(context) => BlocProvider.of(context);

  SearchModel? searchModel;
  void Search(String text){
    emit(SearchLoadingState());
    DioHelper.PostData(
        url: 'products/search',
        token: cacheHelper.getData(key: 'token'),
        data: {
          'text':text,
        }).then((value) {
          searchModel = SearchModel.fromJson(value.data);
          print(searchModel?.status);
          emit(SearchSuccessState());

    }).catchError((onError){
      print(onError.toString());
      emit(SearchErrorState());

    });
  }
}